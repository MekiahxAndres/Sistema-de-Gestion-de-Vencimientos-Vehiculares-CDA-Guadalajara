SET SERVEROUTPUT ON;
/*
   FUNCIÓN: FN_CALC_EXPIRY_DATE
   -------------------------------------------
   Objetivo:
   Dada una fecha de servicio y el tipo de servicio (RTM, DIAG, ALIN, ...),
   calcula la fecha de vencimiento del documento asociado.

   Reglas:
     - RTM  -> vence 12 meses después.
     - DIAG -> vence 3 meses después.
     - ALIN -> vence 6 meses después.
     - Otros tipos -> misma fecha del servicio.
*/
CREATE OR REPLACE FUNCTION fn_calc_expiry_date (
    p_service_kinds_id IN services_kinds.id%TYPE,
    p_service_date     IN services.service_date%TYPE
) RETURN DATE
IS
    v_expiry_date DATE;
BEGIN
    CASE p_service_kinds_id
        WHEN 'RTM'  THEN v_expiry_date := ADD_MONTHS(p_service_date, 12);
        WHEN 'DIAG' THEN v_expiry_date := ADD_MONTHS(p_service_date,  3);
        WHEN 'ALIN' THEN v_expiry_date := ADD_MONTHS(p_service_date,  6);
        ELSE             v_expiry_date := p_service_date;
    END CASE;

    RETURN v_expiry_date;
END;
/
SHOW ERRORS FUNCTION fn_calc_expiry_date;

-------------------------------------------------------------------------------
--(BLOQUE ANÓNIMO)
-------------------------------------------------------------------------------
DECLARE
    v_fecha DATE;
BEGIN
    -- RTM hecha el 15/01/2025 → debería sumar 12 meses
    v_fecha := fn_calc_expiry_date('RTM', DATE '2025-01-15');

    DBMS_OUTPUT.PUT_LINE(
        'Vencimiento RTM 2025-01-15 = ' || TO_CHAR(v_fecha, 'YYYY-MM-DD')
    );
END;
/


/*
   TRIGGER: TRG_DOCUMENTS_STATUS_NAME
   -------------------------------------------
   Objetivo:
   Mantener consistente el campo STATUS_DOCUMENT_NAME de la tabla DOCUMENTS.

   Comportamiento:
   - BEFORE INSERT o UPDATE en DOCUMENTS.
   - Dado :NEW.STATUS_DOCUMENT_ID, busca el nombre en STATUS_DOCUMENT
     y lo copia a :NEW.STATUS_DOCUMENT_NAME.
   - Si el ID no existe, lanza un error de negocio (-20020).
*/
CREATE OR REPLACE TRIGGER trg_documents_status_name
BEFORE INSERT OR UPDATE ON documents
FOR EACH ROW
DECLARE
    v_name status_document.name%TYPE;
BEGIN
    IF :NEW.status_document_id IS NOT NULL THEN
        BEGIN
            SELECT sd.name
            INTO   v_name
            FROM   status_document sd
            WHERE  sd.id = :NEW.status_document_id;

            :NEW.status_document_name := v_name;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(
                    -20020,
                    'Estado de documento inválido para ID = ' ||
                    :NEW.status_document_id
                );
        END;
    END IF;
END;
/
SHOW ERRORS TRIGGER trg_documents_status_name;

-------------------------------------------------------------------------------
-- LIMPIEZA PREVIA DE PRUEBAS
-------------------------------------------------------------------------------
DELETE FROM documents WHERE id IN ('D200','D201');
DELETE FROM services  WHERE id = 'S200';
COMMIT;

-------------------------------------------------------------------------------
--(BLOQUE ANÓNIMO)
-------------------------------------------------------------------------------
/*
   Insertamos un documento D201 indicando solo el STATUS_DOCUMENT_ID = 'VIG'.
   El trigger debe rellenar STATUS_DOCUMENT_NAME automáticamente.
   No usamos SERVICE_ID para no depender de un servicio previo.
*/
BEGIN
    INSERT INTO documents (
        id, issue_date, expiry_date, source,
        vehicle_plate, service_id,
        status_document_id   -- NO enviamos el NAME
    ) VALUES (
        'D201',
        DATE '2025-03-01',
        DATE '2026-03-01',
        'RTM',
        'ABC101',   -- placa existente
        NULL,       -- sin FK a SERVICES, solo probamos el trigger
        'VIG'       -- debe existir en STATUS_DOCUMENT.id
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Documento D201 insertado (prueba trigger).');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en prueba trigger: ' || SQLERRM);
END;
/

-- Verificar que el trigger copió el nombre del estado
SELECT id,
       status_document_id,
       status_document_name
FROM documents
WHERE id = 'D201';


