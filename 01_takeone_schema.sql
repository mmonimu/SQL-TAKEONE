-- ======================================================
-- PROYECTO FINAL SQL - TAKE ONE
-- Esquema, tablas, vistas, funciones, SPs y triggers
-- Autora: Monica Muñoz
-- ======================================================

DROP DATABASE IF EXISTS takeone_munoz;
CREATE DATABASE takeone_munoz;
USE takeone_munoz;

-- 1. Tablas maestras / dimensiones
-- ---------------------------------

CREATE TABLE paises (
  id_pais INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  correo VARCHAR(100) NOT NULL UNIQUE,
  fecha_nacimiento DATE,
  genero ENUM('F','M','NB','OTRO') DEFAULT 'F',
  id_pais INT,
  fecha_registro DATE,
  canal_registro VARCHAR(50),
  CONSTRAINT fk_usuarios_pais
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

CREATE TABLE profesionales (
  id_profesional INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  correo VARCHAR(100) UNIQUE,
  especialidad_principal VARCHAR(100),
  id_pais INT,
  fecha_alta DATE,
  CONSTRAINT fk_profesionales_pais
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
);

CREATE TABLE especialidades (
  id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255)
);

CREATE TABLE profesional_especialidad (
  id_profesional INT NOT NULL,
  id_especialidad INT NOT NULL,
  PRIMARY KEY (id_profesional, id_especialidad),
  CONSTRAINT fk_pe_profesional
    FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional),
  CONSTRAINT fk_pe_especialidad
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
);

CREATE TABLE planes_suscripcion (
  id_plan INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  precio_mensual DECIMAL(10,2) NOT NULL,
  duracion_meses TINYINT NOT NULL,
  nivel ENUM('FREE','BASIC','PREMIUM') NOT NULL
);

CREATE TABLE medios_pago (
  id_medio INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE categorias_recurso (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255)
);

-- 2. Contenido: tests / recursos / mood
-- -------------------------------------

CREATE TABLE tests (
  id_test INT AUTO_INCREMENT PRIMARY KEY,
  nombre_test VARCHAR(100) NOT NULL,
  descripcion TEXT,
  nivel_dificultad ENUM('BAJO','MEDIO','ALTO') DEFAULT 'BAJO',
  tipo VARCHAR(50)
);

CREATE TABLE preguntas (
  id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
  id_test INT NOT NULL,
  texto_pregunta TEXT NOT NULL,
  orden INT,
  tipo_respuesta ENUM('UNICA','MULTIPLE','ESCALA') DEFAULT 'UNICA',
  CONSTRAINT fk_preguntas_test
    FOREIGN KEY (id_test) REFERENCES tests(id_test)
);

CREATE TABLE opciones_pregunta (
  id_opcion INT AUTO_INCREMENT PRIMARY KEY,
  id_pregunta INT NOT NULL,
  texto_opcion VARCHAR(255) NOT NULL,
  valor_numerico INT NOT NULL,
  CONSTRAINT fk_opciones_pregunta
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta)
);

CREATE TABLE recursos (
  id_recurso INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  tipo ENUM('ARTICULO','EJERCICIO','VIDEO','PODCAST','DESCARGABLE') NOT NULL,
  nivel_dificultad ENUM('BAJO','MEDIO','ALTO') DEFAULT 'BAJO',
  url VARCHAR(255),
  duracion_minutos INT,
  tag_principal VARCHAR(50)
);

CREATE TABLE recurso_categoria (
  id_recurso INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_recurso, id_categoria),
  CONSTRAINT fk_rc_recurso
    FOREIGN KEY (id_recurso) REFERENCES recursos(id_recurso),
  CONSTRAINT fk_rc_categoria
    FOREIGN KEY (id_categoria) REFERENCES categorias_recurso(id_categoria)
);

CREATE TABLE registros_mood (
  id_registro INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  fecha DATE NOT NULL,
  puntaje_mood TINYINT NOT NULL,
  energia TINYINT,
  notas TEXT,
  CONSTRAINT fk_mood_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- 3. Tablas transaccionales
-- --------------------------

CREATE TABLE respuestas_test (
  id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_pregunta INT NOT NULL,
  id_opcion INT NOT NULL,
  fecha_respuesta DATETIME NOT NULL,
  CONSTRAINT fk_respuestas_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_respuestas_pregunta
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta),
  CONSTRAINT fk_respuestas_opcion
    FOREIGN KEY (id_opcion) REFERENCES opciones_pregunta(id_opcion)
);

