------------------------------------------------------------
--  DOCUMENTS_TYPES
------------------------------------------------------------
CREATE TABLE documents_types (
    id           VARCHAR2(4 CHAR)   NOT NULL,
    name         VARCHAR2(15 CHAR)  NOT NULL,
    abbreviation VARCHAR2(3 CHAR)   NOT NULL,
    CONSTRAINT type_pk PRIMARY KEY (id)
);

COMMENT ON TABLE documents_types IS
  'Tipos de documentos de identificación (CC, CE, NIT, etc.).';

COMMENT ON COLUMN documents_types.id IS
  'Identificador único del tipo de documento.';
COMMENT ON COLUMN documents_types.name IS
  'Nombre del tipo de documento.';
COMMENT ON COLUMN documents_types.abbreviation IS
  'Abreviatura del tipo de documento (CC, CE, etc.).';

------------------------------------------------------------
--  STATUS_OWNERS
------------------------------------------------------------
CREATE TABLE status_owners (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT status_owners_pk PRIMARY KEY (id)
);

COMMENT ON TABLE status_owners IS
  'Estados posibles de un propietario (activo, inactivo, bloqueado, etc.).';

COMMENT ON COLUMN status_owners.id IS
  'Identificador del estado del propietario.';
COMMENT ON COLUMN status_owners.name IS
  'Nombre descriptivo del estado del propietario.';

------------------------------------------------------------
--  OWNERS
------------------------------------------------------------
CREATE TABLE owners (
    id               VARCHAR2(10 CHAR)  NOT NULL,
    document_number  NUMBER(30)         NOT NULL,
    first_name       VARCHAR2(10 CHAR)  NOT NULL,
    last_name        VARCHAR2(15 CHAR)  NOT NULL,
    phone            VARCHAR2(10 CHAR)  NOT NULL,
    email            VARCHAR2(70 CHAR)  NOT NULL,
    address          VARCHAR2(100 CHAR) NOT NULL,
    document_type_id VARCHAR2(4 CHAR)   NOT NULL,
    status_id        VARCHAR2(10 CHAR)  NOT NULL,
    CONSTRAINT owner_pk PRIMARY KEY (id),
    CONSTRAINT type_owner
        FOREIGN KEY (document_type_id)
        REFERENCES documents_types (id),
    CONSTRAINT owners_status_fk
        FOREIGN KEY (status_id)
        REFERENCES status_owners (id)
);

COMMENT ON TABLE owners IS
  'Propietarios de los vehículos que asisten al CDA.';

COMMENT ON COLUMN owners.id IS
  'Identificador interno del propietario.';
COMMENT ON COLUMN owners.document_number IS
  'Número del documento de identificación del propietario.';
COMMENT ON COLUMN owners.first_name IS
  'Primer nombre del propietario.';
COMMENT ON COLUMN owners.last_name IS
  'Apellido del propietario.';
COMMENT ON COLUMN owners.phone IS
  'Número de teléfono del propietario.';
COMMENT ON COLUMN owners.email IS
  'Correo electrónico del propietario.';
COMMENT ON COLUMN owners.address IS
  'Dirección de residencia del propietario.';
COMMENT ON COLUMN owners.document_type_id IS
  'Tipo de documento (FK a DOCUMENTS_TYPES).';
COMMENT ON COLUMN owners.status_id IS
  'Estado del propietario (FK a STATUS_OWNERS).';

------------------------------------------------------------
--  VEHICLE_BRANDS
------------------------------------------------------------
CREATE TABLE vehicle_brands (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT vehicle_brands_pk PRIMARY KEY (id)
);

COMMENT ON TABLE vehicle_brands IS
  'Marcas de vehículos (Chevrolet, Renault, etc.).';

COMMENT ON COLUMN vehicle_brands.id IS
  'Identificador de la marca del vehículo.';
COMMENT ON COLUMN vehicle_brands.name IS
  'Nombre de la marca del vehículo.';

