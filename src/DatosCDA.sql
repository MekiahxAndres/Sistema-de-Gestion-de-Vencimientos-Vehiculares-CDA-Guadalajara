------------------------------------------------------------
-- DOCUMENTS_TYPES
------------------------------------------------------------
INSERT INTO documents_types (id, name, abbreviation) VALUES ('CC',  'Cedula ciudad.', 'CC');
INSERT INTO documents_types (id, name, abbreviation) VALUES ('CE',  'Cedula extran.', 'CE');
INSERT INTO documents_types (id, name, abbreviation) VALUES ('NIT', 'NIT',            'NI');
INSERT INTO documents_types (id, name, abbreviation) VALUES ('PP',  'Pasaporte',      'PP');

------------------------------------------------------------
-- STATUS_OWNERS
------------------------------------------------------------
INSERT INTO status_owners (id, name) VALUES ('ACT', 'Activo');
INSERT INTO status_owners (id, name) VALUES ('INA', 'Inactivo');

------------------------------------------------------------
-- VEHICLE_BRANDS
------------------------------------------------------------
INSERT INTO vehicle_brands (id, name) VALUES ('CHEV', 'Chevrolet');
INSERT INTO vehicle_brands (id, name) VALUES ('RENA', 'Renault');
INSERT INTO vehicle_brands (id, name) VALUES ('KIA',  'Kia');
INSERT INTO vehicle_brands (id, name) VALUES ('MAZD', 'Mazda');

------------------------------------------------------------
-- VEHICLE_LINESV2
------------------------------------------------------------
INSERT INTO vehicle_linesv2 (id, name) VALUES ('SPARK', 'Spark');
INSERT INTO vehicle_linesv2 (id, name) VALUES ('LOGAN', 'Logan');
INSERT INTO vehicle_linesv2 (id, name) VALUES ('RIO',   'Rio');
INSERT INTO vehicle_linesv2 (id, name) VALUES ('MAZ3',  'Mazda 3');

------------------------------------------------------------
-- STATUS_VEHICLES
------------------------------------------------------------
INSERT INTO status_vehicles (id, name) VALUES ('ACT', 'Activo');
INSERT INTO status_vehicles (id, name) VALUES ('SUS', 'Suspendido');

------------------------------------------------------------
-- TAXES
------------------------------------------------------------
INSERT INTO taxes (id, name) VALUES ('IMP_VEH', 'Imp. Vehicular');
INSERT INTO taxes (id, name) VALUES ('IMP_RTM', 'Tasa RTM');
INSERT INTO taxes (id, name) VALUES ('IMP_ENV', 'Tasa Ambiental');

------------------------------------------------------------
-- INSURERS
------------------------------------------------------------
INSERT INTO insurers (id, name, phone, email)
VALUES ('SURA', 'Seguros Sura',  '6041234567', 'contacto@sura.com');

INSERT INTO insurers (id, name, phone, email)
VALUES ('AXA',  'AXA Colpatria', '6017654321', 'info@axa.com');

INSERT INTO insurers (id, name, phone, email)
VALUES ('MAPF', 'Mapfre',        '6011112233', 'servicio@mapfre.com');

------------------------------------------------------------
-- INSURERS_TAXES
------------------------------------------------------------
INSERT INTO insurers_taxes (tax_id, insurer_id) VALUES ('IMP_VEH', 'SURA');
INSERT INTO insurers_taxes (tax_id, insurer_id) VALUES ('IMP_VEH', 'AXA');
INSERT INTO insurers_taxes (tax_id, insurer_id) VALUES ('IMP_RTM', 'SURA');
INSERT INTO insurers_taxes (tax_id, insurer_id) VALUES ('IMP_RTM', 'MAPF');
INSERT INTO insurers_taxes (tax_id, insurer_id) VALUES ('IMP_ENV', 'AXA');

