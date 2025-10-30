# 🌸 Take One – Toolkit de Bienestar Femenino  
**Autora:** Mónica Muñoz  
**Curso:** Proyecto Final – SQL

---

## 🩷 Introducción

El proyecto **Take One** consiste en el diseño de una base de datos relacional que organiza y centraliza la información de un *toolkit de bienestar femenino*.  
Este toolkit ofrece quizzes de autoconocimiento, recursos educativos y sesiones personalizadas para acompañar a las usuarias en su proceso de regulación emocional, autoconfianza y crecimiento personal.

### 🎯 Objetivo
Estructurar la información de usuarias, profesionales, recursos y resultados de los quizzes, permitiendo:
- Registrar y relacionar de manera eficiente los datos.
- Analizar tendencias y comportamientos de las usuarias.
- Facilitar la personalización de contenidos y sesiones.
- Contar con una base sólida para futuras herramientas analíticas o dashboards.

---

## ⚙️ Situación problemática

En el desarrollo de plataformas de bienestar, los datos suelen almacenarse en hojas de cálculo o documentos dispersos, lo que genera desorden, pérdida de información y dificultad para analizar patrones.  
Esta falta de estructura impide identificar con precisión las necesidades emocionales más comunes, los recursos más utilizados o los temas más solicitados por las usuarias.

Con la implementación de una **base de datos relacional**, Take One podrá:
- Integrar toda la información en un solo entorno.  
- Evitar duplicidades y mantener integridad referencial.  
- Facilitar consultas analíticas y visualizaciones en tiempo real.  
- Servir como base para sistemas de inteligencia de negocios o dashboards.

---

## 💼 Modelo de negocio

**Take One** funciona como un ecosistema digital de bienestar enfocado en mujeres.  
A través de una plataforma web, las usuarias pueden:

- Registrarse y crear un perfil.  
- Responder quizzes de autoconocimiento.  
- Acceder a recursos (artículos, podcasts, meditaciones, herramientas descargables).  
- Agendar sesiones con profesionales o facilitadoras.  
- Recibir recomendaciones personalizadas según su perfil emocional.

### 📊 Estructura general de datos:
- **Usuarios:** registran sus datos personales.  
- **Tests:** contienen las preguntas y resultados posibles.  
- **Respuestas:** guardan los resultados individuales.  
- **Profesionales:** ofrecen sesiones y recursos.  
- **Sesiones:** conectan usuarias con profesionales.  
- **Recursos:** material disponible en la plataforma.

Esta base de datos conecta la información emocional (quizzes y resultados) con la acción (recursos y sesiones), generando *insights* valiosos para la toma de decisiones.

---

## 🧩 Diagrama Entidad–Relación (E–R)

> Generado con [dbdiagram.io](https://dbdiagram.io)  
> Script base: [`takeone_schema.sql`](sql/takeone_schema.sql)

**Entidades principales:**
- Usuarios  
- Profesionales  
- Tests  
- Respuestas  
- Sesiones  
- Recursos  

**Relaciones:**
- Un usuario puede responder varios tests → (1:N)  
- Un test puede tener muchas respuestas → (1:N)  
- Un usuario puede tener muchas sesiones → (1:N)  
- Un profesional puede impartir muchas sesiones → (1:N)

---

## 🗂️ Listado de Tablas

| **Tabla** | **Descripción** | **Campo** | **Abreviatura** | **Tipo de dato** | **Clave** |
|------------|-----------------|------------|------------------|------------------|------------|
| **Usuarios** | Datos de las usuarias registradas. | id_usuario | id_usr | INT | PK |
|  |  | nombre | nom_usr | VARCHAR(100) |  |
|  |  | correo | mail_usr | VARCHAR(100) |  |
|  |  | edad | edad_usr | INT |  |
|  |  | pais | pais_usr | VARCHAR(50) |  |
|  |  | fecha_registro | fch_reg | DATE |  |
| **Profesionales** | Coaches o facilitadoras asociadas. | id_profesional | id_prof | INT | PK |
|  |  | nombre | nom_prof | VARCHAR(100) |  |
|  |  | especialidad | esp_prof | VARCHAR(100) |  |
|  |  | correo | mail_prof | VARCHAR(100) |  |
| **Tests** | Quizzes de autoconocimiento. | id_test | id_tst | INT | PK |
|  |  | nombre_test | nom_tst | VARCHAR(100) |  |
|  |  | descripcion | desc_tst | TEXT |  |
| **Respuestas** | Resultados individuales de las usuarias. | id_respuesta | id_resp | INT | PK |
|  |  | id_usuario | id_usr | INT | FK |
|  |  | id_test | id_tst | INT | FK |
|  |  | resultado | res_resp | VARCHAR(50) |  |
|  |  | fecha | fch_resp | DATE |  |
| **Sesiones** | Sesiones entre usuarias y profesionales. | id_sesion | id_ses | INT | PK |
|  |  | id_usuario | id_usr | INT | FK |
|  |  | id_profesional | id_prof | INT | FK |
|  |  | fecha | fch_ses | DATETIME |  |
|  |  | tema | tema_ses | VARCHAR(100) |  |
|  |  | estado | est_ses | VARCHAR(50) |  |
| **Recursos** | Material educativo disponible. | id_recurso | id_rec | INT | PK |
|  |  | titulo | tit_rec | VARCHAR(100) |  |
|  |  | tipo | tip_rec | VARCHAR(50) |  |
|  |  | enlace | url_rec | VARCHAR(255) |  |
|  |  | categoria | cat_rec | VARCHAR(50) |  |

---

# 🚀 Entrega 2 — Contenidos añadidos

> Esta sección amplía la Entrega 1 con Vistas, Funciones, Stored Procedures, Triggers e inserción de datos.

## 📦 Archivos de esta entrega
- **/sql/takeone_objects.sql** — Vistas, Funciones, Stored Procedures y Triggers.  
- **/sql/takeone_seed.sql** — Inserción de datos y ejemplos de uso.  
- **PDF:** `Entrega2_Muñoz.pdf` (incluye también la Entrega 1).

### ▶️ Orden de ejecución
1) Esquema + Tablas (Entrega 1)  
2) `sql/takeone_objects.sql`  
3) `sql/takeone_seed.sql`