------------------------------------------------------------
--  VEHICLE_LINESV2
------------------------------------------------------------
CREATE TABLE vehicle_linesv2 (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT vehicle_linesv2_pk PRIMARY KEY (id)
);

COMMENT ON TABLE vehicle_linesv2 IS
  'Líneas o referencias específicas dentro de una marca de vehículo.';

COMMENT ON COLUMN vehicle_linesv2.id IS
  'Identificador de la línea de vehículo.';
COMMENT ON COLUMN vehicle_linesv2.name IS
  'Nombre de la línea de vehículo.';

------------------------------------------------------------
--  STATUS_VEHICLES
------------------------------------------------------------
CREATE TABLE status_vehicles (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT status_vehicles_pk PRIMARY KEY (id)
);

COMMENT ON TABLE status_vehicles IS
  'Estados posibles de un vehículo (activo, dado de baja, etc.).';

COMMENT ON COLUMN status_vehicles.id IS
  'Identificador del estado del vehículo.';
COMMENT ON COLUMN status_vehicles.name IS
  'Descripción del estado del vehículo.';

------------------------------------------------------------
--  VEHICLES
------------------------------------------------------------
CREATE TABLE vehicles (
    plate               VARCHAR2(6 CHAR)   NOT NULL,
    model_year          NUMBER(4)          NOT NULL,
    vehicle_brands_id   VARCHAR2(10 CHAR)  NOT NULL,
    vehicle_linesv2_id  VARCHAR2(10 CHAR)  NOT NULL,
    status_vehicles_id  VARCHAR2(10 CHAR)  NOT NULL,
    CONSTRAINT vehicle_pk PRIMARY KEY (plate),
    CONSTRAINT vehicles_vehicle_brands_fk
        FOREIGN KEY (vehicle_brands_id)
        REFERENCES vehicle_brands (id),
    CONSTRAINT vehicles_vehicle_linesv2_fk
        FOREIGN KEY (vehicle_linesv2_id)
        REFERENCES vehicle_linesv2 (id),
    CONSTRAINT vehicles_status_vehicles_fk
        FOREIGN KEY (status_vehicles_id)
        REFERENCES status_vehicles (id)
);

COMMENT ON TABLE vehicles IS
  'Vehículos registrados que pueden recibir servicios en el CDA.';

COMMENT ON COLUMN vehicles.plate IS
  'Placa única del vehículo.';
COMMENT ON COLUMN vehicles.model_year IS
  'Modelo (año de fabricación) del vehículo.';
COMMENT ON COLUMN vehicles.vehicle_brands_id IS
  'Marca del vehículo (FK a VEHICLE_BRANDS).';
COMMENT ON COLUMN vehicles.vehicle_linesv2_id IS
  'Línea del vehículo (FK a VEHICLE_LINESV2).';
COMMENT ON COLUMN vehicles.status_vehicles_id IS
  'Estado actual del vehículo (FK a STATUS_VEHICLES).';

------------------------------------------------------------
--  TAXES
------------------------------------------------------------
CREATE TABLE taxes (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(15 CHAR)   NOT NULL,
    CONSTRAINT tax_pk PRIMARY KEY (id)
);

COMMENT ON TABLE taxes IS
  'Tipos de impuestos asociados a los vehículos (ej. impuesto vehicular).';

COMMENT ON COLUMN taxes.id IS
  'Identificador del impuesto.';
COMMENT ON COLUMN taxes.name IS
  'Nombre del tipo de impuesto.';

------------------------------------------------------------
--  INSURERS
------------------------------------------------------------
CREATE TABLE insurers (
    id    VARCHAR2(10 CHAR)  NOT NULL,
    name  VARCHAR2(20 CHAR)  NOT NULL,
    phone VARCHAR2(20 CHAR)  NOT NULL,
    email VARCHAR2(70 CHAR)  NOT NULL,
    CONSTRAINT insurer_pk PRIMARY KEY (id)
);

COMMENT ON TABLE insurers IS
  'Aseguradoras que emiten pólizas (SOAT, etc.).';

COMMENT ON COLUMN insurers.id IS
  'Identificador de la aseguradora.';
