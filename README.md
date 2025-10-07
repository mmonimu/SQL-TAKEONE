# SQL-TAKEONE
SQL at coderhouse. Proyecto take one

1. Introducción

El proyecto Take One consiste en el diseño de una base de datos relacional que organiza y centraliza la información de un toolkit de bienestar femenino.
Este toolkit ofrece quizzes de autoconocimiento, recursos educativos y sesiones personalizadas para acompañar a las usuarias en su proceso de regulación emocional, autoconfianza y crecimiento personal.

Objetivo

El objetivo principal de esta base de datos es estructurar la información de usuarias, profesionales, recursos y resultados de los quizzes, permitiendo:
* Registrar y relacionar de manera eficiente los datos.
* Analizar tendencias y comportamientos de las usuarias.
* Facilitar la personalización de contenidos y sesiones.
* Contar con una base sólida para futuras herramientas analíticas o dashboards.


2.  Situación problemática

En el desarrollo de plataformas de bienestar, los datos suelen almacenarse en hojas de cálculo o documentos dispersos, lo que genera desorden, pérdida de información y dificultad para analizar patrones.
Esta falta de estructura impide identificar con precisión las necesidades emocionales más comunes, los recursos más utilizados o los temas más solicitados por las usuarias.
Con la implementación de una base de datos relacional, Take One podrá:
* Integrar toda la información en un solo entorno.
* Evitar duplicidades.
* Facilitar consultas y reportes analíticos.
* Servir como base para un sistema más robusto con inteligencia de negocios.

3. Modelo de negocio

Take One funciona como un ecosistema digital de bienestar enfocado en mujeres.
A través de una plataforma web, las usuarias pueden:
* Registrarse y crear un perfil.
* Responder quizzes de autoconocimiento.
* Acceder a recursos (artículos, podcasts, meditaciones, herramientas descargables).
* Agendar sesiones con profesionales o facilitadoras.
* Recibir recomendaciones personalizadas según su perfil emocional.

Estructura general de datos:
* *Usuarias:* registran sus datos personales.
* *Tests:* contienen las preguntas y resultados posibles.
* *Respuestas:* guardan los resultados individuales.
* *Profesionales:* ofrecen sesiones y recursos.
* *Sesiones:* conectan usuarias con profesionales.
* *Recursos:* material disponible en la plataforma.

Esta base de datos busca conectar la información emocional (quizzes y resultados) con la acción (recursos y sesiones), generando insights valiosos para la toma de decisiones.

4.  Listado de tablas

| **Tabla**         | **Descripción**                                               | **Campo**      | **Abreviatura** | **Tipo de dato** | **Clave** |
| ----------------- | ------------------------------------------------------------- | -------------- | --------------- | ---------------- | --------- |
| **Usuarios**      | Guarda los datos básicos de cada usuaria.                     | id_usuario     | id_usr          | INT              | PK        |
|                   |                                                               | nombre         | nom_usr         | VARCHAR(100)     |           |
|                   |                                                               | correo         | mail_usr        | VARCHAR(100)     |           |
|                   |                                                               | edad           | edad_usr        | INT              |           |
|                   |                                                               | pais           | pais_usr        | VARCHAR(50)      |           |
|                   |                                                               | fecha_registro | fch_reg         | DATE             |           |
| **Profesionales** | Registra los coaches o facilitadoras asociadas.               | id_profesional | id_prof         | INT              | PK        |
|                   |                                                               | nombre         | nom_prof        | VARCHAR(100)     |           |
|                   |                                                               | especialidad   | esp_prof        | VARCHAR(100)     |           |
|                   |                                                               | correo         | mail_prof       | VARCHAR(100)     |           |
| **Tests**         | Define los quizzes disponibles.                               | id_test        | id_tst          | INT              | PK        |
|                   |                                                               | nombre_test    | nom_tst         | VARCHAR(100)     |           |
|                   |                                                               | descripcion    | desc_tst        | TEXT             |           |
| **Respuestas**    | Almacena los resultados de cada usuaria.                      | id_respuesta   | id_resp         | INT              | PK        |
|                   |                                                               | id_usuario     | id_usr          | INT              | FK        |
|                   |                                                               | id_test        | id_tst          | INT              | FK        |
|                   |                                                               | resultado      | res_resp        | VARCHAR(50)      |           |
|                   |                                                               | fecha          | fch_resp        | DATE             |           |
| **Sesiones**      | Guarda las sesiones agendadas entre usuarias y profesionales. | id_sesion      | id_ses          | INT              | PK        |
|                   |                                                               | id_usuario     | id_usr          | INT              | FK        |
|                   |                                                               | id_profesional | id_prof         | INT              | FK        |
|                   |                                                               | fecha          | fch_ses         | DATETIME         |           |
|                   |                                                               | tema           | tema_ses        | VARCHAR(100)     |           |
|                   |                                                               | estado         | est_ses         | VARCHAR(50)      |           |
| **Recursos**      | Material educativo disponible.                                | id_recurso     | id_rec          | INT              | PK        |
|                   |                                                               | titulo         | tit_rec         | VARCHAR(100)     |           |
|                   |                                                               | tipo           | tip_rec         | VARCHAR(50)      |           |
|                   |                                                               | enlace         | url_rec         | VARCHAR(255)     |           |
|                   |                                                               | categoria      | cat_rec         | VARCHAR(50)      |           |

