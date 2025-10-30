-- =========================================
-- Script: takeone_seed.sql
-- Inserta datos de prueba y ejemplos (Entrega 2)
-- Ejecutar después de takeone_objects.sql
-- =========================================
USE takeone_munoz;

-- ========== USUARIOS ==========
INSERT INTO usuarios (nombre, correo, edad, pais, fecha_registro) VALUES
('Ana Torres', 'ANA.TORRES@MAIL.COM', 24, 'México', NULL),
('Brenda Ruiz', 'brenda.ruiz@mail.com', 31, 'México', '2025-10-01'),
('Carla Gómez', 'carla.gomez@mail.com', 46, 'Costa Rica', NULL);

-- ========== PROFESIONALES ==========
INSERT INTO profesionales (nombre, especialidad, correo) VALUES
('Lucía Pérez', 'Ansiedad y Regulación Emocional', 'lucia.perez@takeone.mx'),
('María León', 'Autoestima y Autoconfianza', 'maria.leon@takeone.mx');

-- ========== TESTS ==========
INSERT INTO tests (nombre_test, descripcion) VALUES
('Ansiedad – Breve', 'Cuestionario breve para identificar señales de ansiedad.'),
('Procrastinación – Hábitos', 'Explora hábitos y disparadores de procrastinación.');

-- ========== RECURSOS ==========
INSERT INTO recursos (titulo, tipo, enlace, categoria) VALUES
('Respiración 4-7-8', 'audio', 'https://example.com/respiracion', 'regulacion_emocional'),
('Diario de Autoafirmaciones', 'pdf', 'https://example.com/autoafirmaciones', 'autoconfianza'),
('Técnica Pomodoro 25/5', 'articulo', 'https://example.com/pomodoro', 'productividad'),
('Guía: Pausas Conscientes', 'pdf', 'https://example.com/pausas', 'bienestar_general');

-- ========== RESPUESTAS ==========
-- Dejamos algunas directas y otras por SP para mostrar ambos caminos
INSERT INTO respuestas (id_usuario, id_test, resultado, fecha) VALUES
(1, 1, 'Ansiedad', NULL),
(1, 2, 'Procrastinacion', NULL),
(2, 1, 'Estrés', NULL),
(3, 2, 'Enfoque', NULL);

-- ========== SESIONES ==========
-- Uso del SP (valida fecha futura y estado por defecto)
CALL sp_agendar_sesion(1, 1, DATE_ADD(NOW(), INTERVAL 3 DAY), 'Herramientas para regular ansiedad');
CALL sp_agendar_sesion(2, 2, DATE_ADD(NOW(), INTERVAL 5 DAY), 'Refuerzo de autoestima');

-- ========== OTRAS OPERACIONES ==========
-- Registrar respuesta por SP (fecha = hoy)
CALL sp_registrar_respuesta(2, 2, 'Procrastinacion');

-- Recomendación de recursos por última respuesta (usuario 1)
CALL sp_recomendar_recursos_por_ultima_respuesta(1);

-- ========== QUERIES DE VALIDACIÓN ==========
SELECT * FROM v_usuarios_resumen;
SELECT * FROM v_agenda_sesiones;
SELECT * FROM v_respuestas_por_test;
SELECT * FROM v_sesiones_pendientes;
