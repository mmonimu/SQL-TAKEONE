-- =========================================
-- Script: takeone_munoz.sql
-- Crea BD y Tablas (Entrega 1, versión final)
-- Requiere MySQL 8+
-- =========================================

-- Recomendado para desarrollo; comenta en prod si no deseas autolimpieza
DROP DATABASE IF EXISTS takeone_munoz;
CREATE DATABASE IF NOT EXISTS takeone_munoz
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;
USE takeone_munoz;

-- Opcionales de robustez
SET sql_safe_updates = 0;
SET sql_notes = 1;

-- =========================
-- TABLA: usuarios
-- =========================
CREATE TABLE IF NOT EXISTS usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  correo VARCHAR(100) NOT NULL UNIQUE,
  edad INT CHECK (edad IS NULL OR edad BETWEEN 0 AND 120),
  pais VARCHAR(50),
  fecha_registro DATE,
  INDEX ix_usuarios_nombre (nombre),
  INDEX ix_usuarios_pais (pais)
) ENGINE=InnoDB;

-- =========================
-- TABLA: profesionales
-- =========================
CREATE TABLE IF NOT EXISTS profesionales (
  id_profesional INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  especialidad VARCHAR(100),
  correo VARCHAR(100) UNIQUE,
  INDEX ix_profesionales_nombre (nombre),
  INDEX ix_profesionales_especialidad (especialidad)
) ENGINE=InnoDB;

-- =========================
-- TABLA: tests
-- =========================
CREATE TABLE IF NOT EXISTS tests (
  id_test INT AUTO_INCREMENT PRIMARY KEY,
  nombre_test VARCHAR(100) NOT NULL,
  descripcion TEXT,
  UNIQUE KEY uq_tests_nombre (nombre_test)
) ENGINE=InnoDB;

-- =========================
-- TABLA: respuestas
-- =========================
CREATE TABLE IF NOT EXISTS respuestas (
  id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_test INT NOT NULL,
  resultado VARCHAR(50),
  fecha DATE,
  CONSTRAINT fk_respuestas_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_respuestas_test
    FOREIGN KEY (id_test) REFERENCES tests(id_test)
    ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX ix_respuestas_usuario (id_usuario),
  INDEX ix_respuestas_test (id_test),
  INDEX ix_respuestas_fecha (fecha)
) ENGINE=InnoDB;

-- =========================
-- TABLA: sesiones
-- =========================
CREATE TABLE IF NOT EXISTS sesiones (
  id_sesion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_profesional INT NOT NULL,
  fecha DATETIME,
  tema VARCHAR(100),
  estado VARCHAR(50),
  CONSTRAINT fk_sesiones_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_sesiones_profesional
    FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX ix_sesiones_fecha (fecha),
  INDEX ix_sesiones_estado (estado)
) ENGINE=InnoDB;

-- =========================
-- TABLA: recursos
-- =========================
CREATE TABLE IF NOT EXISTS recursos (
  id_recurso INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100),
  tipo VARCHAR(50),
  enlace VARCHAR(255),
  categoria VARCHAR(50),
  INDEX ix_recursos_tipo (tipo),
  INDEX ix_recursos_categoria (categoria)
) ENGINE=InnoDB;