COMMENT ON COLUMN insurers.name IS
  'Nombre de la aseguradora.';
COMMENT ON COLUMN insurers.phone IS
  'Teléfono de contacto de la aseguradora.';
COMMENT ON COLUMN insurers.email IS
  'Correo electrónico de la aseguradora.';

------------------------------------------------------------
--  INSURERS_TAXES (relación N:M entre TAXES e INSURERS)
------------------------------------------------------------
CREATE TABLE insurers_taxes (
    tax_id     VARCHAR2(10 CHAR)  NOT NULL,
    insurer_id VARCHAR2(10 CHAR)  NOT NULL,
    CONSTRAINT insurers_taxes_pk PRIMARY KEY (tax_id, insurer_id),
    CONSTRAINT tax_fk
        FOREIGN KEY (tax_id)
        REFERENCES taxes (id),
    CONSTRAINT insurer_tax_fk
        FOREIGN KEY (insurer_id)
        REFERENCES insurers (id)
);

COMMENT ON TABLE insurers_taxes IS
  'Relación entre tipos de impuestos y aseguradoras que los gestionan.';

COMMENT ON COLUMN insurers_taxes.tax_id IS
  'Impuesto asociado (FK a TAXES).';
COMMENT ON COLUMN insurers_taxes.insurer_id IS
  'Aseguradora asociada (FK a INSURERS).';

------------------------------------------------------------
--  TRANSIT_AGENCIES
------------------------------------------------------------
CREATE TABLE transit_agencies (
    id       VARCHAR2(4 CHAR)    NOT NULL,
    name     VARCHAR2(15 CHAR)   NOT NULL,
    location VARCHAR2(100 CHAR)  NOT NULL,
    phone    NUMBER(11)          NOT NULL,
    city     VARCHAR2(85 CHAR)   NOT NULL,
    depto    VARCHAR2(85 CHAR)   NOT NULL,
    CONSTRAINT transit_agency_pk PRIMARY KEY (id)
);

COMMENT ON TABLE transit_agencies IS
  'Organismos de tránsito que expiden licencias y tarjetas de propiedad.';

COMMENT ON COLUMN transit_agencies.id IS
  'Identificador del organismo de tránsito.';
COMMENT ON COLUMN transit_agencies.name IS
  'Nombre del organismo de tránsito.';
COMMENT ON COLUMN transit_agencies.location IS
  'Dirección del organismo de tránsito.';
COMMENT ON COLUMN transit_agencies.phone IS
  'Número telefónico del organismo de tránsito.';
COMMENT ON COLUMN transit_agencies.city IS
  'Ciudad donde se ubica el organismo de tránsito.';
COMMENT ON COLUMN transit_agencies.depto IS
  'Departamento donde se ubica el organismo de tránsito.';

------------------------------------------------------------
--  STATUS_CARDS
------------------------------------------------------------
CREATE TABLE status_cards (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT status_cards_pk PRIMARY KEY (id)
);

COMMENT ON TABLE status_cards IS
  'Estados posibles de las tarjetas de propiedad (vigente, anulada, etc.).';

COMMENT ON COLUMN status_cards.id IS
  'Identificador del estado de la tarjeta.';
COMMENT ON COLUMN status_cards.name IS
  'Nombre del estado de la tarjeta de propiedad.';

