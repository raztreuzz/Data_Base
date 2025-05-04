USE biblioteca;

INSERT INTO `libro`(`isbn`, `titulo`, `editorial`, `edicion`, `anio`)
VALUES
	('978-9929-774-76-6', 'Historia de un Pepe', 'Editorial Cultura', 2, 1890),
	('9788490746585', 'Un Capitán de Quince Años', 'Verbum', 1, 1870),
	('9788420676630', 'El Señor Presidente', 'Alianza Editorial ', 1, 1946),
    ('978-84-7829-085-7', 'Fundamentos de Sistemas de Bases de Datos', 'Pearson Education', 5, 2007);            
            
    
    
INSERT INTO `autor`(`id`,`nombre`, `apellido`, `nacionalidad`)
VALUES
	(1, 'José', 'Milla y Vidaurre', 'Guatemalteco'),
	(2, 'Julio', 'Verne', 'Frances'),
    (3, 'Miguel Ángel', 'Asturias', 'Guatemalteco'),
    (4, 'Ramez', 'Elmasri', 'Egipicio-Estadounidense'),
    (5, 'Shamkant', 'Navathe', 'Estadounidense');
    
INSERT INTO `autoria` (`libro_isbn`, `autor_id`)
VALUES
	('978-9929-774-76-6', 1),
    ('9788490746585', 2),
    ('9788420676630', 3),
    ('978-84-7829-085-7', 4),
    ('978-84-7829-085-7', 5);
    
INSERT INTO `ejemplar`(`cod`, `isbn_libro`, `encuadernacion`, `estado`, `disponible`)
VALUES
	('018f60fe', '978-9929-774-76-6', 'Rústica', 'Regular', 1),
    ('018f60ff', '978-9929-774-76-6', 'Rústica', 'Bueno', 1),
    ('018f6100', '978-9929-774-76-6', 'Dura', 'Excelente', 1),
    ('2f4343a2', '978-9929-774-76-6', 'Dura', 'Bueno', 1),
    ('4d9f8540', '9788490746585', 'Rústica', 'Regular', 0),
    ('50c2cffc', '9788490746585', 'Rústica', 'Mala', 1),
    ('533663ca', '9788490746585', 'Dura', 'Excelente', 1),
    ('70f22926', '9788420676630', 'Dura', 'Bueno', 0),
    ('73cb55e6', '9788420676630', 'Rústica', 'Regular', 1),
    ('7674d5e2', '9788420676630', 'Rústica', 'Mala', 1),
    ('78f32e2c', '9788420676630', 'Dura', 'Excelente', 1),
    ('b821dbf2', '978-84-7829-085-7', 'Rústica', 'Regular', 1);
    
INSERT INTO `usuario` (`dpi`, `nombre`, `apellido`, `email`, `direccion`) 
VALUES
	(1234567890123, 'Juan', 'Pérez', 'juan.perez@email.com', 'Dirección 1'),
	(1234567890124, 'Ana', 'López', 'ana.lopez@email.com', 'Dirección 2'),
	(1234567890125, 'Carlos', 'García', 'carlos.garcia@email.com', 'Dirección 3');

INSERT INTO `prestamo`(`usuario_dpi`, `ejemplar_cod`, `fecha_prestamo`, `fecha_establecida_devolucion`, `fecha_efectiva_devolucion`)
VALUES
	(1234567890123, '4d9f8540', '2025-04-30', '2025-05-09', null),
    (1234567890124, '70f22926', '2025-04-30', '2025-05-11', null),
    (1234567890125, 'b821dbf2', '2025-01-30', '2025-02-11', '2025-02-14');
    