------------------------------------------------------------
-- TRANSIT_AGENCIES
------------------------------------------------------------
INSERT INTO transit_agencies (id, name, location, phone, city, depto)
VALUES ('TA01', 'Sec Mov Cali', 'Cra 1 #10-20', 6021234567, 'Cali',    'Valle del Cauca');

-- name tiene máx 15 caracteres → sin puntos y más corto
INSERT INTO transit_agencies (id, name, location, phone, city, depto)
VALUES ('TA02', 'Sec Mov Palmira', 'Cl 20 #15-30', 6022345678, 'Palmira', 'Valle del Cauca');

------------------------------------------------------------
-- STATUS_CARDS
------------------------------------------------------------
INSERT INTO status_cards (id, name) VALUES ('VIG', 'Vigente');
INSERT INTO status_cards (id, name) VALUES ('ANU', 'Anulada');

------------------------------------------------------------
-- STATUS_DOCUMENT
------------------------------------------------------------
INSERT INTO status_document (id, name) VALUES ('VIG', 'Vigente');
INSERT INTO status_document (id, name) VALUES ('VEN', 'Vencido');
INSERT INTO status_document (id, name) VALUES ('PRO', 'En proceso');

------------------------------------------------------------
-- SERVICES_KINDS
------------------------------------------------------------
INSERT INTO services_kinds (id, name) VALUES ('RTM',  'Revision tecnic.');
INSERT INTO services_kinds (id, name) VALUES ('DIAG', 'Diagnostico');
INSERT INTO services_kinds (id, name) VALUES ('ALIN', 'Alineacion');

------------------------------------------------------------
-- SEND_STATUS
------------------------------------------------------------
INSERT INTO send_status (id, code, description)
VALUES ('PEN',  'PEND', 'Pendiente de envío');

INSERT INTO send_status (id, code, description)
VALUES ('SENT', 'SENT', 'Notificación enviada');

INSERT INTO send_status (id, code, description)
VALUES ('ERR',  'ERR',  'Error en el envío');

------------------------------------------------------------
-- OWNERS (10 propietarios)
------------------------------------------------------------
INSERT INTO owners (id, document_number, first_name, last_name, phone, email, address, document_type_id, status_id)
VALUES ('O001', 101000001, 'Ana',    'López',   '3001110001', 'ana.lopez@mail.com',   'Calle 1 #1-01',  'CC', 'ACT');

INSERT INTO owners VALUES
('O002', 101000002, 'Bruno',  'García',  '3001110002', 'bruno.garcia@mail.com', 'Calle 2 #2-02',  'CC', 'ACT');

INSERT INTO owners VALUES
('O003', 101000003, 'Carla',  'Ramírez', '3001110003', 'carla.ramirez@mail.com','Calle 3 #3-03',  'CC', 'ACT');

INSERT INTO owners VALUES
('O004', 101000004, 'Diego',  'Torres',  '3001110004', 'diego.torres@mail.com', 'Calle 4 #4-04',  'CC', 'ACT');

INSERT INTO owners VALUES
('O005', 101000005, 'Elena',  'Martínez','3001110005', 'elena.mtz@mail.com',    'Calle 5 #5-05',  'CC', 'ACT');

INSERT INTO owners VALUES
('O006', 101000006, 'Fabio',  'Hernán',  '3001110006', 'fabio.hernan@mail.com', 'Calle 6 #6-06',  'CC', 'ACT');

INSERT INTO owners VALUES
('O007', 101000007, 'Gloria', 'Pérez',   '3001110007', 'gloria.perez@mail.com', 'Calle 7 #7-07',  'CC', 'ACT');

INSERT INTO owners VALUES
('O008', 101000008, 'Hugo',   'Moreno',  '3001110008', 'hugo.moreno@mail.com',  'Calle 8 #8-08',  'CC', 'ACT');

INSERT INTO owners VALUES
('O009', 101000009, 'Isabel','Rojas',   '3001110009', 'isabel.rojas@mail.com', 'Calle 9 #9-09',  'CC', 'ACT');

INSERT INTO owners VALUES
('O010', 101000010, 'Jorge', 'Suárez',  '3001110010', 'jorge.suarez@mail.com', 'Calle 10 #10-10','CC', 'INA');

