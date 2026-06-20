# 01 — Glosario

Vocabulario único del dominio Alexandrya. Cualquier término en otros documentos se entiende según esta definición.

## Estructura de contenido

| Término | Definición |
|---------|------------|
| **Materia** | Disciplina académica de nivel superior del catálogo. Catálogo inicial: Química, Matemáticas, Competencias escritas, Biología, Competencia lectora, Historia, Física, Español / Literatura, Filosofía, Geografía e Historia Universal. Es configurable y se puede agregar sin tocar código. |
| **Módulo** | Subdivisión mayor dentro de una materia. Agrupa temas relacionados. |
| **Tema** | Unidad de contenido dentro de un módulo. |
| **Subtema** | Subdivisión opcional de un tema; nivel más granular del árbol de contenido. |
| **Banco de preguntas** | Conjunto de preguntas asociadas a un tema/subtema, del cual se arman las evaluaciones. |
| **Pregunta / Reactivo** | Ítem evaluable de opción múltiple (A, B, C, D) con una única respuesta correcta, más metadatos (dificultad, tiempo estimado, etc.). "Reactivo" es el término de uso común en evaluación estandarizada; aquí es **sinónimo de pregunta**. |
| **Opción** | Cada una de las 4 respuestas posibles (A–D) de una pregunta. Su contenido puede ser texto, **fórmula** (LaTeX/MathML) o **imagen** (opción enriquecida). |
| **Estímulo / Texto base / Lectura** | Contenido compartido (lectura, caso, imagen o gráfico) que sirve de base a **uno o más reactivos**. Ejemplo: un texto de comprensión lectora con párrafos numerados y notas al pie, con varias preguntas asociadas. Ver [RF-033](../05-requerimientos/RF-033-contenido-reactivo.md). |
| **Contenido enriquecido** | Contenido que no es texto plano: **fórmulas matemáticas/químicas** (LaTeX/MathML), markdown o HTML, en enunciados, opciones, explicaciones y estímulos. Cada campo lleva un `formato` que indica cómo renderizarlo. |
| **Respuesta correcta** | La opción marcada como válida para una pregunta. |
| **Explicación** | Texto que justifica la respuesta correcta; se muestra como retroalimentación posterior. |
| **Tip** | Sugerencia breve para resolver la pregunta. |
| **Material de apoyo** | Recurso adjunto (video, PDF, imagen, enlace interno) ligado a una pregunta o tema. Solo visible dentro de la plataforma; sin descarga directa. |
| **Nivel de dificultad** | Clasificación de la pregunta (ej.: Fácil, Media, Difícil). |
| **Tiempo estimado** | Duración sugerida para resolver una pregunta; alimenta el cálculo de tiempos del simulador. |

## Evaluaciones

| Término | Definición |
|---------|------------|
| **Evaluación** | Término genérico para cualquier prueba que realiza el alumno. |
| **Examen por tema** | Evaluación acotada a un solo tema. |
| **Examen por módulo** | Evaluación que cubre los temas de un módulo. |
| **Examen por materia** | Evaluación que cubre los módulos de una materia. |
| **Examen general** | Evaluación que mezcla preguntas de varias materias. |
| **Simulador** | Evaluación que replica el examen real: estructura, número de preguntas y tiempo límite. |
| **Intento** | Cada ejecución de una evaluación por parte de un alumno; se registra de forma independiente. |
| **Calificación** | Resultado numérico de un intento (ej.: aciertos / total, o porcentaje). |
| **Retroalimentación inmediata** | Indicación de correcto/incorrecto y explicación mostrada al responder o al finalizar, según la configuración de la evaluación. |
| **Configuración de evaluación** | Parámetros definidos en administración: número de preguntas, tiempo, materias/temas incluidos, modo de retroalimentación. |

## Progreso y métricas

