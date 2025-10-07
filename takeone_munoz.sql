-- Script de creación de la base de datos Take One
CREATE DATABASE takeone_munoz;
USE takeone_munoz;

-- Tabla de usuarias
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  correo VARCHAR(100) UNIQUE NOT NULL,
  edad INT,
  pais VARCHAR(50),
  fecha_registro DATE
);

-- Tabla de profesionales
CREATE TABLE profesionales (
  id_profesional INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especialidad VARCHAR(100),
  correo VARCHAR(100) UNIQUE
);

-- Tabla de tests
CREATE TABLE tests (
  id_test INT AUTO_INCREMENT PRIMARY KEY,
  nombre_test VARCHAR(100) NOT NULL,
  descripcion TEXT
);

-- Tabla de respuestas
CREATE TABLE respuestas (
  id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_test INT,
  resultado VARCHAR(50),
  fecha DATE,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_test) REFERENCES tests(id_test)
);

-- Tabla de sesiones
CREATE TABLE sesiones (
  id_sesion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_profesional INT,
  fecha DATETIME,
  tema VARCHAR(100),
  estado VARCHAR(50),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional)
);

-- Tabla de recursos
CREATE TABLE recursos (
  id_recurso INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100),
  tipo VARCHAR(50),
  enlace VARCHAR(255),
  categoria VARCHAR(50)
);
