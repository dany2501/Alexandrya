# 06 — Reglas de Negocio (Principales)

Reglas **principales** (`RN-###`): gobiernan el comportamiento esperado del sistema en sus flujos normales, independientes de la interfaz. Son la fuente de verdad para validaciones de backend y casos de prueba.

> Las reglas de **excepción y flujos alternos** (`RNA-###`) están en [reglas-alternas.md](reglas-alternas.md).

---

## Catálogo y contenido

| ID | Regla |
|----|-------|
| RN-001 | Una materia nueva se da de alta como **dato de configuración**, sin desplegar código. El sistema debe funcionar con N materias. |
| RN-002 | La jerarquía es estricta: una materia tiene ≥1 módulo; un módulo pertenece a una sola materia; un tema a un solo módulo; un subtema a un solo tema. |
| RN-003 | Una pregunta pertenece a un tema o subtema y tiene **exactamente 4 opciones (A–D)** y **una única** respuesta correcta. |
| RN-004 | Una pregunta no puede publicarse sin: enunciado, las 4 opciones, la respuesta correcta marcada y nivel de dificultad. La explicación y el tip son recomendados pero no bloqueantes. |
| RN-005 | El material de apoyo y los medios (imagen/video) son opcionales por pregunta. |
| RN-006 | Una materia/módulo/tema/pregunta con intentos históricos no se elimina físicamente; se marca como inactiva (borrado lógico) para preservar el historial. |
| RN-007 | El contenido de un reactivo (enunciado, opciones, explicación) y de un estímulo admite **contenido enriquecido**: texto, markdown, **LaTeX/MathML** (fórmulas) o HTML saneado. Cada campo declara su `formato`. Una opción puede ser texto, fórmula o imagen ([RF-033](../05-requerimientos/RF-033-contenido-reactivo.md)). |
| RN-008 | Un **estímulo** (lectura, caso, imagen o gráfico) puede agrupar **1..N reactivos** de un mismo tema. Cuando una evaluación incluye un reactivo con estímulo, debe presentarse también su estímulo; los reactivos respetan su `orden` dentro del estímulo ([RF-033](../05-requerimientos/RF-033-contenido-reactivo.md)). |

## Suscripción y acceso

| ID | Regla |
|----|-------|
| RN-010 | El acceso a **todo** el contenido (evaluaciones y material) exige una suscripción **activa**. La landing es la única zona accesible sin suscripción. |
| RN-011 | La vigencia de la suscripción es de **1 año (365 días)** a partir de la fecha/hora de confirmación del pago. |
| RN-012 | Al alcanzar la fecha de expiración, el sistema cambia el estado a **vencida** y suspende el acceso de forma automática (sin acción manual). |
| RN-013 | Una renovación realizada **antes** del vencimiento **extiende** la vigencia desde la fecha de expiración vigente (no se pierden días). |
| RN-014 | Una renovación realizada **después** del vencimiento inicia una nueva vigencia de 1 año desde la confirmación del nuevo pago. |
| RN-015 | La cuenta de un alumno con suscripción vencida **se conserva** (perfil, historial, métricas); solo se bloquea el acceso al contenido. |
| RN-016 | Un pago no confirmado por la pasarela **no** activa ni extiende la suscripción. |

## Pagos

| ID | Regla |
|----|-------|
| RN-020 | La activación/extensión de la suscripción se dispara **solo** por confirmación de pago vía webhook de la pasarela (no por inicio del checkout). |
| RN-021 | Un webhook de pago se procesa de forma **idempotente**: reintentos de la pasarela no generan doble vigencia ni doble beneficio. |
| RN-022 | Los pagos por SPEI/transferencia se consideran liquidados solo al recibir la confirmación de acreditación, que puede ser diferida. |
| RN-023 | Todo pago (intento, éxito, fallo, reembolso) queda registrado y auditado con su identificador de la pasarela. |

## Control de sesiones

| ID | Regla |
|----|-------|
| RN-030 | Una cuenta tiene como máximo **una sesión activa** a la vez. |
| RN-031 | Al autenticarse en un dispositivo nuevo, la sesión anterior se **invalida** inmediatamente (se conserva solo la más reciente). |
| RN-032 | El access token (JWT) tiene vida corta; el refresh token permite renovarlo **solo** si la sesión sigue siendo la activa. |
| RN-033 | Cada acceso registra fecha, hora, IP, dispositivo y ubicación aproximada en el historial de la cuenta. |
| RN-034 | Cada nuevo acceso genera una notificación por correo al titular de la cuenta. |
| RN-035 | La sesión se **cierra automáticamente tras 10 minutos de inactividad** del usuario. Un minuto antes (al minuto 9) se muestra un aviso para extenderla ([MSG-029/02A](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02), [RF-080](../05-requerimientos/RF-080-sesion-unica.md)). Cualquier interacción reinicia el contador. |
| RN-036 | El cierre por inactividad invalida el access token del lado servidor; la reanudación exige re-autenticación (no basta el refresh si la sesión quedó marcada inactiva). |

