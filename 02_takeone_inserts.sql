USE takeone_munoz;

-- Países
INSERT INTO paises (nombre) VALUES
('México'),
('Costa Rica'),
('Argentina');

-- Usuarios
INSERT INTO usuarios (nombre, correo, fecha_nacimiento, genero, id_pais, fecha_registro, canal_registro)
VALUES
('Mariana Flores', 'mariana@example.com', '1994-05-10', 'F', 1, CURDATE(), 'Instagram'),
('Ana Pérez', 'ana@example.com', '1990-08-21', 'F', 1, CURDATE(), 'TikTok'),
('Sofía Ramírez', 'sofia@example.com', '1988-11-03', 'F', 2, CURDATE(), 'Orgánico');

-- Profesionales
INSERT INTO profesionales (nombre, correo, especialidad_principal, id_pais, fecha_alta) VALUES
('Laura Psicóloga', 'laura.psico@example.com', 'Psicología clínica', 1, CURDATE()),
('Carla Coach', 'carla.coach@example.com', 'Coaching de vida', 1, CURDATE());

-- Especialidades
INSERT INTO especialidades (nombre, descripcion) VALUES
('Ansiedad', 'Acompañamiento para manejo de ansiedad'),
('Burnout', 'Acompañamiento en agotamiento laboral'),
('Multipotencialidad', 'Acompañamiento para perfiles multipotenciales');

-- Profesional - Especialidad
INSERT INTO profesional_especialidad (id_profesional, id_especialidad) VALUES
(1,1),
(1,2),
(2,3);

-- Planes de suscripción
INSERT INTO planes_suscripcion (nombre, descripcion, precio_mensual, duracion_meses, nivel) VALUES
('Free', 'Acceso limitado a recursos gratuitos', 0.00, 0, 'FREE'),
('Toolkit Básico', 'Acceso a toolkit y tests', 199.00, 1, 'BASIC'),
('Toolkit Premium', 'Acceso completo a toolkit, tests y sesiones grupales', 399.00, 1, 'PREMIUM');

-- Medios de pago
INSERT INTO medios_pago (nombre) VALUES
('Tarjeta de crédito'),
('Tarjeta de débito'),
('PayPal');

-- Categorías de recurso
INSERT INTO categorias_recurso (nombre, descripcion) VALUES
('Ansiedad', 'Recursos enfocados en manejo de ansiedad'),
('Perfeccionismo', 'Recursos enfocados en perfeccionismo'),
('Síndrome del impostor', 'Recursos sobre autoexigencia e impostor'),
('Multipotencialidad', 'Recursos para personas multipotenciales');

-- Tests
INSERT INTO tests (nombre_test, descripcion, nivel_dificultad, tipo) VALUES
('Test rápido de ansiedad', 'Cuestionario breve para identificar señales de ansiedad cotidiana.', 'BAJO', 'Ansiedad'),
('Test de síndrome del impostor', 'Identifica patrones de autoexigencia e invalidación de logros.', 'MEDIO', 'Impostor');

-- Preguntas
INSERT INTO preguntas (id_test, texto_pregunta, orden, tipo_respuesta) VALUES
(1, 'En los últimos 7 días, ¿qué tan seguido has sentido preocupación excesiva?', 1, 'ESCALA'),
(1, '¿Te cuesta trabajo relajarte después del trabajo/escuela?', 2, 'ESCALA'),
(2, '¿Te cuesta aceptar cumplidos sobre tu trabajo?', 1, 'ESCALA');

-- Opciones
INSERT INTO opciones_pregunta (id_pregunta, texto_opcion, valor_numerico) VALUES
(1, 'Casi nunca', 1),
(1, 'A veces', 2),
(1, 'Casi siempre', 3),
(2, 'Casi nunca', 1),
(2, 'A veces', 2),
(2, 'Casi siempre', 3),
(3, 'Casi nunca', 1),
(3, 'A veces', 2),
(3, 'Casi siempre', 3);