| Término | Definición |
|---------|------------|
| **Historial** | Registro completo de intentos del alumno con fecha, tiempo, materia, módulo, tema y resultado. |
| **Avance general** | Indicador agregado del progreso del alumno en toda la plataforma. |
| **Avance por materia** | Progreso del alumno dentro de una materia específica. |
| **Área de oportunidad** | Tema o subtema con desempeño bajo según las métricas del alumno. |
| **Tema débil / fuerte** | Clasificación de un tema según el desempeño histórico del alumno. |
| **Recomendación automática** | Sugerencia generada por el sistema (ej.: "repasa X") con base en las métricas. |
| **Dashboard** | Vista visual que consolida avance, fortalezas, debilidades y recomendaciones. |

## Cuenta, acceso y seguridad

| Término | Definición |
|---------|------------|
| **Visitante** | Usuario no autenticado. |
| **Alumno** | Usuario registrado. Solo accede al contenido si su suscripción está activa. |
| **Suscripción** | Derecho de acceso al contenido por un periodo de 1 año. |
| **Vigencia** | Periodo durante el cual la suscripción está activa (1 año desde el pago confirmado). |
| **Suscripción vencida** | Estado en el que la vigencia expiró; la cuenta existe pero no accede al contenido. |
| **Renovación** | Nueva compra que extiende la vigencia de una suscripción existente. |
| **Sesión** | Periodo autenticado de un alumno en un dispositivo. La plataforma permite **una sola sesión activa** por cuenta. |
| **Sesión única** | Regla por la que iniciar sesión en un nuevo dispositivo cierra la sesión anterior. |
| **JWT (access token)** | Token de acceso de vida corta usado para autenticar peticiones a la API. |
| **Refresh token** | Token de vida más larga usado para renovar el access token. |
| **MFA** | Autenticación multifactor; segundo factor opcional para el login. |
| **Rate limiting** | Límite de peticiones por unidad de tiempo para mitigar abuso y bots. |
| **Auditoría** | Registro inmutable de eventos sensibles (accesos, cambios, pagos) para trazabilidad. |

## Pagos y referidos

| Término | Definición |
|---------|------------|
| **Pasarela de pago** | Servicio externo que procesa cobros (Stripe, Mercado Pago, etc.). |
| **Pago recurrente** | Cobro automático en cada renovación de la suscripción. |
| **SPEI** | Sistema de pagos electrónicos interbancarios de México (transferencia). |
| **Validación automática** | Confirmación del pago por webhook de la pasarela, sin intervención manual. |
| **Referido** | Persona que se registra usando el código/enlace de un alumno. |
| **Código de referido** | Identificador único que un alumno comparte para invitar (hasta 3). |
| **Beneficio de referido** | Recompensa configurable que recibe quien refiere al cumplirse condiciones (ej.: extensión de suscripción). |

## Protección de contenido

| Término | Definición |
|---------|------------|
| **Watermark dinámico** | Marca de agua personalizada (ej.: con el correo/ID del alumno) superpuesta al contenido para desincentivar la fuga. |
| **URL temporal / firmada** | Enlace de acceso a un recurso con expiración corta, para impedir la compartición persistente. |
| **Tokenización de medios** | Entrega de video/archivos solo a sesiones válidas mediante tokens de corta duración. |
| **FLAG_SECURE** | Bandera de Android que bloquea capturas de pantalla y grabación en una vista. No impide fotografiar la pantalla con otro dispositivo. |
| **DRM** | Gestión de derechos digitales para video (ej.: Widevine); cifra el contenido y controla su reproducción. |

## Roles

| Rol | Permisos resumidos |
|-----|--------------------|
| **Administrador** | Acceso total al panel: usuarios, contenido, pagos, suscripciones, referidos, reportes. |
| **Editor de contenido** | Crea y edita catálogo (materias → preguntas) y carga masiva; sin acceso a pagos ni usuarios. |
| **Alumno** | Consume contenido y se evalúa; gestiona su perfil y referidos. |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/02-glosario/glosario.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
