# 04 — Casos de Prueba

Casos de prueba funcionales de nivel de aceptación. Cada uno traza al requerimiento (RF) y/o regla de negocio (RN) que valida.

**Formato:** Precondición → Pasos → Resultado esperado.
**Tipo:** `Positivo` (camino feliz) / `Negativo` (error esperado) / `Borde` (límite).

---

## Registro y autenticación

### CP-001 — Registro exitoso con verificación de correo
- **Traza:** RF-010, RF-011 · **Tipo:** Positivo
- **Precondición:** El correo no está registrado.
- **Pasos:**
  1. El visitante envía correo y contraseña válidos.
  2. El sistema crea la cuenta en estado *no verificada* y envía correo de confirmación.
  3. El visitante abre el enlace de confirmación.
- **Resultado esperado:** La cuenta queda *verificada* y habilitada para iniciar sesión. Se registra evento de registro exitoso (RF-090).

### CP-002 — Registro con correo ya existente
- **Traza:** RF-010 · **Tipo:** Negativo
- **Precondición:** El correo ya está registrado.
- **Pasos:** El visitante intenta registrarse con ese correo.
- **Resultado esperado:** El sistema rechaza el registro con mensaje genérico (sin revelar si el correo existe) y no crea cuenta duplicada.

### CP-003 — Login antes de verificar el correo
- **Traza:** RF-011 · **Tipo:** Negativo
- **Precondición:** Cuenta creada pero no verificada.
- **Pasos:** El usuario intenta iniciar sesión.
- **Resultado esperado:** Acceso denegado con indicación de verificar el correo; opción de reenviar confirmación.

### CP-004 — Contraseña almacenada con hash
- **Traza:** RF-014, RN-071 · **Tipo:** Positivo
- **Precondición:** Acceso a la base de datos en entorno de prueba.
- **Pasos:** Registrar un usuario e inspeccionar el registro almacenado.
- **Resultado esperado:** La contraseña aparece como hash + salt, nunca en texto plano; tampoco aparece en logs.

### CP-005 — Recuperación de contraseña
- **Traza:** RF-012 · **Tipo:** Positivo
- **Precondición:** Cuenta verificada.
- **Pasos:** Solicitar recuperación → abrir enlace → fijar nueva contraseña.
- **Resultado esperado:** La contraseña se actualiza; el enlace expira tras su uso; se notifica el cambio (RF-090).

### CP-006 — Rate limiting en login
- **Traza:** RF-017, RNF-003 · **Tipo:** Borde
- **Pasos:** Realizar N intentos fallidos de login en ventana corta superando el umbral.
- **Resultado esperado:** El sistema bloquea/retrasa nuevos intentos según política y registra el evento.

### CP-007 — Login con MFA activado
- **Traza:** RF-016 · **Tipo:** Positivo
- **Precondición:** Usuario con MFA habilitado.
- **Pasos:** Ingresar credenciales correctas → ingresar segundo factor válido.
- **Resultado esperado:** Acceso concedido solo tras el segundo factor; con factor inválido, acceso denegado.

---

## Control de sesión única

### CP-010 — Sesión única: el nuevo login cierra el anterior
- **Traza:** RF-080, RF-081, RN-030, RN-031 · **Tipo:** Positivo
- **Precondición:** El alumno tiene sesión activa en el dispositivo A.
- **Pasos:**
  1. El alumno inicia sesión en el dispositivo B con credenciales válidas.
  2. En el dispositivo A intenta una acción autenticada.
- **Resultado esperado:** El dispositivo B queda activo; el dispositivo A es expulsado (token invalidado) y debe volver a autenticarse.

### CP-011 — Historial de acceso y notificación
- **Traza:** RF-082, RF-083, RN-033, RN-034 · **Tipo:** Positivo
- **Pasos:** El alumno inicia sesión desde un dispositivo nuevo.
- **Resultado esperado:** Se registra fecha, hora, IP, dispositivo y ubicación aproximada; se envía correo de aviso de acceso.

### CP-012 — Refresh token de sesión invalidada
- **Traza:** RF-015, RN-032 · **Tipo:** Negativo
- **Precondición:** La sesión del dispositivo A fue cerrada por un login en B.
- **Pasos:** El dispositivo A intenta renovar su access token con su refresh token.
- **Resultado esperado:** La renovación es rechazada; se exige re-autenticación.

---

## Suscripción y pagos

### CP-020 — Acceso bloqueado sin suscripción
- **Traza:** RF-020, RN-010 · **Tipo:** Negativo
- **Precondición:** Alumno verificado sin suscripción activa.
- **Pasos:** Intentar abrir una evaluación o material.
- **Resultado esperado:** Acceso denegado con invitación a suscribirse; la landing sigue accesible.

### CP-021 — Activación por pago confirmado
- **Traza:** RF-021, RF-023, RN-011, RN-020 · **Tipo:** Positivo
- **Pasos:**
  1. El alumno completa el checkout.
  2. La pasarela envía webhook de pago confirmado.