------------------------------------------------------------
-- VEHICLES (10 vehículos)
------------------------------------------------------------
INSERT INTO vehicles (plate, model_year, vehicle_brands_id, vehicle_linesv2_id, status_vehicles_id)
VALUES ('ABC101', 2015, 'CHEV', 'SPARK', 'ACT');

INSERT INTO vehicles VALUES ('BCD202', 2016, 'CHEV', 'SPARK', 'ACT');
INSERT INTO vehicles VALUES ('CDE303', 2017, 'RENA', 'LOGAN', 'ACT');
INSERT INTO vehicles VALUES ('DEF404', 2018, 'RENA', 'LOGAN', 'ACT');
INSERT INTO vehicles VALUES ('EFG505', 2019, 'KIA',  'RIO',   'ACT');
INSERT INTO vehicles VALUES ('FGH606', 2020, 'KIA',  'RIO',   'ACT');
INSERT INTO vehicles VALUES ('GHI707', 2017, 'MAZD', 'MAZ3',  'ACT');
INSERT INTO vehicles VALUES ('HIJ808', 2018, 'MAZD', 'MAZ3',  'ACT');
INSERT INTO vehicles VALUES ('IJK909', 2014, 'CHEV', 'SPARK', 'SUS');
INSERT INTO vehicles VALUES ('JKL010', 2013, 'RENA', 'LOGAN', 'ACT');

------------------------------------------------------------
-- PROPERTYS_CARDS (10 tarjetas, 1 por vehículo)
------------------------------------------------------------
INSERT INTO propertys_cards (id, liscense_number, issue_date, observations,
                             document_version_int, vehicle_plate,
                             owner_id, transit_agency_id, status_cards_id)
VALUES ('PC01', 'LIC0001', DATE '2020-01-10', NULL, 'v1', 'ABC101', 'O001', 'TA01', 'VIG');

INSERT INTO propertys_cards VALUES
('PC02','LIC0002', DATE '2020-02-10', NULL, 'v1', 'BCD202', 'O002','TA01','VIG');

INSERT INTO propertys_cards VALUES
('PC03','LIC0003', DATE '2020-03-10', NULL, 'v1', 'CDE303', 'O003','TA01','VIG');

INSERT INTO propertys_cards VALUES
('PC04','LIC0004', DATE '2020-04-10', NULL, 'v1', 'DEF404', 'O004','TA01','VIG');

INSERT INTO propertys_cards VALUES
('PC05','LIC0005', DATE '2020-05-10', NULL, 'v1', 'EFG505', 'O005','TA01','VIG');

INSERT INTO propertys_cards VALUES
('PC06','LIC0006', DATE '2020-06-10', NULL, 'v1', 'FGH606', 'O006','TA02','VIG');

INSERT INTO propertys_cards VALUES
('PC07','LIC0007', DATE '2020-07-10', NULL, 'v1', 'GHI707', 'O007','TA02','VIG');

INSERT INTO propertys_cards VALUES
('PC08','LIC0008', DATE '2020-08-10', NULL, 'v1', 'HIJ808', 'O008','TA02','VIG');

INSERT INTO propertys_cards VALUES
('PC09','LIC0009', DATE '2020-09-10', NULL, 'v1', 'IJK909', 'O009','TA02','VIG');

INSERT INTO propertys_cards VALUES
('PC10','LIC0010', DATE '2020-10-10', NULL, 'v1', 'JKL010', 'O010','TA02','ANU');

------------------------------------------------------------
-- SERVICES (12 servicios, odometer_km reducido para no pasar la precisión)
------------------------------------------------------------
INSERT INTO services (id, service_date, result, notes, odometer_km, service_kinds_id, vehicles_plate)
VALUES ('S001', DATE '2024-01-05', 'APROBADO',   'RTM anual',  5000, 'RTM',  'ABC101');