------------------------------------------------------------
--  PROPERTYS_CARDS
------------------------------------------------------------
CREATE TABLE propertys_cards (
    id                   VARCHAR2(4 CHAR)    NOT NULL,
    liscense_number      VARCHAR2(30 CHAR)   NOT NULL,
    issue_date           DATE                NOT NULL,
    observations         VARCHAR2(100 CHAR),
    document_version_int VARCHAR2(100 CHAR),
    vehicle_plate        VARCHAR2(6 CHAR)    NOT NULL,
    owner_id             VARCHAR2(10 CHAR)   NOT NULL,
    transit_agency_id    VARCHAR2(4 CHAR)    NOT NULL,
    status_cards_id      VARCHAR2(10 CHAR)   NOT NULL,
    CONSTRAINT property_card_pk PRIMARY KEY (id),
    CONSTRAINT key_2 UNIQUE (liscense_number),
    CONSTRAINT vehicle_property_fk
        FOREIGN KEY (vehicle_plate)
        REFERENCES vehicles (plate),
    CONSTRAINT owner_property_fk
        FOREIGN KEY (owner_id)
        REFERENCES owners (id),
    CONSTRAINT transit_property_fk
        FOREIGN KEY (transit_agency_id)
        REFERENCES transit_agencies (id),
    CONSTRAINT propertys_cards_status_cards_fk
        FOREIGN KEY (status_cards_id)
        REFERENCES status_cards (id)
);

COMMENT ON TABLE propertys_cards IS
  'Tarjetas de propiedad que relacionan vehículo, propietario y organismo de tránsito.';

COMMENT ON COLUMN propertys_cards.id IS
  'Identificador interno de la tarjeta de propiedad.';
COMMENT ON COLUMN propertys_cards.liscense_number IS
  'Número de licencia de tránsito impreso en la tarjeta.';
COMMENT ON COLUMN propertys_cards.issue_date IS
  'Fecha de expedición de la tarjeta de propiedad.';
COMMENT ON COLUMN propertys_cards.observations IS
  'Observaciones o notas adicionales sobre la tarjeta.';
COMMENT ON COLUMN propertys_cards.document_version_int IS
  'Versión interna del documento de la tarjeta.';
COMMENT ON COLUMN propertys_cards.vehicle_plate IS
  'Vehículo al que pertenece la tarjeta (FK a VEHICLES).';
COMMENT ON COLUMN propertys_cards.owner_id IS
  'Propietario asociado a la tarjeta (FK a OWNERS).';
COMMENT ON COLUMN propertys_cards.transit_agency_id IS
  'Organismo de tránsito emisor (FK a TRANSIT_AGENCIES).';
COMMENT ON COLUMN propertys_cards.status_cards_id IS
  'Estado de la tarjeta de propiedad (FK a STATUS_CARDS).';

------------------------------------------------------------
--  STATUS_DOCUMENT
------------------------------------------------------------
CREATE TABLE status_document (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT status_document_pk PRIMARY KEY (id, name)
);

COMMENT ON TABLE status_document IS
  'Estados de los documentos (vigente, vencido, en trámite, etc.).';

COMMENT ON COLUMN status_document.id IS
  'Identificador del estado del documento.';
COMMENT ON COLUMN status_document.name IS
  'Nombre del estado del documento.';

------------------------------------------------------------
--  SERVICES_KINDS
------------------------------------------------------------
CREATE TABLE services_kinds (
    id   VARCHAR2(10 CHAR)   NOT NULL,
    name VARCHAR2(50 CHAR)   NOT NULL,
    CONSTRAINT services_kinds_pk PRIMARY KEY (id)
);

COMMENT ON TABLE services_kinds IS
  'Tipos de servicios que presta el CDA (RTM, revisiones, diagnósticos, etc.).';

COMMENT ON COLUMN services_kinds.id IS
  'Identificador del tipo de servicio.';
COMMENT ON COLUMN services_kinds.name IS
  'Nombre del tipo de servicio.';

------------------------------------------------------------
--  SERVICES
------------------------------------------------------------
CREATE TABLE services (
    id               VARCHAR2(4 CHAR)    NOT NULL,
    service_date     DATE                NOT NULL,
    result           VARCHAR2(10 CHAR)   NOT NULL,
    notes            VARCHAR2(100 CHAR),
    odometer_km      NUMBER(6,2),
    service_kinds_id VARCHAR2(10 CHAR)   NOT NULL,
    vehicles_plate   VARCHAR2(6 CHAR)    NOT NULL,
    CONSTRAINT service_pk PRIMARY KEY (id),
    CONSTRAINT services_service_kinds_fk
        FOREIGN KEY (service_kinds_id)
        REFERENCES services_kinds (id),
    CONSTRAINT services_vehicles_fk
        FOREIGN KEY (vehicles_plate)
        REFERENCES vehicles (plate)
);

