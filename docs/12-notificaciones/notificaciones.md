# 12 — Notificaciones

Matriz de notificaciones del sistema (`NT-###`). Define disparador, canal, destinatario, prioridad y la plantilla de correo asociada (`CT-###`). Todas las notificaciones por correo se envían de forma **asíncrona** vía RabbitMQ → servicio de correo.

> Canales del MVP: **Correo**. Push (Android) y SMS son fases posteriores.
>
> **Notificación ≠ Anuncio.** Las `NT-###` son **transaccionales** (las dispara un evento del sistema). Los **anuncios** editoriales in-app (banner/modal/centro) viven en [RF-120 Anuncios](../05-requerimientos/RF-120-anuncios.md) y sus textos de marco en [MSG-12x](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12); NT-013 es solo su difusión opcional por correo.

---

## 1. Matriz de notificaciones

| ID | Evento disparador | Canal | Destinatario | Prioridad | Plantilla | RF |
|----|-------------------|-------|--------------|-----------|-----------|----|
| NT-001 | Registro exitoso (verificar correo) | Correo | Alumno | Alta | [CT-001](plantillas-correo/CT-001-verificacion-correo.md) | RF-011 |
| NT-002 | Nuevo inicio de sesión | Correo | Alumno | Media | [CT-002](plantillas-correo/CT-002-aviso-acceso.md) | RF-083 |
| NT-003 | Cambio de contraseña | Correo | Alumno | Alta | CT-003 (🔜) | RF-013 |
| NT-004 | Recuperación de contraseña | Correo | Alumno | Alta | CT-004 | RF-012 |
| NT-005 | Pago exitoso | Correo | Alumno | Alta | [CT-005](plantillas-correo/CT-005-pago-exitoso.md) | RF-090 |
| NT-006 | Suscripción próxima a vencer | Correo | Alumno | Alta | [CT-006](plantillas-correo/CT-006-por-vencer.md) | RF-026 |
| NT-007 | Suscripción vencida | Correo | Alumno | Alta | CT-007 | RF-026 |
| NT-008 | Renovación exitosa | Correo | Alumno | Media | CT-008 | RF-027 |
| NT-009 | Reporte semanal de avance | Correo | Alumno | Baja | [CT-009](plantillas-correo/CT-009-reporte-semanal.md) | RF-091 |
| NT-010 | Beneficio de referido otorgado | Correo | Alumno (refiere) | Media | CT-010 | RF-073 |
| NT-011 | Formulario de contacto recibido | Correo | Soporte/Admin | Media | CT-011 | RF-005 |
| NT-012 | Pago rechazado | Correo | Alumno | Media | CT-012 | RNA-010 |
| NT-013 | Anuncio con difusión por correo (opcional) | Correo | Alumno (audiencia) | Baja | CT-013 | [RF-120](../05-requerimientos/RF-120-anuncios.md) |

---

## 2. Reglas de notificación

| # | Regla |
|---|-------|
| 1 | Las notificaciones se encolan; un fallo de envío reintenta con backoff y se registra. |
| 2 | Nunca se incluyen contraseñas ni tokens completos en el cuerpo del correo ([RN-071](../06-reglas-negocio/reglas-principales.md)). |
| 3 | Los enlaces de acción (verificar, reset) usan tokens de un solo uso y expiración corta. |
| 4 | Toda notificación incluye pie con identidad de Alexandrya y enlace a soporte/baja según corresponda. |
| 5 | El reporte semanal solo se envía a alumnos con suscripción activa y con actividad. |
| 6 | El aviso de "próxima a vencer" se dispara en ventana configurable (ej.: 15 y 3 días antes). |

---

## 3. Variables comunes de plantilla

| Variable | Descripción |
|----------|-------------|
| `{{nombre}}` | Nombre del alumno |
| `{{correo}}` | Correo del alumno |
| `{{enlace_accion}}` | URL con token (verificación/reset) |
| `{{fecha}}` / `{{hora}}` | Marca temporal del evento |
| `{{ip}}` / `{{dispositivo}}` / `{{ubicacion}}` | Datos del acceso (NT-002) |
| `{{fin_vigencia}}` / `{{dias_restantes}}` | Estado de suscripción |
| `{{monto}}` / `{{metodo}}` / `{{folio}}` | Datos del pago |
| `{{avance_general}}` / `{{temas_debiles}}` / `{{recomendaciones}}` | Reporte semanal |
| `{{beneficio}}` / `{{posicion_referido}}` | Beneficio de referido |

> Las plantillas concretas están en [`plantillas-correo/`](plantillas-correo/). Se incluyen ejemplos completos de CT-001, CT-002, CT-005, CT-006 y CT-009; el resto sigue la misma estructura.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/12-notificaciones/notificaciones.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