INSERT INTO services VALUES ('S002', DATE '2024-01-06', 'APROBADO', 'RTM anual',      6000, 'RTM',  'BCD202');
INSERT INTO services VALUES ('S003', DATE '2024-01-07', 'RECHAZADO','Fugas de aceite',6100, 'RTM',  'CDE303');
INSERT INTO services VALUES ('S004', DATE '2024-01-08', 'APROBADO', 'RTM anual',      6200, 'RTM',  'DEF404');
INSERT INTO services VALUES ('S005', DATE '2024-01-09', 'APROBADO', 'RTM anual',      3000, 'RTM',  'EFG505');
INSERT INTO services VALUES ('S006', DATE '2024-01-10', 'APROBADO', 'RTM anual',      2500, 'RTM',  'FGH606');

INSERT INTO services VALUES ('S007', DATE '2024-02-01', 'REALIZADO','Diag. ruidos',  5050, 'DIAG', 'ABC101');
INSERT INTO services VALUES ('S008', DATE '2024-02-02', 'REALIZADO','Diag. frenos',  6050, 'DIAG', 'BCD202');
INSERT INTO services VALUES ('S009', DATE '2024-02-03', 'REALIZADO','Diag. motor',   6205, 'DIAG', 'CDE303');
INSERT INTO services VALUES ('S010', DATE '2024-02-04', 'REALIZADO','Alineacion',    3010, 'ALIN', 'EFG505');
INSERT INTO services VALUES ('S011', DATE '2024-02-05', 'REALIZADO','Alineacion',    2550, 'ALIN', 'FGH606');
INSERT INTO services VALUES ('S012', DATE '2024-02-06', 'REALIZADO','Alineacion',    7000, 'ALIN', 'GHI707');

------------------------------------------------------------
-- RTM (5 registros)
------------------------------------------------------------
INSERT INTO rtm (id, certificate_number, inspection_result)
VALUES ('RTM01','CERT0001','APROBADO');
INSERT INTO rtm VALUES ('RTM02','CERT0002','APROBADO');
INSERT INTO rtm VALUES ('RTM03','CERT0003','RECHAZADO');
INSERT INTO rtm VALUES ('RTM04','CERT0004','APROBADO');
INSERT INTO rtm VALUES ('RTM05','CERT0005','APROBADO');

------------------------------------------------------------
-- SOAT (10 pólizas)
------------------------------------------------------------
INSERT INTO soat (id, police_number, insurer_id) VALUES ('SOAT01','P0001','SURA');
INSERT INTO soat VALUES ('SOAT02','P0002','SURA');
INSERT INTO soat VALUES ('SOAT03','P0003','AXA');
INSERT INTO soat VALUES ('SOAT04','P0004','AXA');
INSERT INTO soat VALUES ('SOAT05','P0005','MAPF');
INSERT INTO soat VALUES ('SOAT06','P0006','MAPF');
INSERT INTO soat VALUES ('SOAT07','P0007','SURA');
INSERT INTO soat VALUES ('SOAT08','P0008','AXA');
INSERT INTO soat VALUES ('SOAT09','P0009','MAPF');
INSERT INTO soat VALUES ('SOAT10','P0010','SURA');

------------------------------------------------------------
-- DOCUMENTS (12 documentos)
------------------------------------------------------------
INSERT INTO documents (id, issue_date, expiry_date, source,
                       vehicle_plate, service_id,
                       status_document_id, status_document_name)
VALUES ('D001', DATE '2024-01-05', DATE '2025-01-05', 'RTM',
        'ABC101', 'S001', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D002', DATE '2024-01-06', DATE '2025-01-06', 'RTM',
 'BCD202', 'S002', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D003', DATE '2024-01-07', DATE '2024-07-07', 'RTM',
 'CDE303', 'S003', 'VEN', 'Vencido');

