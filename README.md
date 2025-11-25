✨ Take One – Base de Datos SQL

Proyecto Final – Curso SQL
Autora: Mónica Muñoz

📌 Descripción general

Take One es un toolkit de bienestar emocional con perspectiva feminista que integra tests breves, ejercicios, recursos descargables, sesiones con profesionales y un sistema de mood tracking.

Este repositorio contiene el modelo de base de datos completo, sus scripts de creación, scripts de carga, vistas, funciones, triggers, stored procedures y tabla de hechos, diseñado para soportar el funcionamiento de Take One a nivel técnico y analítico.

📁 Contenido del repositorio
├── 01_takeone_schema.sql      # Script de creación de tablas + vistas + SP + triggers + funciones
├── 02_takeone_inserts.sql     # Script de inserción de datos ejemplo
└── README.md                  # Documentación completa del proyecto
⚠️ Los archivos previos (takeone_munoz.sql, takeone_objects.sql, takeone_seed.sql) se mantienen como versiones antiguas, pero NO forman parte del entregable final.

🧠 1. Introducción
La plataforma Take One busca acompañar a mujeres en temas como ansiedad, perfeccionismo, síndrome del impostor y agotamiento emocional mediante:
* Tests breves
* Recursos del toolkit
* Sesiones con profesionales
* Mood tracking
* Suscripciones

Para sostener todas estas interacciones, se desarrolló una base de datos relacional robusta, escalable y preparada para análisis.

Este repositorio incluye todo el ecosistema técnico necesario para que Take One funcione en producción.

🎯 2. Objetivos del proyecto
Objetivo general
Diseñar e implementar una base de datos relacional que permita administrar, relacionar y analizar la información generada por Take One.

Objetivos específicos
* Crear un esquema con más de 15 tablas, incluyendo transaccionales y una tabla de hechos.
* Implementar vistas, triggers, funciones y stored procedures.
* Insertar datos realistas para pruebas.
* Permitir consultas que respondan a preguntas críticas del negocio:
   * ¿Qué recursos funcionan mejor?
   * ¿Cómo cambia el mood antes y después de usarlos?
   * ¿Cuáles son los países y planes más activos?
   * ¿Cuál es la evolución de ingresos?

Integrarlo con herramientas de analítica como Excel y Power BI.

🚨 3. Situación problemática
Antes de implementar esta base, Take One tendría los típicos problemas de operaciones con hojas de Excel:
* Duplicidad de información
* Datos sin relación
* Imposibilidad de medir resultados o impacto emocional
* Falta de trazabilidad para suscripciones, pagos y sesiones
* Difícil escalabilidad

Con este modelo relacional:
* Se ordena todo en entidades limpias
* Se puede medir impacto emocional
* Se puede hacer seguimiento del uso real del toolkit
* Es fácil escalar nuevas funcionalidades (comunidad, retos, etc.)

🏛️ 4. Modelo de negocio
El modelo freemium de Take One incluye:

👤 Usuarias
Registro por canales como Instagram, TikTok y orgánico.
🧪 Tests
Cuestionarios breves sobre ansiedad, impostor y multipotencialidad.
📚 Recursos del toolkit
Ejercicios, artículos, videos, descargables y podcasts.
🧑‍⚕️ Profesionales
Psicólogas y coaches de distintas especialidades.
📅 Sesiones
Asesoría emocional en línea.
💳 Suscripciones y pagos
Planes Free, Básico y Premium.
💙 Mood Tracking
Evolución emocional día con día.
📊 Interacciones (Fact table)
Registra cuántos minutos usó la usuaria un recurso, cómo llegó y cómo cambió su mood.

🗺️ 5. Diagrama E-R
El archivo está como Flow Chart Final en los documentos del repositorio

🗃️ 6. Scripts del proyecto
📜 Script 1 — Esquema de la base de datos
👉** Archivo: 01_takeone_schema.sql**
Incluye:
* Creación de la base de datos
* 20 tablas
* Relaciones y FK
* Índices
* 6 vistas
* 2 funciones
* 2 triggers
* 2 stored procedures

📜 Script 2 — Inserción de datos
👉** Archivo: 02_takeone_inserts.sql**
Incluye datos de ejemplo para:
* Países
* Usuarias
* Profesionales
* Tests y preguntas
* Recursos
* Categorías
* Suscripciones
* Sesssiones
* Pagos
* Mood tracking
* Tabla de hechos: interacciones

📊 7. Informes e insights generados
✔️ Uso del toolkit
Mide qué recursos son más populares y cuántos minutos acumulan.
Vista: vw_interacciones_por_recurso.

✔️ Impacto emocional
Comparación mood_pre vs mood_post.
Insight: recursos breves → mayor mejora.

✔️ Usuarias por país y plan
México es el mercado más fuerte para planes Premium.

✔️ Ingresos mensuales
PayPal gana fuerza internacional; tarjeta domina local.

✔️ Resumen por usuaria (SP)
CALL sp_resumen_usuario(1);
Devuelve:
* Datos de usuaria
* Interacciones
* Sesiones
* Pagos aplicados

🔧 8. Herramientas utilizadas
* MySQL
* MySQL Workbench
* Mermaid (diagrama ER)
* Excel / Power BI (informes)
* GitHub (control de versiones)

🏁 9. Conclusiones
Este proyecto consolida Take One en una estructura técnica sólida y preparada para crecimiento:
* Datos limpios, conectados y trazables
* Una tabla de hechos para análisis avanzado
* Objetos SQL que automatizan procesos
* Informes que permiten tomar decisiones basadas en datos
* Una estructura lista para futuras funciones como recomendaciones personalizadas, gamificación y análisis de cohortes

La arquitectura está lista para escalar Take One como producto real.