/*
   PROCEDIMIENTO: SP_REGISTRAR_SERVICIO_Y_DOCUMENTO
   -------------------------------------------
   Objetivo:
   Registrar en una sola operación:
     1) Un servicio en la tabla SERVICES.
     2) El documento asociado en la tabla DOCUMENTS, calculando
        automáticamente la fecha de vencimiento con FN_CALC_EXPIRY_DATE
        y el estado del documento según el resultado del servicio.

   Reglas para el estado del documento:
     - Si RESULT = 'APROBADO'  -> STATUS_DOCUMENT_ID = 'VIG'
     - Si RESULT = 'RECHAZADO' -> STATUS_DOCUMENT_ID = 'VEN'
     - En otros casos           -> STATUS_DOCUMENT_ID = 'PRO'

   Supuestos:
     - Existen filas en STATUS_DOCUMENT con IDs: 'VIG', 'VEN', 'PRO'.
     - Existen tipos de servicio en SERVICES_KINDS: 'RTM', 'DIAG', 'ALIN', etc.
     - El vehículo (p_vehicle_plate) existe en VEHICLES.

   Nota:
     Gracias al trigger TRG_DOCUMENTS_STATUS_NAME, sólo se envía
     STATUS_DOCUMENT_ID; el campo STATUS_DOCUMENT_NAME se rellena
     automáticamente.
*/
CREATE OR REPLACE PROCEDURE sp_registrar_servicio_y_documento (

    p_service_id        IN services.id%TYPE,
    p_service_date      IN services.service_date%TYPE,
    p_result            IN services.result%TYPE,
    p_notes             IN services.notes%TYPE,
    p_odometer_km       IN services.odometer_km%TYPE,
    p_service_kinds_id  IN services.service_kinds_id%TYPE,
    p_vehicle_plate     IN services.vehicles_plate%TYPE,


    p_document_id       IN documents.id%TYPE,
    p_source            IN documents.source%TYPE
)
IS
    v_expiry_date   DATE;
    v_status_doc_id status_document.id%TYPE;
BEGIN
    
    INSERT INTO services (
        id, service_date, result, notes, odometer_km,
        service_kinds_id, vehicles_plate
    ) VALUES (
        p_service_id, p_service_date, p_result, p_notes, p_odometer_km,
        p_service_kinds_id, p_vehicle_plate
    );

    ------------------------------------------------------------------
    -- 2. Calcular fecha de vencimiento del documento
    ------------------------------------------------------------------
    v_expiry_date := fn_calc_expiry_date(p_service_kinds_id, p_service_date);

    ------------------------------------------------------------------
    -- 3. Determinar estado del documento según el resultado
    ------------------------------------------------------------------
    IF UPPER(p_result) = 'APROBADO' THEN
        v_status_doc_id := 'VIG';  -- Vigente
    ELSIF UPPER(p_result) = 'RECHAZADO' THEN
        v_status_doc_id := 'VEN';  -- Vencido
    ELSE
        v_status_doc_id := 'PRO';  -- En proceso
    END IF;

    ------------------------------------------------------------------
    -- 4. Insertar el documento asociado
    ------------------------------------------------------------------
    INSERT INTO documents (
        id,
        issue_date,
        expiry_date,
        source,
        vehicle_plate,
        service_id,
        status_document_id
    ) VALUES (
        p_document_id,
        p_service_date,
        v_expiry_date,
        p_source,
        p_vehicle_plate,
        p_service_id,
        v_status_doc_id
    );

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(
            -20021,
            'Ya existe un servicio o documento con los IDs proporcionados.'
        );
END;
/
SHOW ERRORS PROCEDURE sp_registrar_servicio_y_documento;

-------------------------------------------------------------------------------
-- (BLOQUE ANÓNIMO)
-------------------------------------------------------------------------------
BEGIN
    sp_registrar_servicio_y_documento(
        p_service_id        => 'S200',              -- nuevo servicio
        p_service_date      => DATE '2025-02-10',
        p_result            => 'APROBADO',          -- prueba: aprobado
        p_notes             => 'RTM anual prueba',
        p_odometer_km       => 45250,
        p_service_kinds_id  => 'RTM',               -- debe existir en SERVICES_KINDS
        p_vehicle_plate     => 'ABC101',            -- debe existir en VEHICLES

        p_document_id       => 'D200',              -- nuevo documento
        p_source            => 'RTM'
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Servicio S200 y documento D200 insertados con éxito.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en prueba procedimiento: ' || SQLERRM);
END;
/

-- Verificar inserción del servicio
SELECT *
FROM services
WHERE id = 'S200';

-- Verificar inserción del documento
SELECT id,
       issue_date,
       expiry_date,
       status_document_id,
       status_document_name
FROM documents
WHERE id = 'D200';
