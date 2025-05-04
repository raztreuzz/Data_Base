-- Esquema básico para el manejo de préstamos en una biblioteca física. 

DROP DATABASE IF EXISTS `biblioteca`;
CREATE DATABASE `biblioteca`;

USE `biblioteca`;

CREATE TABLE `autor` (
	`id` int primary key auto_increment,
    `nombre` varchar(50) not null,
    `apellido` varchar(50) not null,
    `nacionalidad` varchar(70) not null
);


CREATE TABLE `libro` (
	`isbn` varchar(50) primary key,
	`titulo` varchar(200) not null,
    `editorial` varchar(50) not null,
    `edicion` int,
    `anio` smallint(4)
);

CREATE TABLE `autoria` (
	`libro_isbn` varchar(50) not null,
    `autor_id` int not null,
    PRIMARY KEY(`libro_isbn`, `autor_id`)
);

ALTER TABLE `autoria` ADD CONSTRAINT `FK_autoria_libro` FOREIGN KEY (`libro_isbn`) REFERENCES `libro` (`isbn`);
ALTER TABLE `autoria` ADD CONSTRAINT `FK_autoria_autor` FOREIGN KEY (`autor_id`) REFERENCES `autor` (`id`);

CREATE TABLE `ejemplar` (
	`cod` varchar(20) primary key,
    `isbn_libro` varchar(50),
    `encuadernacion` varchar(10),
    `estado` varchar(20),
    `disponible` bit
);

ALTER TABLE `ejemplar` ADD CONSTRAINT `FK_ejemplar_libro` FOREIGN KEY (`isbn_libro`) REFERENCES `libro` (`isbn`);

CREATE TABLE `usuario` (
	`dpi` bigint primary key,
	`nombre` varchar(50) not null,
    `apellido` varchar(50) not null,
    `email` varchar(100) not null,
    `direccion` varchar(100) not null
);

-- Por simplicidad, asumimos que un usuario solamente puede prestar un libro a la vez.

CREATE TABLE `prestamo` (
	`usuario_dpi` bigint not null,
    `ejemplar_cod` varchar(20) not null,
    `fecha_prestamo` datetime not null,
    `fecha_establecida_devolucion` date not null,
    `fecha_efectiva_devolucion` datetime,
    PRIMARY KEY (`usuario_dpi`, `ejemplar_cod`, `fecha_prestamo`)
);

ALTER TABLE `prestamo` ADD CONSTRAINT `FK_prestamo_usuario` FOREIGN KEY (`usuario_dpi`) REFERENCES `usuario`(`dpi`);
ALTER TABLE `prestamo` ADD CONSTRAINT `FK_prestamo_ejemplar` FOREIGN KEY (`ejemplar_cod`) REFERENCES `ejemplar`(`cod`);