CREATE TABLE suscripciones (
  id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_plan INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  estado ENUM('ACTIVA','PAUSADA','CANCELADA','VENCIDA') NOT NULL,
  CONSTRAINT fk_suscripciones_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_suscripciones_plan
    FOREIGN KEY (id_plan) REFERENCES planes_suscripcion(id_plan)
);

CREATE TABLE sesiones (
  id_sesion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_profesional INT NOT NULL,
  fecha_sesion DATETIME NOT NULL,
  duracion_minutos INT,
  modalidad ENUM('ONLINE','PRESENCIAL') DEFAULT 'ONLINE',
  estado ENUM('PROGRAMADA','COMPLETADA','CANCELADA') DEFAULT 'PROGRAMADA',
  motivo VARCHAR(255),
  CONSTRAINT fk_sesiones_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_sesiones_profesional
    FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional)
);

CREATE TABLE pagos (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_suscripcion INT,
  id_medio INT NOT NULL,
  fecha_pago DATETIME NOT NULL,
  monto DECIMAL(10,2) NOT NULL,
  estado ENUM('APLICADO','RECHAZADO','PENDIENTE') NOT NULL,
  referencia VARCHAR(100),
  CONSTRAINT fk_pagos_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_pagos_suscripcion
    FOREIGN KEY (id_suscripcion) REFERENCES suscripciones(id_suscripcion),
  CONSTRAINT fk_pagos_medio
    FOREIGN KEY (id_medio) REFERENCES medios_pago(id_medio)
);

