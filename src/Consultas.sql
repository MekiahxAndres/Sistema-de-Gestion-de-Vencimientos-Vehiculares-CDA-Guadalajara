-- Reporte 1: 
-- Consulta: Listar todos los vehículos con su marca, línea, estado del vehículo,
-- estado de la tarjeta de propiedad y estado del documento principal (RTM/ALIN/DIAG),
-- mostrando también los que aún no tienen tarjeta o documento registrado.
SELECT
    v.plate AS placa,
    vb.name AS marca,
    vl.name AS linea,
    v.model_year AS modelo,
    sv.name AS estado_vehiculo,
    pc.id AS id_tarjeta,
    sc.name AS estado_tarjeta,
    d.id AS id_documento,
    d.source AS tipo_documento,
    sd.name AS estado_documento
FROM vehicles v
LEFT JOIN vehicle_brands vb ON vb.id = v.vehicle_brands_id
LEFT JOIN vehicle_linesv2 vl ON vl.id = v.vehicle_linesv2_id
LEFT JOIN status_vehicles sv ON sv.id = v.status_vehicles_id
LEFT JOIN propertys_cards pc ON pc.vehicle_plate = v.plate
LEFT JOIN status_cards sc ON sc.id = pc.status_cards_id
LEFT JOIN documents d  ON d.vehicle_plate = v.plate
LEFT JOIN status_document sd ON sd.id = d.status_document_id
ORDER BY v.plate, d.issue_date DESC;

-- Reporte 2: 
-- Resume cuántos servicios se han realizado, agrupados por
-- tipo de servicio (RTM, DIAG, ALIN, etc.) y por resultado
-- (APROBADO, RECHAZADO, REALIZADO, etc.).
SELECT sk.id   AS service_type_id, sk.name AS service_type_name, s.result, COUNT(*) AS total_services
FROM services s JOIN services_kinds sk ON sk.id = s.service_kinds_id
GROUP BY sk.id, sk.name, s.result
ORDER BY sk.id, s.result;

-- Reporte 3: 
-- Lista todos los vehículos y la fecha de su último servicio
-- registrado. Incluye también los vehículos que aún NO tienen
-- servicios (aparecen con fecha NULL).

SELECT v.plate, v.model_year, MAX(s.service_date) AS last_service_date
FROM vehicles v LEFT JOIN services s ON s.vehicles_plate = v.plate
GROUP BY v.plate, v.model_year
ORDER BY last_service_date NULLS LAST;

-- Reporte 4:
-- Muestra las 10 notificaciones más recientes, incluyendo
-- el propietario, el documento relacionado y el estado de envío.

SELECT n.id, n.scheduled_at, n.sent_at, n.reason, o.first_name || ' ' || o.last_name AS owner_name, d.id    AS document_id, d.source AS document_source, ss.code AS send_status_code
FROM notifications n JOIN owners o ON o.id = n.owners_id
JOIN documents d ON d.id = n.document_id
JOIN send_status ss ON ss.id = n.send_status_id
ORDER BY n.scheduled_at DESC
FETCH FIRST 10 ROWS ONLY;

-- Reporte 5:
-- Consulta: Mostrar las 5 agencias de tránsito con mayor cantidad de
-- tarjetas de propiedad vigentes, indicando también la ciudad.
SELECT *
FROM (
    SELECT
        ta.id AS agencia_id,
        ta.name AS agencia,
        ta.city  AS ciudad,
        COUNT(pc.id) AS total_tarjetas_vigentes
    FROM transit_agencies ta INNER JOIN propertys_cards pc ON pc.transit_agency_id = ta.id
    INNER JOIN status_cards sc ON sc.id = pc.status_cards_id
    WHERE sc.id = 'VIG' 
    GROUP BY ta.id, ta.name, ta.city
    ORDER BY total_tarjetas_vigentes DESC
)
WHERE ROWNUM <= 5;

--  Reporte 6: 
--  Calcula cuántas tarjetas de propiedad están en estado VIGENTE
--  por cada agencia de tránsito, y muestra las 5 agencias con
--  mayor cantidad.

SELECT ta.id, ta.name, COUNT(*) AS total_cards_vigentes
FROM transit_agencies ta JOIN propertys_cards pc ON pc.transit_agency_id = ta.id
JOIN status_cards sc ON sc.id = pc.status_cards_id
WHERE sc.id = 'VIG'       
GROUP BY ta.id, ta.name
ORDER BY total_cards_vigentes DESC
FETCH FIRST 5 ROWS ONLY;


-- Reporte 7: 
-- Consulta: Listar los impuestos asociados a cada aseguradora y la
-- cantidad de SOAT emitidos por aseguradora. Las aseguradoras sin SOAT
-- aparecen con conteo cero.
SELECT
    i.id AS aseguradora_id,
    i.name AS aseguradora,
    t.id AS impuesto_id,
    t.name AS impuesto,
    COUNT(s.id) AS soat_emitidos
FROM insurers i INNER JOIN insurers_taxes it ON it.insurer_id = i.id
INNER JOIN taxes t ON t.id = it.tax_id
LEFT JOIN soat s ON s.insurer_id = i.id
GROUP BY i.id, i.name, t.id, t.name
ORDER BY aseguradora, impuesto;