---

## 👁️ Vistas (Views)

1. **v_usuarios_resumen**  
   - **Objetivo:** mostrar resumen por usuaria (cantidad de respuestas y sesiones).  
   - **Tablas:** `usuarios`, `respuestas`, `sesiones`.

2. **v_agenda_sesiones**  
   - **Objetivo:** agenda con fecha, tema, usuaria y profesional.  
   - **Tablas:** `sesiones`, `usuarios`, `profesionales`.

3. **v_respuestas_por_test**  
   - **Objetivo:** distribución de resultados por test.  
   - **Tablas:** `tests`, `respuestas`.

4. **v_catalogo_recursos**  
   - **Objetivo:** catálogo general de recursos (título, tipo, categoría, url).  
   - **Tablas:** `recursos`.

5. **v_sesiones_pendientes**  
   - **Objetivo:** listar sesiones pendientes a futuro.  
   - **Tablas:** `sesiones`, `usuarios`, `profesionales`.

---

## 🧮 Funciones (Stored Functions)

1. **fn_segmento_edad(p_edad INT)**  
   - **Objetivo:** clasifica edad en *Joven / Adulto / Adulto_Mayor*.  
   - **Uso:** segmentación para reportes.

2. **fn_normaliza_estado_sesion(p_estado VARCHAR(50))**  
   - **Objetivo:** estandariza estados a `pendiente`, `confirmada`, `cancelada`, `realizada`.  
   - **Uso:** validación en triggers o vistas.

3. **fn_categoria_desde_resultado(p_resultado VARCHAR(50))**  
   - **Objetivo:** mapea resultado de quiz a categoría de recurso.  
   - **Uso:** recomendaciones personalizadas.

---

## 🛠️ Stored Procedures

1. **sp_agendar_sesion(p_id_usuario, p_id_profesional, p_fecha, p_tema)**  
   - **Objetivo:** crear una sesión en estado `pendiente` (valida fecha futura).  
   - **Impacta:** `sesiones`.

2. **sp_registrar_respuesta(p_id_usuario, p_id_test, p_resultado)**  
   - **Objetivo:** registrar respuesta con fecha actual.  
   - **Impacta:** `respuestas`.

3. **sp_recomendar_recursos_por_ultima_respuesta(p_id_usuario)**  
   - **Objetivo:** obtener recursos recomendados según la última respuesta del usuario.  
   - **Impacta/lee:** `respuestas`, `recursos`.

---

## ⚡ Triggers

1. **trg_usuarios_bi_defaults** — *BEFORE INSERT ON usuarios*  
   - **Función:** convierte `correo` a minúsculas y agrega `fecha_registro` si es `NULL`.

2. **trg_sesiones_bi_validafecha** — *BEFORE INSERT ON sesiones*  
   - **Función:** evita sesiones con fecha anterior a `NOW()`.

3. **trg_sesiones_bu_normaliza_estado** — *BEFORE UPDATE ON sesiones*  
   - **Función:** normaliza campo `estado` usando la función `fn_normaliza_estado_sesion`.

4. **trg_respuestas_bi_setfecha** — *BEFORE INSERT ON respuestas*  
   - **Función:** si `fecha` es `NULL`, asigna la fecha actual.

---

## 🌱 Inserción de datos (Seed)

**Archivo:** `sql/takeone_seed.sql`  
Incluye usuarios, profesionales, tests, recursos, respuestas y llamadas a Stored Procedures.

### 💾 Ejemplos de uso
```sql
CALL sp_agendar_sesion(1, 1, DATE_ADD(NOW(), INTERVAL 3 DAY), 'Sesión de ansiedad');
CALL sp_registrar_respuesta(2, 2, 'Procrastinacion');
CALL sp_recomendar_recursos_por_ultima_respuesta(1);
SELECT * FROM v_usuarios_resumen;
