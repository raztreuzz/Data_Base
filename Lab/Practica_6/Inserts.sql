use eventos_db;

INSERT INTO eventos (id, nombre, descripcion, precio, fecha_inicio, fecha_fin, instalacion_id) VALUES
(1, 'Concierto de Rock', 'Un evento musical increíble', 250.00, '2025-05-01 18:00:00', '2025-05-01 23:59:59', 1),
(2, 'Feria de Tecnología', 'Exposición de lo último en tecnología', 150.00, '2025-06-10 09:00:00', '2025-06-12 18:00:00', 2),
(3, 'Obra de Teatro Clásico', 'Una puesta en escena imperdible', 120.00, '2025-07-15 19:00:00', '2025-07-15 21:30:00', 3),
(4, 'Competencia de Esports', 'Los mejores equipos en un torneo épico', 180.00, '2025-08-05 14:00:00', '2025-08-05 22:00:00', 4),
(5, 'Festival de Comida', 'Disfruta de sabores del mundo en un solo lugar', 200.00, '2025-09-20 12:00:00', '2025-09-20 22:00:00', 5);


-- 2. Insertar organizadores
INSERT INTO organizadores (cui, nombre, apellidos, correo, telefono) VALUES
('1234567890101', 'Juan', 'Perez', 'juan.perez@email.com', '555-1234'),
('9876543210202', 'Maria', 'Lopez', 'maria.lopez@email.com', '555-5678'),
('4567891230303', 'Carlos', 'Gomez', 'carlos.gomez@email.com', '555-8765'),
('7891234560404', 'Ana', 'Martinez', 'ana.martinez@email.com', '555-4321'),
('3216549870505', 'Luis', 'Ramirez', 'luis.ramirez@email.com', '555-2468');



INSERT INTO instalaciones (id, nombre, ubicacion) VALUES
(1, 'Teatro Nacional', '14.634915,-90.506882'),
(2, 'Parque Central', '14.634915,-90.506882'),
(3, 'Auditorio Universitario', '14.601944,-90.511667'),
(4, 'Centro de Convenciones', '14.607222,-90.516667'),
(5, 'Plaza Mayor', '14.635000,-90.510000');

INSERT INTO organizador_contactos (organizador_cui, contactos) VALUES
('1234567890101', '@juanperez'),
('1234567890101', 'linkedin.com/in/juanperez'),
('9876543210202', '@maria_lopez'),
('4567891230303', '@carlosgomez'),
('7891234560404', 'facebook.com/ana.martinez'),
('3216549870505', '+5025552468');

