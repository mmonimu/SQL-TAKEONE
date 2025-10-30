-- =========================================
-- Script: takeone_objects.sql
-- Crea Vistas, Funciones, Stored Procedures y Triggers (Entrega 2)
-- Ejecutar después de takeone_schema.sql
-- =========================================
USE takeone_munoz;

-- Limpieza preventiva
DROP VIEW IF EXISTS v_sesiones_pendientes;
DROP VIEW IF EXISTS v_catalogo_recursos;
DROP VIEW IF EXISTS v_respuestas_por_test;
DROP VIEW IF EXISTS v_agenda_sesiones;
DROP VIEW IF EXISTS v_usuarios_resumen;

DROP TRIGGER IF EXISTS trg_respuestas_bi_setfecha;
DROP TRIGGER IF EXISTS trg_sesiones_bu_normaliza_estado;
DROP TRIGGER IF EXISTS trg_sesiones_bi_validafecha;
DROP TRIGGER IF EXISTS trg_usuarios_bi_defaults;

DROP PROCEDURE IF EXISTS sp_recomendar_recursos_por_ultima_respuesta;
DROP PROCEDURE IF EXISTS sp_registrar_respuesta;
DROP PROCEDURE IF EXISTS sp_agendar_sesion;

DROP FUNCTION IF EXISTS fn_categoria_desde_resultado;
DROP FUNCTION IF EXISTS fn_normaliza_estado_sesion;
DROP FUNCTION IF EXISTS fn_segmento_edad;