## Referidos

| ID | Regla |
|----|-------|
| RN-040 | Un alumno puede tener **hasta 3** referidos efectivos. Invitaciones más allá del límite no otorgan beneficio. |
| RN-041 | Un referido es **efectivo** cuando el invitado se registra con el código y cumple la condición configurada (por defecto: realiza el pago de su suscripción). |
| RN-042 | Los beneficios por posición de referido (1°, 2°, 3°) son **configurables** desde administración. Valores de ejemplo: 1° = exámenes ilimitados; 2° = material premium; 3° = extensión de suscripción. |
| RN-043 | El beneficio se otorga una sola vez por referido efectivo (idempotente). |
| RN-044 | Un usuario no puede referirse a sí mismo ni usar su propio código. |
| RN-045 | El código de referido es único e inmutable por alumno. |

## Evaluaciones y métricas

| ID | Regla |
|----|-------|
| RN-050 | La configuración de una evaluación (número de preguntas, tiempo, alcance, modo de feedback) se define en administración; el alumno no la altera. |
| RN-051 | En un simulador con tiempo límite, al agotarse el tiempo el intento se cierra y se califica con lo respondido. |
| RN-052 | Cada intento es independiente: la calificación de un intento no sobrescribe la de intentos previos; el historial conserva todos. |
| RN-053 | La clasificación de tema **débil/fuerte** y las áreas de oportunidad se calculan sobre el desempeño histórico del alumno (ej.: % de aciertos por tema bajo un umbral configurable). |
| RN-054 | La calificación de una pregunta es binaria (correcta/incorrecta); no hay puntuación parcial dado que es opción única. |

## Protección de contenido (expectativas realistas)

| ID | Regla |
|----|-------|
| RN-060 | El sistema **dificulta** la fuga de contenido, pero **no garantiza** su imposibilidad. Esta limitación se comunica al negocio explícitamente. |
| RN-061 | **Sí es posible:** servir medios con URLs firmadas/temporales, tokenizar el acceso por sesión, aplicar watermark dinámico con el identificador del alumno, usar DRM (ej.: Widevine) para video y aplicar `FLAG_SECURE` en Android para bloquear capturas in-app. |
| RN-062 | **No se puede garantizar técnicamente:** impedir que alguien **fotografíe la pantalla con otro dispositivo**; impedir por completo la **inspección del HTML/recursos** que llegan al navegador; evitar grabación externa de pantalla a nivel hardware. |
| RN-063 | La estrategia recomendada es **defensa en capas + disuasión**: tokenización + URLs temporales + watermark identificable (responsabiliza a quien filtra) + DRM en video + `FLAG_SECURE` en app, asumiendo que el navegador web es el entorno menos controlable. |

## Anuncios

| ID | Regla |
|----|-------|
| RN-120-01 | Un **anuncio** es un comunicado editorial que un rol autorizado publica desde el panel ([RF-120](../05-requerimientos/RF-120-anuncios.md), [RF-101](../05-requerimientos/RF-100-panel-administrativo.md)); no requiere despliegue de código. Se distingue de las notificaciones transaccionales ([RF-090](../05-requerimientos/RF-090-notificaciones.md)). |
| RN-120-02 | Un anuncio solo es visible dentro de su **ventana de vigencia** (`inicio`–`fin`); fuera de ella pasa a `expirado` automáticamente. Su **audiencia** (todos/activos/vencidos/segmento) se evalúa contra el estado de suscripción vigente del alumno. |
| RN-120-03 | Un anuncio **crítico** se muestra como modal y exige **acuse de lectura** ("Entendido"); el acuse se registra por alumno y no se vuelve a mostrar. Sus textos de marco están en [MSG-12x](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12). |

## Datos personales y auditoría

| ID | Regla |
|----|-------|
| RN-070 | Los datos personales se recaban con consentimiento (aviso de privacidad) y se usan solo para los fines declarados. |
| RN-071 | Las contraseñas nunca se almacenan ni registran en texto plano ni en logs. |
| RN-072 | Los registros de auditoría son inmutables y conservan actor, acción, fecha/hora y origen. |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/06-reglas-negocio/reglas-principales.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