-- Recursos
INSERT INTO recursos (titulo, tipo, nivel_dificultad, url, duracion_minutos, tag_principal) VALUES
('Respiración 4-7-8 para bajar ansiedad', 'EJERCICIO', 'BAJO', 'https://takeone.com/respiracion-478', 5, 'ansiedad'),
('Mini guía: soltar el perfeccionismo', 'ARTICULO', 'MEDIO', 'https://takeone.com/perfeccionismo', 10, 'perfeccionismo'),
('Rutina de journaling: impostor al descubierto', 'DESCARGABLE', 'MEDIO', 'https://takeone.com/journal-impostor', 15, 'impostor'),
('Módulo: multipotencialidad sin culpa', 'VIDEO', 'ALTO', 'https://takeone.com/multipotencialidad', 25, 'multipotencialidad');

-- Relación recurso - categoría
INSERT INTO recurso_categoria (id_recurso, id_categoria) VALUES
(1,1),
(2,2),
(3,3),
(4,4);

-- Suscripciones
INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin, estado) VALUES
(1, 2, '2025-10-01', '2025-10-31', 'ACTIVA'),
(2, 1, '2025-10-05', NULL, 'ACTIVA'),
(3, 3, '2025-10-10', '2025-11-09', 'ACTIVA');

-- Sesiones
INSERT INTO sesiones (id_usuario, id_profesional, fecha_sesion, duracion_minutos, modalidad, estado, motivo) VALUES
(1, 1, '2025-10-15 19:00:00', 60, 'ONLINE', 'COMPLETADA', 'Ansiedad y burnout en el trabajo'),
(1, 1, '2025-10-22 19:00:00', 60, 'ONLINE', 'COMPLETADA', 'Seguimiento ansiedad'),
(3, 2, '2025-10-20 18:00:00', 45, 'ONLINE', 'CANCELADA', 'Multipotencialidad');

-- Pagos
INSERT INTO pagos (id_usuario, id_suscripcion, id_medio, fecha_pago, monto, estado, referencia) VALUES
(1, 1, 1, '2025-10-01 10:15:00', 199.00, 'APLICADO', 'PAY-001'),
(3, 3, 2, '2025-10-10 09:30:00', 399.00, 'APLICADO', 'PAY-002');

-- Logs de acceso
INSERT INTO logs_acceso (id_usuario, fecha_acceso, dispositivo, ip, origen) VALUES
(1, '2025-10-15 08:00:00', 'iPhone', '192.168.0.10', 'MOBILE'),
(1, '2025-10-15 20:30:00', 'Laptop', '192.168.0.11', 'WEB'),
(2, '2025-10-16 09:10:00', 'Android', '192.168.0.12', 'MOBILE');

-- Registros de mood
INSERT INTO registros_mood (id_usuario, fecha, puntaje_mood, energia, notas) VALUES
(1, '2025-10-14', 4, 3, 'Mucho estrés por trabajo'),
(1, '2025-10-15', 6, 5, 'Mejor después de sesión y respiración'),
(1, '2025-10-16', 7, 6, 'Más tranquila'),
(2, '2025-10-14', 5, 5, 'Cansancio general'),
(3, '2025-10-14', 3, 2, 'Sensación de bloqueo');

-- Respuestas de test
INSERT INTO respuestas_test (id_usuario, id_pregunta, id_opcion, fecha_respuesta) VALUES
(1, 1, 3, '2025-10-14 08:00:00'),
(1, 2, 2, '2025-10-14 08:01:00'),
(2, 1, 2, '2025-10-15 09:00:00'),
(3, 3, 2, '2025-10-16 10:00:00');

-- Hechos de interacción
INSERT INTO hechos_interaccion (
  id_usuario, id_recurso, id_suscripcion, fecha_interaccion,
  minutos_consumidos, completado, fuente, mood_pre, mood_post
) VALUES
(1, 1, 1, '2025-10-15 07:50:00', 5, 1, 'MOBILE', 4, 6),
(1, 2, 1, '2025-10-15 21:00:00', 10, 1, 'WEB', 6, 7),
(2, 3, 2, '2025-10-16 21:30:00', 15, 1, 'WEB', 5, 6),
(3, 4, 3, '2025-10-20 19:00:00', 20, 1, 'WEB', 3, 5);

-- FIN SCRIPT 02