CREATE TABLE logs_acceso (
  id_log INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  fecha_acceso DATETIME NOT NULL,
  dispositivo VARCHAR(50),
  ip VARCHAR(45),
  origen ENUM('APP','WEB','EMAIL') DEFAULT 'WEB',
  CONSTRAINT fk_logs_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- 4. Tabla de hechos
-- -------------------

CREATE TABLE hechos_interaccion (
  id_hecho INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_recurso INT NOT NULL,
  id_suscripcion INT,
  fecha_interaccion DATETIME NOT NULL,
  minutos_consumidos INT,
  completado TINYINT(1) DEFAULT 0,
  fuente ENUM('WEB','MOBILE','EMAIL') DEFAULT 'WEB',
  mood_pre TINYINT,
  mood_post TINYINT,
  CONSTRAINT fk_hechos_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  CONSTRAINT fk_hechos_recurso
    FOREIGN KEY (id_recurso) REFERENCES recursos(id_recurso),
  CONSTRAINT fk_hechos_suscripcion
    FOREIGN KEY (id_suscripcion) REFERENCES suscripciones(id_suscripcion)
);

-- 5. Índices
-- ----------

CREATE INDEX idx_respuestas_usuario ON respuestas_test(id_usuario);
CREATE INDEX idx_interaccion_usuario_fecha ON hechos_interaccion(id_usuario, fecha_interaccion);
CREATE INDEX idx_pagos_fecha ON pagos(fecha_pago);

-- 6. Funciones
-- ------------

DELIMITER $$

CREATE FUNCTION fn_calcular_edad(p_fecha_nacimiento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE v_edad INT;
  IF p_fecha_nacimiento IS NULL THEN
    RETURN NULL;
  END IF;
  SET v_edad = TIMESTAMPDIFF(YEAR, p_fecha_nacimiento, CURDATE());
  RETURN v_edad;
END$$

CREATE FUNCTION fn_clasificar_mood(p_puntaje TINYINT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  DECLARE v_resultado VARCHAR(20);
  IF p_puntaje IS NULL THEN
    SET v_resultado = 'SIN_DATO';
  ELSEIF p_puntaje <= 3 THEN
    SET v_resultado = 'CRITICO';
  ELSEIF p_puntaje BETWEEN 4 AND 6 THEN
    SET v_resultado = 'VULNERABLE';
  ELSE
    SET v_resultado = 'ESTABLE';
  END IF;
  RETURN v_resultado;
END$$

DELIMITER ;

-- 7. Stored Procedures
-- --------------------

DELIMITER $$

CREATE PROCEDURE sp_registrar_interaccion (
  IN p_id_usuario INT,
  IN p_id_recurso INT,
  IN p_id_suscripcion INT,
  IN p_minutos_consumidos INT,
  IN p_fuente VARCHAR(10),
  IN p_mood_pre TINYINT,
  IN p_mood_post TINYINT
)
BEGIN
  INSERT INTO hechos_interaccion (
    id_usuario,
    id_recurso,
    id_suscripcion,
    fecha_interaccion,
    minutos_consumidos,
    completado,
    fuente,
    mood_pre,
    mood_post
  ) VALUES (
    p_id_usuario,
    p_id_recurso,
    p_id_suscripcion,
    NOW(),
    p_minutos_consumidos,
    1,
    p_fuente,
    p_mood_pre,
    p_mood_post
  );
END$$

CREATE PROCEDURE sp_resumen_usuario (
  IN p_id_usuario INT
)
BEGIN
  -- Datos básicos
  SELECT u.id_usuario,
         u.nombre,
         u.correo,
         fn_calcular_edad(u.fecha_nacimiento) AS edad,
         p.nombre AS pais
  FROM usuarios u
  LEFT JOIN paises p ON u.id_pais = p.id_pais
  WHERE u.id_usuario = p_id_usuario;

  -- Interacciones con recursos
  SELECT COUNT(*) AS total_interacciones,
         SUM(minutos_consumidos) AS minutos_totales
  FROM hechos_interaccion
  WHERE id_usuario = p_id_usuario;

  -- Sesiones completadas
  SELECT COUNT(*) AS total_sesiones,
         SUM(duracion_minutos) AS minutos_sesiones
  FROM sesiones
  WHERE id_usuario = p_id_usuario
    AND estado = 'COMPLETADA';

  -- Pagos aplicados
  SELECT COUNT(*) AS total_pagos,
         SUM(monto) AS monto_total
  FROM pagos
  WHERE id_usuario = p_id_usuario
    AND estado = 'APLICADO';
END$$

DELIMITER ;

-- 8. Triggers
-- -----------

DELIMITER $$

CREATE TRIGGER trg_usuarios_before_insert
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
  IF NEW.fecha_registro IS NULL THEN
    SET NEW.fecha_registro = CURDATE();
  END IF;
END$$

CREATE TRIGGER trg_pagos_after_insert
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
  IF NEW.estado = 'APLICADO' AND NEW.id_suscripcion IS NOT NULL THEN
    UPDATE suscripciones
    SET estado = 'ACTIVA'
    WHERE id_suscripcion = NEW.id_suscripcion;
  END IF;
END$$

DELIMITER ;

-- 9. Vistas
-- ---------

CREATE VIEW vw_usuarios_por_pais AS
SELECT p.nombre AS pais,
       COUNT(u.id_usuario) AS total_usuarias
FROM paises p
LEFT JOIN usuarios u ON u.id_pais = p.id_pais
GROUP BY p.id_pais, p.nombre;

CREATE VIEW vw_resumen_suscripciones AS
SELECT s.id_suscripcion,
       u.nombre AS usuaria,
       pl.nombre AS plan,
       s.estado,
       s.fecha_inicio,
       s.fecha_fin
FROM suscripciones s
JOIN usuarios u ON s.id_usuario = u.id_usuario
JOIN planes_suscripcion pl ON s.id_plan = pl.id_plan;

CREATE VIEW vw_interacciones_por_recurso AS
SELECT r.id_recurso,
       r.titulo,
       r.tipo,
       COUNT(h.id_hecho) AS total_interacciones,
       SUM(h.minutos_consumidos) AS minutos_totales
FROM recursos r
LEFT JOIN hechos_interaccion h ON h.id_recurso = r.id_recurso
GROUP BY r.id_recurso, r.titulo, r.tipo;

CREATE VIEW vw_mood_mensual AS
SELECT m.id_usuario,
       DATE_FORMAT(m.fecha, '%Y-%m-01') AS mes,
       AVG(m.puntaje_mood) AS mood_promedio
FROM registros_mood m
GROUP BY m.id_usuario, DATE_FORMAT(m.fecha, '%Y-%m-01');

CREATE VIEW vw_ingresos_mensuales AS
SELECT DATE_FORMAT(p.fecha_pago, '%Y-%m-01') AS mes,
       mp.nombre AS medio_pago,
       SUM(p.monto) AS monto_total
FROM pagos p
JOIN medios_pago mp ON p.id_medio = mp.id_medio
WHERE p.estado = 'APLICADO'
GROUP BY DATE_FORMAT(p.fecha_pago, '%Y-%m-01'), mp.nombre;

CREATE VIEW vw_sesiones_por_profesional AS
SELECT pr.id_profesional,
       pr.nombre AS profesional,
       COUNT(s.id_sesion) AS total_sesiones,
       SUM(s.duracion_minutos) AS minutos_totales
FROM profesionales pr
LEFT JOIN sesiones s ON s.id_profesional = pr.id_profesional
  AND s.estado = 'COMPLETADA'
GROUP BY pr.id_profesional, pr.nombre;

-- FIN SCRIPT 01
