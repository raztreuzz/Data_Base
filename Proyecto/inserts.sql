use eventos_db;

-- Instalaciones
INSERT INTO instalacion (nombre, latitud, longitud) VALUES
('Teatro Nacional', 14.6349, -90.5069),
('Parque Central', 14.6407, -90.5133),
('Auditorio U', 14.6045, -90.4892);

-- Categorías y subcategorías (jerarquía)
INSERT INTO categoria (nombre, padre_id) VALUES
('Cultura', NULL),
('Conciertos', NULL),
('Teatro', 1),
('Feria', 1),
('Rock', 2),
('Clásica', 2);

-- Asociaciones
INSERT INTO asociacion (nombre, acronimo, telefono) VALUES
('Asociación Cultural Quetzal', 'ACQ', '12345678'),
('Eventos Profesionales S.A.', 'EPSA', '87654321');

-- Organizadores
INSERT INTO organizador (cui, nombre, apellido, correo, telefono, asociacion_id) VALUES
('1234567890123', 'Ana', 'Ramírez', 'ana@email.com', '22223333', 1),
('2345678901234', 'Luis', 'Gómez', 'luis@email.com', '55556666', 1),
('3456789012345', 'Carlos', 'Pérez', 'carlos@email.com', '77778888', 2),
('4567890123456', 'Diana', 'López', 'diana@email.com', '99990000', NULL); -- Independiente

-- Contactos
INSERT INTO contacto (organizador_cui, tipo_red, valor) VALUES
('1234567890123', 'Instagram', '@ana_arte'),
('1234567890123', 'Facebook', 'Ana Ramirez'),
('2345678901234', 'Twitter', '@luis_eventos'),
('3456789012345', 'LinkedIn', 'Carlos P.'),
('4567890123456', 'Instagram', '@dianalopez');

-- Eventos
INSERT INTO evento (nombre, descripcion, instalacion_id, fecha_inicio, fecha_fin, horario, precio, estado_publicacion, fase) VALUES
('Festival de Teatro Juvenil', 'Obras teatrales de jóvenes artistas.', 1, '2025-06-10', '2025-06-12', '18:00 - 21:00', 25.00, 'PUBLICADO', 'PROGRAMADO'),
('Concierto de Rock Nacional', 'Bandas nacionales en vivo.', 2, '2025-07-01', '2025-07-01', '19:00 - 22:00', 50.00, 'PUBLICADO', 'PROGRAMADO'),
('Feria de la Cultura', 'Actividades artísticas y artesanales.', 2, '2025-06-20', '2025-06-22', '10:00 - 18:00', 0.00, 'BORRADOR', 'APLAZADO');

-- evento_categoria
INSERT INTO evento_categoria (evento_id, categoria_id) VALUES
(1, 3), -- Teatro
(2, 5), -- Rock
(3, 4); -- Feria

-- evento_organizador
INSERT INTO evento_organizador (evento_id, organizador_cui) VALUES
(1, '1234567890123'),
(2, '2345678901234'),
(2, '3456789012345'),
(3, '4567890123456');

-- Usuarios (para login)
INSERT INTO usuario (cui, username, password) VALUES
('1234567890123', 'ana_r', 'password1'),
('2345678901234', 'luis_g', 'password2'),
('3456789012345', 'carlos_p', 'password3'),
('4567890123456', 'diana_l', 'password4');