- **Resultado esperado:** La suscripción se activa con vigencia de 365 días desde la confirmación; se envía correo de pago exitoso (RF-090).

### CP-022 — Checkout sin confirmación no activa
- **Traza:** RN-016, RN-020 · **Tipo:** Negativo
- **Pasos:** El alumno inicia el checkout pero no se recibe webhook de confirmación.
- **Resultado esperado:** La suscripción permanece inactiva; el acceso sigue bloqueado.

### CP-023 — Webhook idempotente
- **Traza:** RN-021 · **Tipo:** Borde
- **Pasos:** La pasarela reenvía el mismo webhook de pago dos veces.
- **Resultado esperado:** La vigencia se otorga una sola vez; no hay doble extensión ni doble beneficio.

### CP-024 — Suspensión automática al vencer
- **Traza:** RF-025, RN-012 · **Tipo:** Positivo
- **Precondición:** Suscripción cuya fecha de expiración se alcanza.
- **Pasos:** Transcurre la fecha de expiración; el alumno intenta acceder al contenido.
- **Resultado esperado:** El estado pasa a *vencida* automáticamente y el acceso al contenido se suspende; el perfil/historial se conserva (RN-015).

### CP-025 — Renovación anticipada extiende sin perder días
- **Traza:** RF-027, RN-013 · **Tipo:** Positivo
- **Precondición:** Suscripción activa con 30 días restantes.
- **Pasos:** El alumno renueva antes del vencimiento.
- **Resultado esperado:** La nueva vigencia se suma a la fecha de expiración vigente (365 + 30 días restantes).

### CP-026 — Renovación tardía reinicia vigencia
- **Traza:** RN-014 · **Tipo:** Positivo
- **Precondición:** Suscripción vencida.
- **Pasos:** El alumno renueva tras el vencimiento.
- **Resultado esperado:** Nueva vigencia de 365 días desde la confirmación del nuevo pago.

### CP-027 — Aviso de próximo vencimiento
- **Traza:** RF-026 · **Tipo:** Positivo
- **Pasos:** La suscripción entra en la ventana de "próxima a vencer".
- **Resultado esperado:** Se envía correo de aviso de vencimiento próximo.

### CP-028 — Pago por SPEI diferido
- **Traza:** RF-022, RN-022 · **Tipo:** Borde
- **Pasos:** El alumno paga por SPEI; la acreditación llega horas después.
- **Resultado esperado:** La suscripción se activa solo al confirmarse la acreditación, no al generar la referencia.

---

## Catálogo y carga masiva

### CP-030 — Alta de materia sin desplegar código
- **Traza:** RF-030, RN-001 · **Tipo:** Positivo
- **Pasos:** El administrador crea una nueva materia desde el panel.
- **Resultado esperado:** La materia queda disponible para alumnos sin necesidad de desplegar/cambiar código.

### CP-031 — Pregunta inválida (sin respuesta correcta)
- **Traza:** RF-034, RN-003, RN-004 · **Tipo:** Negativo
- **Pasos:** Intentar publicar una pregunta sin marcar la respuesta correcta o con ≠4 opciones.
- **Resultado esperado:** El sistema rechaza la publicación e indica el campo faltante.

### CP-032 — Carga masiva por Excel con filas erróneas
- **Traza:** RF-035, RF-036 · **Tipo:** Borde
- **Precondición:** Excel con 100 filas, 5 inválidas.
- **Pasos:** Importar el archivo.
- **Resultado esperado:** Se importan las 95 válidas; se reporta el detalle de error por cada fila inválida; el lote no se aborta por completo.

### CP-033 — Borrado lógico preserva historial
- **Traza:** RN-006 · **Tipo:** Positivo
- **Precondición:** Tema con intentos históricos.
- **Pasos:** El administrador desactiva el tema.
- **Resultado esperado:** El tema deja de ofrecerse pero el historial de intentos del alumno se conserva intacto.

---

## Evaluaciones y métricas

### CP-040 — Examen por tema con retroalimentación
- **Traza:** RF-040, RF-043 · **Tipo:** Positivo
- **Precondición:** Alumno con suscripción activa.
- **Pasos:** Inicia un examen por tema y responde todas las preguntas.
- **Resultado esperado:** Al finalizar se muestra correcto/incorrecto por pregunta y la explicación; se registra el intento (RF-044).

### CP-041 — Simulador con tiempo agotado
- **Traza:** RF-042, RN-051 · **Tipo:** Borde
- **Precondición:** Simulador con tiempo límite configurado.
- **Pasos:** El alumno deja correr el tiempo sin terminar.
- **Resultado esperado:** Al agotarse el tiempo, el intento se cierra y se califica solo lo respondido.

### CP-042 — Registro completo del intento
- **Traza:** RF-044, RN-052 · **Tipo:** Positivo
- **Pasos:** Completar un intento.
- **Resultado esperado:** Se guarda calificación, fecha, tiempo invertido, materia, módulo, tema y sección; intentos previos no se sobrescriben.