-- ======================
-- FUNCIONES
-- ======================
DELIMITER //
CREATE FUNCTION fn_segmento_edad(p_edad INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  IF p_edad IS NULL THEN RETURN 'Sin_Dato';
  ELSEIF p_edad < 26 THEN RETURN 'Joven';
  ELSEIF p_edad BETWEEN 26 AND 44 THEN RETURN 'Adulto';
  ELSE RETURN 'Adulto_Mayor';
  END IF;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_normaliza_estado_sesion(p_estado VARCHAR(50))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  SET p_estado = LOWER(TRIM(p_estado));
  IF p_estado IN ('pendiente','pending') THEN RETURN 'pendiente';
  ELSEIF p_estado IN ('confirmada','confirmado','confirmed') THEN RETURN 'confirmada';
  ELSEIF p_estado IN ('cancelada','cancelado','canceled') THEN RETURN 'cancelada';
  ELSEIF p_estado IN ('realizada','done','completada','completed') THEN RETURN 'realizada';
  ELSE RETURN 'pendiente';
  END IF;
END//
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_categoria_desde_resultado(p_resultado VARCHAR(50))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
  SET p_resultado = LOWER(TRIM(p_resultado));
  -- Ajusta mapeos a tus resultados reales del quiz
  IF p_resultado IN ('ansiedad','stress','estrés') THEN RETURN 'regulacion_emocional';
  ELSEIF p_resultado IN ('autoestima','inseguridad') THEN RETURN 'autoconfianza';
  ELSEIF p_resultado IN ('procrastinacion','procrastinación','enfoque') THEN RETURN 'productividad';
  ELSE RETURN 'bienestar_general';
  END IF;
END//
DELIMITER ;

-- ======================
-- STORED PROCEDURES
-- ======================
DELIMITER //
CREATE PROCEDURE sp_agendar_sesion(
  IN p_id_usuario INT,
  IN p_id_profesional INT,
  IN p_fecha DATETIME,
  IN p_tema VARCHAR(100)
)
BEGIN
  -- Validación: fecha futura
  IF p_fecha < NOW() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de la sesión debe ser futura';
  END IF;

  INSERT INTO sesiones (id_usuario, id_profesional, fecha, tema, estado)
  VALUES (p_id_usuario, p_id_profesional, p_fecha, p_tema, 'pendiente');

  SELECT LAST_INSERT_ID() AS id_sesion_creada;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_registrar_respuesta(
  IN p_id_usuario INT,
  IN p_id_test INT,
  IN p_resultado VARCHAR(50)
)
BEGIN
  INSERT INTO respuestas (id_usuario, id_test, resultado, fecha)
  VALUES (p_id_usuario, p_id_test, p_resultado, CURDATE());

  SELECT LAST_INSERT_ID() AS id_respuesta_creada;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_recomendar_recursos_por_ultima_respuesta(
  IN p_id_usuario INT
)
BEGIN
  DECLARE v_resultado VARCHAR(50);
  DECLARE v_categoria VARCHAR(50);

  SELECT r.resultado
    INTO v_resultado
  FROM respuestas r
  WHERE r.id_usuario = p_id_usuario
  ORDER BY r.fecha DESC, r.id_respuesta DESC
  LIMIT 1;

  SET v_categoria = fn_categoria_desde_resultado(v_resultado);

  SELECT rr.*
  FROM recursos rr
  WHERE LOWER(rr.categoria) = LOWER(v_categoria);
END//
DELIMITER ;

-- ======================
-- TRIGGERS
-- ======================
DELIMITER //
CREATE TRIGGER trg_usuarios_bi_defaults
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
  IF NEW.correo IS NOT NULL THEN
    SET NEW.correo = LOWER(NEW.correo);
  END IF;
  IF NEW.fecha_registro IS NULL THEN
    SET NEW.fecha_registro = CURDATE();
  END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_sesiones_bi_validafecha
BEFORE INSERT ON sesiones
FOR EACH ROW
BEGIN
  IF NEW.fecha < NOW() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pueden agendar sesiones en el pasado';
  END IF;
  IF NEW.estado IS NULL OR TRIM(NEW.estado) = '' THEN
    SET NEW.estado = 'pendiente';
  END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_sesiones_bu_normaliza_estado
BEFORE UPDATE ON sesiones
FOR EACH ROW
BEGIN
  IF NEW.estado IS NOT NULL THEN
    SET NEW.estado = fn_normaliza_estado_sesion(NEW.estado);
  END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_respuestas_bi_setfecha
BEFORE INSERT ON respuestas
FOR EACH ROW
BEGIN
  IF NEW.fecha IS NULL THEN
    SET NEW.fecha = CURDATE();
  END IF;
END//
DELIMITER ;

-- ======================
-- VISTAS
-- ======================

CREATE OR REPLACE VIEW v_usuarios_resumen AS
SELECT
  u.id_usuario,
  u.nombre,
  u.correo,
  u.edad,
  fn_segmento_edad(u.edad) AS segmento_edad,
  u.pais,
  u.fecha_registro,
  (SELECT COUNT(*) FROM respuestas r WHERE r.id_usuario = u.id_usuario) AS total_respuestas,
  (SELECT COUNT(*) FROM sesiones s WHERE s.id_usuario = u.id_usuario) AS total_sesiones
FROM usuarios u;

CREATE OR REPLACE VIEW v_agenda_sesiones AS
SELECT
  s.id_sesion,
  s.fecha,
  s.tema,
  s.estado,
  u.id_usuario,
  u.nombre AS usuaria,
  p.id_profesional,
  p.nombre AS profesional
FROM sesiones s
JOIN usuarios u ON u.id_usuario = s.id_usuario
JOIN profesionales p ON p.id_profesional = s.id_profesional;

CREATE OR REPLACE VIEW v_respuestas_por_test AS
SELECT
  t.id_test,
  t.nombre_test,
  r.resultado,
  COUNT(*) AS conteo
FROM tests t
LEFT JOIN respuestas r ON r.id_test = t.id_test
GROUP BY t.id_test, t.nombre_test, r.resultado;

CREATE OR REPLACE VIEW v_catalogo_recursos AS
SELECT
  id_recurso,
  titulo,
  tipo,
  categoria,
  enlace AS url
FROM recursos;

CREATE OR REPLACE VIEW v_sesiones_pendientes AS
SELECT
  s.id_sesion,
  s.fecha,
  s.tema,
  s.estado,
  u.nombre AS usuaria,
  p.nombre AS profesional
FROM sesiones s
JOIN usuarios u ON u.id_usuario = s.id_usuario
JOIN profesionales p ON p.id_profesional = s.id_profesional
WHERE s.estado = 'pendiente' AND s.fecha >= NOW();
