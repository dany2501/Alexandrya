# 14 — Catálogo de Mensajes del Sistema

Fuente **única de verdad** de todos los mensajes que la plataforma muestra al usuario (errores, avisos, confirmaciones, bloqueos y vacíos). Centraliza el **microcopy** para que un mismo evento tenga **siempre el mismo texto** en web y app, y para que diseño, frontend, backend y QA partan del mismo lugar.

> **Por qué existe este archivo:** los textos estaban dispersos en estados de pantalla ([11](../11-ux-estados-pantalla/estados-pantalla-iniciales.md)), respuestas de API (sección 12 de cada RF) y reglas ([06](../06-reglas-negocio/reglas-principales.md)). Aquí se concentran y se cruzan con su **regla** (`RN/RNA`), **validación** (`V`), **pantalla** (`EP`), **notificación** (`NT/CT`) y **código** (HTTP / clave interna). Cualquier cambio de texto se hace **aquí primero**.

---

## 0. Cómo usar este catálogo

- **ID:** `MSG-###`. La centena indica el módulo (`MSG-02x` → MOD-02 Identidad y acceso).
- **Tipo:** ❌ Error · ⚠️ Advertencia · ⛔ Bloqueo · ℹ️ Info · ✅ Éxito · 🕳️ Vacío.
- **Texto al usuario:** copy final en **español (México)**. Las `{{variables}}` siguen las [variables de plantilla](../12-notificaciones/notificaciones.md#3-variables-comunes-de-plantilla).
- **Código:** HTTP y/o clave interna que devuelve la API (la misma que ya aparece en la sección 12 de cada RF).
- **Trazabilidad:** regla, validación, pantalla y notificación relacionadas.
- **Regla de oro de seguridad:** los mensajes **nunca** revelan si un correo existe, ni filtran detalles internos (anti-enumeración, [RNA-001](../06-reglas-negocio/reglas-alternas.md) · [RN-001B-01](../05-requerimientos/RF-001B-recuperacion-contrasena.md)).

| Convención | Detalle |
|------------|---------|
| Persona | Tuteo, cercano y claro. Sin tecnicismos ni códigos de error crudos al usuario. |
| Longitud | Título ≤ 60 caracteres; cuerpo ≤ 160. |
| Tono de error | Explica **qué pasó** y **qué hacer**, sin culpar al usuario. |
| Accesibilidad | Todo mensaje crítico tiene texto (no solo color/ícono) — [RNF-033](../05-requerimientos/00-catalogo-requerimientos.md). |
| i18n | Español MX hoy; las claves `MSG-###` son estables para futura localización ([RNF-040](../05-requerimientos/00-catalogo-requerimientos.md)). |

---

## MSG-01x · Landing y contacto (MOD-01)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-010 | ✅ | Formulario de contacto enviado | "Gracias, recibimos tu mensaje. Te contactaremos pronto." | 200 | [EP-003](../11-ux-estados-pantalla/estados-pantalla-iniciales.md) · NT-011 |
| MSG-011 | ❌ | Falla al enviar contacto | "No pudimos enviar tu mensaje. Inténtalo de nuevo en un momento." | 500 | [EP-003](../11-ux-estados-pantalla/estados-pantalla-iniciales.md) |
| MSG-012 | ❌ | Captcha/anti-bot falla | "No pudimos verificar que eres una persona. Vuelve a intentarlo." | 400 | [RNF-003](../05-requerimientos/00-catalogo-requerimientos.md) |

---

## MSG-02x · Identidad y acceso (MOD-02)

> Núcleo de lo solicitado: login fallido, bloqueo por intentos, sesión concurrente y auto-cierre por inactividad.

### Login y credenciales

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-020 | ❌ | Credenciales inválidas | "Correo o contraseña incorrectos. Verifica tus datos." (mensaje **genérico**, no dice cuál falló) | 401 `credenciales_invalidas` | [RNA-001](../06-reglas-negocio/reglas-alternas.md) · [EP-011](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-011--login) · [FA-001](../07-casos-uso/flujos-alternos.md) |
| MSG-021 | ⚠️ | Quedan intentos antes del bloqueo | "Datos incorrectos. Te quedan {{intentos_restantes}} intentos antes de bloquear el acceso temporalmente." | 401 | [RNA-003](../06-reglas-negocio/reglas-alternas.md) · [EP-011](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-011--login) |
| MSG-022 | ⛔ | Más de 5 intentos fallidos en 15 min | "Por seguridad bloqueamos el acceso temporalmente. Vuelve a intentar en {{minutos_restantes}} min." | 429 `rate_limited` | [RNA-003](../06-reglas-negocio/reglas-alternas.md) · [EP-013](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-013--bloqueo-por-intentos-rate-limit) · [FA-003](../07-casos-uso/flujos-alternos.md) |
| MSG-023 | ❌ | Login con cuenta no verificada | "Confirma tu correo para entrar. ¿No te llegó? Reenviar verificación." | 403 `cuenta_no_verificada` | [RNA-002](../06-reglas-negocio/reglas-alternas.md) · [EP-012](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-012--verificación-de-correo-enviada) |
| MSG-024 | ❌ | MFA: segundo factor inválido | "El código de verificación no es válido o expiró. Solicita uno nuevo." | 401 `mfa_invalido` | [RNA-006](../06-reglas-negocio/reglas-alternas.md) · [RF-016](../05-requerimientos/RF-016-mfa.md) |
| MSG-025 | ✅ | Login correcto | "¡Hola de nuevo, {{nombre}}!" | 200 | [EP-011](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-011--login) · NT-002 |

### Sesión única y concurrencia

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-026 | ⚠️ | El dispositivo fue expulsado por un login nuevo | "Tu sesión se cerró porque iniciaste sesión en otro dispositivo." | 401 `sesion_invalida` | [RN-030/031](../06-reglas-negocio/reglas-principales.md#control-de-sesiones) · [RF-080](../05-requerimientos/RF-080-sesion-unica.md) · [FA-004](../07-casos-uso/flujos-alternos.md) |
| MSG-027 | ℹ️ | Aviso al iniciar cuando ya hay sesión activa | "Al continuar cerraremos tu sesión en el otro dispositivo. Solo se permite una sesión a la vez." | — | [RN-030](../06-reglas-negocio/reglas-principales.md#control-de-sesiones) · [RF-080](../05-requerimientos/RF-080-sesion-unica.md) |
| MSG-028 | ❌ | Refresh token de sesión ya expulsada | "Tu sesión expiró. Inicia sesión de nuevo." | 401 `sesion_invalida` | [RNA-005](../06-reglas-negocio/reglas-alternas.md) · [RF-080](../05-requerimientos/RF-080-sesion-unica.md) |

### Auto-cierre por inactividad

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-029 | ⚠️ | 9 min de inactividad (aviso 1 min antes de cerrar) | "Por tu seguridad cerraremos la sesión en 60 s por inactividad. ¿Sigues ahí? [Seguir conectado]" | — | [RN-035](../06-reglas-negocio/reglas-principales.md#control-de-sesiones) · [EP-015](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-015--aviso-de-inactividad) |
| MSG-02A | ℹ️ | Sesión cerrada tras 10 min de inactividad | "Cerramos tu sesión por inactividad. Inicia sesión para continuar." | 401 `sesion_inactividad` | [RN-035](../06-reglas-negocio/reglas-principales.md#control-de-sesiones) · [RNA-007](../06-reglas-negocio/reglas-alternas.md) · [EP-015](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-015--aviso-de-inactividad) |

### Registro, verificación y contraseña

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-02B | ❌ | Registro con correo ya existente | "No pudimos completar el registro con esos datos." (genérico, anti-enumeración) | 409 | [RNA-001](../06-reglas-negocio/reglas-alternas.md) · [EP-010](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-010--registro) |
| MSG-02C | ❌ | Contraseña no cumple política | "Tu contraseña debe tener mínimo 8 caracteres, una mayúscula, una minúscula y un número." | 422 `politica_contrasena` | [V-001B-04](../05-requerimientos/RF-001B-recuperacion-contrasena.md#7--validaciones) |
| MSG-02D | ✅ | Verificación enviada | "Te enviamos un enlace a {{correo}}. Revísalo para activar tu cuenta." | 200 | [EP-012](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-012--verificación-de-correo-enviada) · NT-001 |
| MSG-02E | ℹ️ | Solicitud de recuperación (siempre igual) | "Si el correo existe, te enviamos instrucciones para restablecer tu contraseña." | 200 (siempre) | [RN-001B-01](../05-requerimientos/RF-001B-recuperacion-contrasena.md#8--reglas-de-negocio) · [EP-014](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-014--recuperar--cambiar-contraseña) · NT-004 |
| MSG-02F | ❌ | Enlace de reset caducado/usado | "Este enlace ya no es válido. Solicita uno nuevo." | 410 `token_expirado` | [RN-001B-02](../05-requerimientos/RF-001B-recuperacion-contrasena.md#8--reglas-de-negocio) |
| MSG-02G | ✅ | Contraseña restablecida/cambiada | "Listo, tu contraseña se actualizó. Vuelve a iniciar sesión." | 200 | [RN-001B-03](../05-requerimientos/RF-001B-recuperacion-contrasena.md#8--reglas-de-negocio) · NT-003 |
| MSG-02H | ❌ | Cambio: contraseña actual incorrecta | "La contraseña actual no es correcta." | 401 `contrasena_actual_invalida` | [V-001B-05](../05-requerimientos/RF-001B-recuperacion-contrasena.md#7--validaciones) |

---

## MSG-03x · Suscripción y pagos (MOD-03)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-030 | ✅ | Pago confirmado | "¡Pago confirmado! Tu suscripción está activa hasta {{fin_vigencia}}." | 200 | [RN-011](../06-reglas-negocio/reglas-principales.md#suscripción-y-acceso) · [EP-021](../11-ux-estados-pantalla/estados-pantalla-iniciales.md) · NT-005 |
| MSG-031 | ❌ | Pago rechazado | "Tu pago no se completó. Revisa tu método de pago e inténtalo de nuevo." | 402 `pago_rechazado` | [RNA-010](../06-reglas-negocio/reglas-alternas.md) · NT-012 |
| MSG-032 | ⚠️ | SPEI pendiente de acreditar | "Tu transferencia está en proceso. Activaremos tu acceso al confirmarse el pago." | 200 | [RNA-012](../06-reglas-negocio/reglas-alternas.md) |
| MSG-033 | ⛔ | Acceso a contenido sin suscripción activa | "Necesitas una suscripción activa para ver este contenido. [Suscribirme]" | 403 `suscripcion_requerida` | [RN-010](../06-reglas-negocio/reglas-principales.md#suscripción-y-acceso) · [EP-022](../11-ux-estados-pantalla/estados-pantalla-iniciales.md) |
| MSG-034 | ⚠️ | Suscripción próxima a vencer | "Tu suscripción vence en {{dias_restantes}} días. Renueva para no perder tu acceso." | — | [RN-013](../06-reglas-negocio/reglas-principales.md#suscripción-y-acceso) · NT-006 |
| MSG-035 | ℹ️ | Suscripción vencida | "Tu suscripción venció. Renueva para continuar; tu perfil y avance se conservan." | 403 | [RN-012/015](../06-reglas-negocio/reglas-principales.md#suscripción-y-acceso) · NT-007 |

---

## MSG-04x · Catálogo y carga masiva (MOD-04, admin)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-040 | ❌ | Pregunta inválida al publicar | "No se puede publicar: falta {{campo}}. Una pregunta necesita enunciado, 4 opciones y la respuesta correcta." | 422 | [RNA-020](../06-reglas-negocio/reglas-alternas.md) · [RN-004](../06-reglas-negocio/reglas-principales.md) |
| MSG-041 | ⚠️ | Carga Excel con filas erróneas | "Importamos {{ok}} filas. {{error}} tuvieron errores; revisa el reporte por fila." | 207 | [RNA-021](../06-reglas-negocio/reglas-alternas.md) · [RF-035](../05-requerimientos/RF-035-carga-masiva-excel.md) |
| MSG-042 | ❌ | Excel ilegible / columnas faltantes | "No pudimos leer el archivo. Descarga la plantilla y verifica las columnas." | 422 | [RNA-022](../06-reglas-negocio/reglas-alternas.md) |
| MSG-043 | ℹ️ | Intento de borrar contenido con historial | "Este elemento tiene intentos asociados; se desactivará en lugar de eliminarse." | 200 | [RN-006](../06-reglas-negocio/reglas-principales.md) · [RNA-023](../06-reglas-negocio/reglas-alternas.md) |

---

## MSG-05x · Evaluaciones (MOD-05)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-050 | ⚠️ | Tiempo agotado en simulador | "Se acabó el tiempo. Calificamos lo que respondiste." | 200 | [RN-051](../06-reglas-negocio/reglas-principales.md) · [RNA-030](../06-reglas-negocio/reglas-alternas.md) |
| MSG-051 | 🕳️ | Tema sin preguntas suficientes | "Este tema aún no tiene preguntas disponibles." | 200 | [RNA-032](../06-reglas-negocio/reglas-alternas.md) · [EP-041](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-041--reactivo-en-curso) |
| MSG-052 | ⚠️ | Conexión perdida a mitad del examen | "Perdimos la conexión. Guardamos tu avance; puedes reanudar." | — | [RNA-031](../06-reglas-negocio/reglas-alternas.md) |
| MSG-053 | ℹ️ | Doble envío del intento | "Este intento ya se registró." | 200 (idempotente) | [RNA-033](../06-reglas-negocio/reglas-alternas.md) · [RN-052](../06-reglas-negocio/reglas-principales.md) |

---

## MSG-06x · Progreso y métricas (MOD-06)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-060 | 🕳️ | Dashboard sin intentos | "Aún no tienes intentos. Haz tu primera evaluación para ver tu avance." | 200 | [EP-050](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-050--dashboard) |

---

## MSG-07x · Material y protección de contenido (MOD-07)

> Estos mensajes acompañan a los **disuasores client-side** ([RN-110-10](../05-requerimientos/RF-110-proteccion-contenido.md)). Importante: el sistema **disuade**, no garantiza imposibilidad ([RN-062](../06-reglas-negocio/reglas-principales.md#protección-de-contenido-expectativas-realistas)).

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-070 | ⛔ | URL de medio caducada / sin token | "Este contenido expiró. Vuelve a abrirlo desde tu sesión." | 403 | [RNA-050/051](../06-reglas-negocio/reglas-alternas.md) · [RN-110-01](../05-requerimientos/RF-110-proteccion-contenido.md) |
| MSG-071 | ⚠️ | Intento de menú contextual / clic derecho sobre contenido | "Este contenido está protegido. La copia y descarga no están permitidas." | — | [RN-110-10](../05-requerimientos/RF-110-proteccion-contenido.md) · [RN-061](../06-reglas-negocio/reglas-principales.md#protección-de-contenido-expectativas-realistas) |
| MSG-072 | ⚠️ | Intento de descarga/guardar imagen | "El material no se puede descargar; está disponible solo dentro de la plataforma." | — | [RF-061](../05-requerimientos/00-catalogo-requerimientos.md) · [RN-110-10](../05-requerimientos/RF-110-proteccion-contenido.md) |
| MSG-073 | ⚠️ | Captura bloqueada en Android (FLAG_SECURE) | "Las capturas de pantalla están deshabilitadas en esta sección." | — | [RN-110-05](../05-requerimientos/RF-110-proteccion-contenido.md) · [RF-112](../05-requerimientos/00-catalogo-requerimientos.md) |
| MSG-074 | ⛔ | Patrón de scraping detectado | "Detectamos actividad inusual. Pausamos el acceso temporalmente por seguridad." | 429 | [RNA-053](../06-reglas-negocio/reglas-alternas.md) · [V-110-06](../05-requerimientos/RF-110-proteccion-contenido.md#7--validaciones) |

---

## MSG-08x · Referidos (MOD-08)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-080 | ✅ | Beneficio de referido otorgado | "¡Tu referido se activó! Obtuviste: {{beneficio}}." | 200 | [RN-042](../06-reglas-negocio/reglas-principales.md#referidos) · NT-010 |
| MSG-081 | ⚠️ | Límite de 3 referidos alcanzado | "Ya alcanzaste tus 3 referidos. ¡Gracias por compartir!" | — | [RN-040](../06-reglas-negocio/reglas-principales.md#referidos) · [RNA-041](../06-reglas-negocio/reglas-alternas.md) |
| MSG-082 | ❌ | Auto-referido | "No puedes usar tu propio código de referido." | 400 | [RN-044](../06-reglas-negocio/reglas-principales.md#referidos) · [RNA-040](../06-reglas-negocio/reglas-alternas.md) |
| MSG-083 | ℹ️ | Código de referido inválido/expirado | "Ese código no es válido; continuamos con tu registro sin referido." | 200 | [RNA-042](../06-reglas-negocio/reglas-alternas.md) |

---

## MSG-10x · Panel administrativo (MOD-10)

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-100 | ❌ | Acción sin permiso de rol | "No tienes permisos para realizar esta acción." | 403 `sin_permiso` | [RF-101](../05-requerimientos/RF-100-panel-administrativo.md) |
| MSG-101 | ✅ | Guardado correcto en admin | "Cambios guardados." | 200 | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) |

---

## MSG-11x · Globales y seguridad (MOD-11)

> Mensajes transversales que cualquier módulo puede reutilizar. Evitan inventar copys ad-hoc.

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-110 | ❌ | Error inesperado del servidor | "Algo salió mal de nuestro lado. Inténtalo de nuevo en unos minutos." | 500 `error_interno` | [RNF-022](../05-requerimientos/00-catalogo-requerimientos.md) |
| MSG-111 | ❌ | Sin conexión / red caída | "Sin conexión. Revisa tu internet e inténtalo de nuevo." | — | — |
| MSG-112 | ⛔ | Demasiadas solicitudes (rate limit genérico) | "Vas muy rápido. Espera un momento e inténtalo de nuevo." | 429 `rate_limited` | [RNF-003](../05-requerimientos/00-catalogo-requerimientos.md) |
| MSG-113 | ❌ | Recurso no encontrado | "No encontramos lo que buscas." | 404 `no_encontrado` | — |
| MSG-114 | ❌ | Sesión expirada (genérico) | "Tu sesión expiró. Inicia sesión de nuevo." | 401 | [RF-080](../05-requerimientos/RF-080-sesion-unica.md) |
| MSG-115 | ⚠️ | Mantenimiento programado | "Estamos en mantenimiento. Volvemos muy pronto." | 503 | [RNF-010](../05-requerimientos/00-catalogo-requerimientos.md) |

---

## MSG-12x · Anuncios (MOD-12)

> Mensajes del módulo de [Anuncios](../05-requerimientos/RF-120-anuncios.md): comunicados que el equipo publica y se muestran al alumno (banner, modal o centro de anuncios).

| ID | Tipo | Disparador | Texto al usuario | Código | Traza |
|----|:----:|------------|------------------|--------|-------|
| MSG-120 | ℹ️ | Anuncio activo visible | (Contenido dinámico) `{{titulo_anuncio}}` — `{{cuerpo_anuncio}}` · `[{{cta_anuncio}}]` | — | [RF-120](../05-requerimientos/RF-120-anuncios.md) · [EP-100](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-100--anuncios) |
| MSG-121 | 🕳️ | Centro de anuncios sin novedades | "No tienes anuncios por ahora." | 200 | [RF-120](../05-requerimientos/RF-120-anuncios.md) · [EP-100](../11-ux-estados-pantalla/estados-pantalla-iniciales.md#ep-100--anuncios) |
| MSG-122 | ✅ | Anuncio publicado (admin) | "Anuncio publicado. Visible para {{audiencia}} desde {{fecha}}." | 200 | [RF-120](../05-requerimientos/RF-120-anuncios.md) · [RN-120-01](../06-reglas-negocio/reglas-principales.md#anuncios) |
| MSG-123 | ℹ️ | Anuncio crítico tipo modal | "{{titulo_anuncio}}" + cuerpo + `[Entendido]` (requiere acuse) | — | [RN-120-03](../06-reglas-negocio/reglas-principales.md#anuncios) |

---

## Trazabilidad inversa (evento → mensaje)

Atajo para encontrar el mensaje correcto desde un evento o desde una regla.

| Evento / Regla | Mensaje(s) |
|----------------|-----------|
| No puede hacer login (credenciales) | MSG-020, MSG-021 |
| Bloqueo tras varios intentos | MSG-022 ([RNA-003](../06-reglas-negocio/reglas-alternas.md)) |
| Alguien más entra mientras hay sesión abierta | MSG-026, MSG-027 ([RF-080](../05-requerimientos/RF-080-sesion-unica.md)) |
| Cierre automático por inactividad (10 min) | MSG-029, MSG-02A ([RN-035](../06-reglas-negocio/reglas-principales.md#control-de-sesiones)) |
| Bloquear foto / inspección / descarga en navegador | MSG-071, MSG-072, MSG-073 ([RN-110-10](../05-requerimientos/RF-110-proteccion-contenido.md), límites en [RN-062](../06-reglas-negocio/reglas-principales.md#protección-de-contenido-expectativas-realistas)) |
| Plantillas de correo (mensajes asíncronos) | [Sección 12 · plantillas-correo](../12-notificaciones/plantillas-correo/) |
| Anuncios y comunicados | MSG-120..123 ([RF-120](../05-requerimientos/RF-120-anuncios.md)) |

> **Nota sobre el bloqueo de navegador:** los mensajes MSG-071/072/073 acompañan medidas de **disuasión** client-side. El catálogo es honesto con el alcance: tomar una foto con otro dispositivo o inspeccionar el HTML recibido **no se puede impedir al 100%** ([RN-110-06/07](../05-requerimientos/RF-110-proteccion-contenido.md)). El watermark identifica la fuente de una filtración.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/14-mensajes-sistema/mensajes-sistema.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 Mensajes del sistema (este documento)</sub>