### CP-043 — Dashboard de fortalezas y debilidades
- **Traza:** RF-050, RF-051, RN-053 · **Tipo:** Positivo
- **Precondición:** Alumno con historial en varios temas.
- **Pasos:** Abrir el dashboard.
- **Resultado esperado:** Se muestra avance general y por materia, y se clasifican temas débiles/fuertes según el desempeño histórico.

### CP-044 — Recomendaciones automáticas
- **Traza:** RF-052 · **Tipo:** Positivo
- **Pasos:** Tras varios intentos con bajo desempeño en un tema, abrir el dashboard.
- **Resultado esperado:** El sistema recomienda repasar el/los temas débiles detectados.

---

## Material de apoyo y protección de contenido

### CP-050 — Material visible sin descarga
- **Traza:** RF-060, RF-061 · **Tipo:** Positivo
- **Pasos:** Abrir el material de apoyo (PDF/imagen/video) de una pregunta.
- **Resultado esperado:** El material se visualiza dentro de la plataforma; no se ofrece opción de descarga directa.

### CP-051 — URL de medio expira
- **Traza:** RF-062, RF-110, RN-061 · **Tipo:** Negativo
- **Pasos:** Copiar la URL firmada de un video y abrirla pasado su tiempo de expiración (o sin sesión).
- **Resultado esperado:** El acceso es rechazado; la URL ya no sirve.

### CP-052 — Watermark dinámico con identificador
- **Traza:** RF-111, RN-061 · **Tipo:** Positivo
- **Pasos:** Reproducir contenido premium.
- **Resultado esperado:** El contenido muestra una marca de agua con el identificador del alumno.

### CP-053 — FLAG_SECURE en Android
- **Traza:** RF-112, RN-061 · **Tipo:** Positivo
- **Precondición:** App Android en vista de contenido.
- **Pasos:** Intentar tomar captura de pantalla.
- **Resultado esperado:** La captura/grabación in-app se bloquea o sale en negro. *(Nota: no impide fotografiar con otro dispositivo — RN-062.)*

---

## Referidos

### CP-060 — Referido efectivo otorga beneficio
- **Traza:** RF-071, RF-073, RN-041, RN-043 · **Tipo:** Positivo
- **Precondición:** Alumno A con código activo y 0 referidos.
- **Pasos:** El visitante B se registra con el código de A y paga su suscripción.
- **Resultado esperado:** B se contabiliza como referido efectivo 1 de A y A recibe el beneficio configurado para la posición 1.

### CP-061 — Límite de 3 referidos
- **Traza:** RF-071, RN-040 · **Tipo:** Borde
- **Precondición:** Alumno A con 3 referidos efectivos.
- **Pasos:** Un 4° invitado se registra con el código de A y paga.
- **Resultado esperado:** No se otorga beneficio adicional a A por encima del límite.

### CP-062 — Auto-referido bloqueado
- **Traza:** RN-044 · **Tipo:** Negativo
- **Pasos:** El alumno intenta usar su propio código de referido.
- **Resultado esperado:** El sistema rechaza el auto-referido.

### CP-063 — Beneficio idempotente
- **Traza:** RN-043 · **Tipo:** Borde
- **Pasos:** Reprocesar la confirmación de pago de un referido ya contabilizado.
- **Resultado esperado:** El beneficio no se duplica.

---

## Notificaciones

### CP-070 — Correos transaccionales
- **Traza:** RF-090 · **Tipo:** Positivo
- **Pasos:** Ejecutar registro, login, cambio de contraseña y pago exitoso.
- **Resultado esperado:** Se envía el correo correspondiente a cada evento.

### CP-071 — Reporte semanal de avance
- **Traza:** RF-091 · **Tipo:** Positivo
- **Precondición:** Alumno activo con actividad en la semana.
- **Pasos:** Llega el día programado del envío semanal.
- **Resultado esperado:** El alumno recibe un correo con avance, estadísticas y recomendaciones.

---

## Panel administrativo y seguridad

### CP-080 — Permisos por rol
- **Traza:** RF-101 · **Tipo:** Negativo
- **Precondición:** Usuario con rol *editor de contenido*.
- **Pasos:** Intentar acceder a la sección de pagos/usuarios.
- **Resultado esperado:** Acceso denegado; el editor solo opera el catálogo.

### CP-081 — Auditoría de acción sensible
- **Traza:** RNF-004, RN-072 · **Tipo:** Positivo
- **Pasos:** Un administrador modifica una suscripción.
- **Resultado esperado:** Se registra un evento de auditoría inmutable con actor, acción, fecha/hora y origen.

### CP-082 — Comunicación cifrada
- **Traza:** RNF-001 · **Tipo:** Positivo
- **Pasos:** Inspeccionar el tráfico cliente–servidor.
- **Resultado esperado:** Todo el tráfico viaja sobre TLS/HTTPS.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/10-casos-prueba/00-catalogo-casos-prueba.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