INSERT INTO documents VALUES
('D004', DATE '2024-01-08', DATE '2025-01-08', 'RTM',
 'DEF404', 'S004', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D005', DATE '2024-01-09', DATE '2025-01-09', 'RTM',
 'EFG505', 'S005', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D006', DATE '2024-01-10', DATE '2025-01-10', 'RTM',
 'FGH606', 'S006', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D007', DATE '2024-02-01', DATE '2024-08-01', 'DIAG',
 'ABC101', 'S007', 'PRO', 'En proceso');

INSERT INTO documents VALUES
('D008', DATE '2024-02-02', DATE '2024-08-02', 'DIAG',
 'BCD202', 'S008', 'PRO', 'En proceso');

INSERT INTO documents VALUES
('D009', DATE '2024-02-03', DATE '2024-08-03', 'DIAG',
 'CDE303', 'S009', 'PRO', 'En proceso');

INSERT INTO documents VALUES
('D010', DATE '2024-02-04', DATE '2025-02-04', 'ALIN',
 'EFG505', 'S010', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D011', DATE '2024-02-05', DATE '2025-02-05', 'ALIN',
 'FGH606', 'S011', 'VIG', 'Vigente');

INSERT INTO documents VALUES
('D012', DATE '2024-02-06', DATE '2025-02-06', 'ALIN',
 'GHI707', 'S012', 'VIG', 'Vigente');

------------------------------------------------------------
-- NOTIFICATIONS (10 notificaciones)
-- scheduled_at / sent_at formato: 'YYYY-MM-DD H:M'
------------------------------------------------------------
INSERT INTO notifications (id, scheduled_at, sent_at, reason,
                           message_body, document_id,
                           send_status_id, owners_id)
VALUES ('N001', '2024-12-01 9:0', '2024-12-01 9:1', 'VENCIMIENTO',
        'Su RTM está próxima a vencer (vehículo ABC101).',
        'D001', 'SENT', 'O001');

INSERT INTO notifications VALUES
('N002', '2024-12-02 9:0', '2024-12-02 9:1', 'VENCIMIENTO',
 'Su RTM está próxima a vencer (vehículo BCD202).',
 'D002', 'SENT', 'O002');

INSERT INTO notifications VALUES
('N003', '2024-06-01 9:0', '2024-06-01 9:2', 'VENCIMIENTO',
 'Su RTM ha vencido (vehículo CDE303).',
 'D003', 'SENT', 'O003');

INSERT INTO notifications VALUES
('N004', '2024-12-03 9:0', '2024-12-03 9:1', 'VENCIMIENTO',
 'Su RTM está próxima a vencer (vehículo DEF404).',
 'D004', 'SENT', 'O004');

INSERT INTO notifications VALUES
('N005', '2024-12-04 9:0', '2024-12-04 9:1', 'VENCIMIENTO',
 'Su RTM está próxima a vencer (vehículo EFG505).',
 'D005', 'PEN',  'O005');

INSERT INTO notifications VALUES
('N006', '2024-12-05 9:0', '2024-12-05 9:1', 'VENCIMIENTO',
 'Su RTM está próxima a vencer (vehículo FGH606).',
 'D006', 'PEN',  'O006');

INSERT INTO notifications VALUES
('N007', '2024-03-01 10:0', '2024-03-01 10:1', 'SERVICIO',
 'Resultado de diagnóstico disponible para su vehículo ABC101.',
 'D007', 'SENT', 'O001');

INSERT INTO notifications VALUES
('N008', '2024-03-02 10:0', '2024-03-02 10:1', 'SERVICIO',
 'Resultado de diagnóstico disponible para su vehículo BCD202.',
 'D008', 'SENT', 'O002');

INSERT INTO notifications VALUES
('N009', '2024-03-03 10:0', '2024-03-03 10:1', 'SERVICIO',
 'Resultado de diagnóstico disponible para su vehículo CDE303.',
 'D009', 'ERR',  'O003');

INSERT INTO notifications VALUES
('N010', '2024-03-04 10:0', '2024-03-04 10:1', 'SERVICIO',
 'Servicio de alineación registrado para su vehículo EFG505.',
 'D010', 'SENT', 'O005');

COMMIT;