COMMENT ON TABLE services IS
  'Servicios realizados a los vehículos dentro del CDA.';

COMMENT ON COLUMN services.id IS
  'Identificador del servicio realizado.';
COMMENT ON COLUMN services.service_date IS
  'Fecha en la que se realiza el servicio.';
COMMENT ON COLUMN services.result IS
  'Resultado del servicio (aprobado, rechazado, etc.).';
COMMENT ON COLUMN services.notes IS
  'Notas u observaciones del técnico.';
COMMENT ON COLUMN services.odometer_km IS
  'Lectura del odómetro del vehículo al momento del servicio (en km).';
COMMENT ON COLUMN services.service_kinds_id IS
  'Tipo de servicio (FK a SERVICES_KINDS).';
COMMENT ON COLUMN services.vehicles_plate IS
  'Vehículo al que se le realiza el servicio (FK a VEHICLES).';

------------------------------------------------------------
--  RTM
------------------------------------------------------------
CREATE TABLE rtm (
    id                 VARCHAR2(20 CHAR)  NOT NULL,
    certificate_number VARCHAR2(20 CHAR)  NOT NULL,
    inspection_result  VARCHAR2(15 CHAR)  NOT NULL,
    CONSTRAINT rtm_pk PRIMARY KEY (id)
);

COMMENT ON TABLE rtm IS
  'Información específica de los certificados de Revisión Técnico-Mecánica.';

COMMENT ON COLUMN rtm.id IS
  'Identificador de la RTM.';
COMMENT ON COLUMN rtm.certificate_number IS
  'Número del certificado de RTM.';
COMMENT ON COLUMN rtm.inspection_result IS
  'Resultado de la inspección (aprobado, rechazado, etc.).';

------------------------------------------------------------
--  SOAT
------------------------------------------------------------
CREATE TABLE soat (
    id            VARCHAR2(20 CHAR)  NOT NULL,
    police_number VARCHAR2(20 CHAR)  NOT NULL,
    insurer_id    VARCHAR2(10 CHAR)  NOT NULL,
    CONSTRAINT soat_pk PRIMARY KEY (id),
    CONSTRAINT soat_insurer_fk
        FOREIGN KEY (insurer_id)
        REFERENCES insurers (id)
);

COMMENT ON TABLE soat IS
  'Pólizas de SOAT asociadas a los vehículos.';

COMMENT ON COLUMN soat.id IS
  'Identificador de la póliza de SOAT.';
COMMENT ON COLUMN soat.police_number IS
  'Número de la póliza de SOAT.';
COMMENT ON COLUMN soat.insurer_id IS
  'Aseguradora que emite el SOAT (FK a INSURERS).';

------------------------------------------------------------
--  SEND_STATUS
------------------------------------------------------------
CREATE TABLE send_status (
    id          VARCHAR2(10 CHAR)   NOT NULL,
    code        VARCHAR2(20 CHAR)   NOT NULL,
    description VARCHAR2(100 CHAR)  NOT NULL,
    CONSTRAINT send_status_pk PRIMARY KEY (id)
);

COMMENT ON TABLE send_status IS
  'Estados del envío de notificaciones (pendiente, enviado, error, etc.).';

COMMENT ON COLUMN send_status.id IS
  'Identificador del estado de envío.';
COMMENT ON COLUMN send_status.code IS
  'Código interno del estado de envío.';
COMMENT ON COLUMN send_status.description IS
  'Descripción del estado de envío.';

