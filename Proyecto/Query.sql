drop database if exists eventos_db;
create database eventos_db;

use eventos_db;

-- Tabla: Instalación
CREATE TABLE instalacion (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    latitud DECIMAL(10, 6),
    longitud DECIMAL(10, 6)
);

-- Tabla: Categoría (jerarquía recursiva)
CREATE TABLE categoria (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    padre_id BIGINT,
    FOREIGN KEY (padre_id) REFERENCES categoria(id)
);

-- Tabla: Asociación o Empresa
CREATE TABLE asociacion (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    acronimo VARCHAR(20),
    telefono VARCHAR(20)
);

-- Tabla: Organizador
CREATE TABLE organizador (
    cui VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    asociacion_id BIGINT,
    FOREIGN KEY (asociacion_id) REFERENCES asociacion(id)
);

-- Tabla: Contacto (de organizadores)
CREATE TABLE contacto (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    organizador_cui VARCHAR(13),
    tipo_red VARCHAR(50),
    valor VARCHAR(100),
    FOREIGN KEY (organizador_cui) REFERENCES organizador(cui)
);

-- Tabla: Evento
CREATE TABLE evento (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    instalacion_id BIGINT,
    fecha_inicio DATE,
    fecha_fin DATE,
    horario VARCHAR(100),
    precio DECIMAL(10,2),
    estado_publicacion ENUM('BORRADOR', 'PUBLICADO') DEFAULT 'BORRADOR',
    fase ENUM('PROGRAMADO', 'APLAZADO', 'CAMBIO_INSTALACION', 'CAMBIO_PRECIO', 'TERMINADO', 'CANCELADO') DEFAULT 'PROGRAMADO',
    FOREIGN KEY (instalacion_id) REFERENCES instalacion(id)
);

-- Tabla intermedia: evento_categoria (relación N:M)
CREATE TABLE evento_categoria (
    evento_id BIGINT,
    categoria_id BIGINT,
    PRIMARY KEY (evento_id, categoria_id),
    FOREIGN KEY (evento_id) REFERENCES evento(id),
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
);

-- Tabla intermedia: evento_organizador (relación N:M)
CREATE TABLE evento_organizador (
    evento_id BIGINT,
    organizador_cui VARCHAR(13),
    PRIMARY KEY (evento_id, organizador_cui),
    FOREIGN KEY (evento_id) REFERENCES evento(id),
    FOREIGN KEY (organizador_cui) REFERENCES organizador(cui)
);

-- Tabla: Usuario (login)
CREATE TABLE usuario (
    cui VARCHAR(13) PRIMARY KEY, -- Clave compartida con organizador
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (cui) REFERENCES organizador(cui)
);