------------------------------------------------------------
--  DOCUMENTS
------------------------------------------------------------
CREATE TABLE documents (
    id                   VARCHAR2(20 CHAR)  NOT NULL,
    issue_date           DATE               NOT NULL,
    expiry_date          DATE               NOT NULL,
    source               VARCHAR2(20 CHAR)  NOT NULL,
    vehicle_plate        VARCHAR2(6 CHAR)   NOT NULL,
    service_id           VARCHAR2(4 CHAR),      -- referencia a SERVICES.id
    status_document_id   VARCHAR2(10 CHAR)  NOT NULL,
    status_document_name VARCHAR2(50 CHAR)  NOT NULL,
    CONSTRAINT document_pk PRIMARY KEY (id),
    CONSTRAINT vehicle_document_fk
        FOREIGN KEY (vehicle_plate)
        REFERENCES vehicles (plate),
    CONSTRAINT service_document_fk
        FOREIGN KEY (service_id)
        REFERENCES services (id),
    CONSTRAINT documents_status_document_fk
        FOREIGN KEY (status_document_id, status_document_name)
        REFERENCES status_document (id, name)
);

COMMENT ON TABLE documents IS
  'Documentos asociados a los servicios y vehículos (RTM, SOAT, etc.).';

COMMENT ON COLUMN documents.id IS
  'Identificador del documento.';
COMMENT ON COLUMN documents.issue_date IS
  'Fecha de emisión del documento.';
COMMENT ON COLUMN documents.expiry_date IS
  'Fecha de vencimiento del documento.';
COMMENT ON COLUMN documents.source IS
  'Fuente o sistema desde el cual se genera el documento.';
COMMENT ON COLUMN documents.vehicle_plate IS
  'Vehículo al que pertenece el documento (FK a VEHICLES).';
COMMENT ON COLUMN documents.service_id IS
  'Servicio que origina el documento (FK a SERVICES).';
COMMENT ON COLUMN documents.status_document_id IS
  'Identificador del estado del documento (FK a STATUS_DOCUMENT).';
COMMENT ON COLUMN documents.status_document_name IS
  'Nombre del estado del documento (FK a STATUS_DOCUMENT).';

------------------------------------------------------------
--  NOTIFICATIONS
------------------------------------------------------------
CREATE TABLE notifications (
    id             VARCHAR2(15 CHAR)   NOT NULL,
    scheduled_at   VARCHAR2(15 CHAR)   NOT NULL,
    sent_at        VARCHAR2(15 CHAR)   NOT NULL,
    reason         VARCHAR2(15 CHAR)   NOT NULL,
    message_body   VARCHAR2(1500 CHAR) NOT NULL,
    document_id    VARCHAR2(20 CHAR)   NOT NULL,
    send_status_id VARCHAR2(10 CHAR)   NOT NULL,
    owners_id      VARCHAR2(10 CHAR)   NOT NULL,
    CONSTRAINT notification_pk PRIMARY KEY (id),
    CONSTRAINT notification_document_fk
        FOREIGN KEY (document_id)
        REFERENCES documents (id),
    CONSTRAINT notifications_send_status_fk
        FOREIGN KEY (send_status_id)
        REFERENCES send_status (id),
    CONSTRAINT notifications_owners_fk
        FOREIGN KEY (owners_id)
        REFERENCES owners (id)
);

COMMENT ON TABLE notifications IS
  'Notificaciones enviadas a los propietarios sobre documentos/servicios.';

COMMENT ON COLUMN notifications.id IS
  'Identificador de la notificación.';
COMMENT ON COLUMN notifications.scheduled_at IS
  'Fecha/hora programada para el envío (como texto).';
COMMENT ON COLUMN notifications.sent_at IS
  'Fecha/hora real en que se envió la notificación (como texto).';
COMMENT ON COLUMN notifications.reason IS
  'Motivo de la notificación (recordatorio, vencimiento, etc.).';
COMMENT ON COLUMN notifications.message_body IS
  'Contenido del mensaje enviado al propietario.';
COMMENT ON COLUMN notifications.document_id IS
  'Documento asociado a la notificación (FK a DOCUMENTS).';
COMMENT ON COLUMN notifications.send_status_id IS
  'Estado del envío de la notificación (FK a SEND_STATUS).';
COMMENT ON COLUMN notifications.owners_id IS
  'Propietario destinatario de la notificación (FK a OWNERS).';
