# 16 — Catálogo de Endpoints (`API-###`)

Inventario de **todos los endpoints** de la API REST de Alexandrya, extraídos de la sección 12 de cada `RF-###` y cruzados con su **módulo**, **regla**, **tablas de BD** y **mensajes** de respuesta.

> **Base URL:** `/api/v1` · **Auth:** `Authorization: Bearer <access_token>` salvo los marcados *público* · **Convenciones:** [08 §2](../08-especificaciones-tecnicas/00-indice-especificaciones.md#2-convenciones-de-api) · **Códigos de error y textos:** [14 Mensajes](../14-mensajes-sistema/mensajes-sistema.md) · **Tablas:** [15 Base de datos](../15-base-datos/00-indice-base-datos.md).

Numeración: la centena de `API-###` indica el módulo (`API-02x` → MOD-02), igual que `MSG-###`.

---

## API-01x · Landing y legal (MOD-01)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / notas |
|----|---------------|------|----|-----------|------------------|
| API-010 | `GET /planes` | público | [RF-002](../05-requerimientos/RF-002-planes-compra.md) | `planes` | — |
| API-011 | `GET /legal/{tipo}` | público | [RF-003](../05-requerimientos/RF-003-paginas-legales.md) | `documentos_legales` | vigente por tipo |
| API-012 | `GET /legal/{tipo}/versiones` | público | [RF-003](../05-requerimientos/RF-003-paginas-legales.md) | `documentos_legales` | histórico |
| API-013 | `POST /admin/legal` | admin | [RF-003](../05-requerimientos/RF-003-paginas-legales.md) | `documentos_legales` | [MSG-100](../14-mensajes-sistema/mensajes-sistema.md#msg-10x--panel-administrativo-mod-10) |
| API-014 | `PUT /admin/legal/{id}/publicar` | admin | [RF-003](../05-requerimientos/RF-003-paginas-legales.md) | `documentos_legales` | un solo vigente |
| API-015 | `POST /contacto` *(propuesto)* | público | [RF-004/005](../05-requerimientos/00-catalogo-requerimientos.md) | — | dispara NT-011 · [MSG-010/011/012](../14-mensajes-sistema/mensajes-sistema.md#msg-01x--landing-y-contacto-mod-01) |

---

## API-02x · Identidad y acceso (MOD-02)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-020 | `POST /auth/register` | público | [RF-001](../05-requerimientos/RF-001-registro.md) | `usuarios`, `tokens_verificacion` | [MSG-02B/02C/02D](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) · [RNA-001](../06-reglas-negocio/reglas-alternas.md) |
| API-021 | `POST /auth/verify` | público | [RF-001](../05-requerimientos/RF-001-registro.md) | `usuarios`, `tokens_verificacion` | [RNA-004](../06-reglas-negocio/reglas-alternas.md) |
| API-022 | `POST /auth/verify/resend` | público | [RF-001](../05-requerimientos/RF-001-registro.md) | `tokens_verificacion` | [MSG-023](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) |
| API-023 | `POST /auth/login` | público | [RF-001A](../05-requerimientos/RF-001A-autenticacion.md) | `usuarios`, `sesiones`, `audit_accesos` | [MSG-020..026](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) · [RNA-002/003](../06-reglas-negocio/reglas-alternas.md) |
| API-024 | `POST /auth/refresh` | refresh | [RF-001A](../05-requerimientos/RF-001A-autenticacion.md) · [RF-080](../05-requerimientos/RF-080-sesion-unica.md) | `sesiones` | [MSG-028](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) · [RNA-005](../06-reglas-negocio/reglas-alternas.md) |
| API-025 | `POST /auth/logout` | auth | [RF-001A](../05-requerimientos/RF-001A-autenticacion.md) | `sesiones` | — |
| API-026 | `GET /auth/session` | auth | [RF-080](../05-requerimientos/RF-080-sesion-unica.md) | `sesiones` | dispositivo activo |
| API-027 | `GET /auth/validate` | auth | [RF-001A](../05-requerimientos/RF-001A-autenticacion.md) · [RF-080](../05-requerimientos/RF-080-sesion-unica.md) | `sesiones` | [MSG-026/02A/114](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) · [RN-035](../06-reglas-negocio/reglas-principales.md#control-de-sesiones) |
| API-028 | `POST /auth/password/forgot` | público | [RF-001B](../05-requerimientos/RF-001B-recuperacion-contrasena.md) | `tokens_reset` | [MSG-02E](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) · [RN-001B-01](../05-requerimientos/RF-001B-recuperacion-contrasena.md) |
| API-029 | `POST /auth/password/reset` | público | [RF-001B](../05-requerimientos/RF-001B-recuperacion-contrasena.md) | `usuarios`, `tokens_reset`, `sesiones` | [MSG-02F/02G/02C](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) |
| API-02A | `POST /auth/password/change` | auth | [RF-001B](../05-requerimientos/RF-001B-recuperacion-contrasena.md) | `usuarios`, `sesiones` | [MSG-02G/02H/02C](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) |
| API-02B | `POST /auth/mfa/setup` | auth | [RF-016](../05-requerimientos/RF-016-mfa.md) | `mfa_secretos` | — |
| API-02C | `POST /auth/mfa/activate` | auth | [RF-016](../05-requerimientos/RF-016-mfa.md) | `mfa_secretos`, `usuarios` | [MSG-024](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02) |
| API-02D | `POST /auth/mfa/disable` | auth | [RF-016](../05-requerimientos/RF-016-mfa.md) | `mfa_secretos`, `usuarios` | — |

---

## API-03x · Suscripción y pagos (MOD-03)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-030 | `POST /checkout` | auth | [RF-020](../05-requerimientos/RF-020-contratacion-suscripcion.md) | `pagos`, `suscripciones`, `planes` | [MSG-031/032/033](../14-mensajes-sistema/mensajes-sistema.md#msg-03x--suscripción-y-pagos-mod-03) |
| API-031 | `POST /webhooks/payment` | firma webhook | [RF-023](../05-requerimientos/RF-023-webhook-pago.md) | `eventos_pago`, `pagos`, `suscripciones` | [MSG-030](../14-mensajes-sistema/mensajes-sistema.md#msg-03x--suscripción-y-pagos-mod-03) · [RN-020..023](../06-reglas-negocio/reglas-principales.md#pagos) · ADR-006 |
| API-032 | `GET /subscription` | auth | [RF-024](../05-requerimientos/RF-024-renovacion.md) | `suscripciones` | [MSG-034/035](../14-mensajes-sistema/mensajes-sistema.md#msg-03x--suscripción-y-pagos-mod-03) |
| API-033 | `POST /subscription/renew` | auth | [RF-024](../05-requerimientos/RF-024-renovacion.md) | `suscripciones`, `pagos` | [RN-013/014](../06-reglas-negocio/reglas-principales.md#suscripción-y-acceso) |
| API-034 | `POST /subscription/auto-renew` | auth | [RF-024](../05-requerimientos/RF-024-renovacion.md) | `suscripciones` | activa/desactiva |

---

## API-04x · Catálogo de contenido (MOD-04)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-040 | `GET /materias` | auth | [RF-030](../05-requerimientos/RF-030-catalogo-contenido.md) | `materias`,`modulos`,`temas`,`subtemas` | — |
| API-041 | `GET /materias/{id}/arbol` | auth | [RF-030](../05-requerimientos/RF-030-catalogo-contenido.md) | jerarquía completa | — |
| API-042 | `POST /admin/materias` | admin | [RF-030](../05-requerimientos/RF-030-catalogo-contenido.md) | `materias` | [MSG-101](../14-mensajes-sistema/mensajes-sistema.md#msg-10x--panel-administrativo-mod-10) · [RN-001](../06-reglas-negocio/reglas-principales.md) |
| API-043 | `POST /admin/preguntas` | admin | [RF-033](../05-requerimientos/RF-033-contenido-reactivo.md) | `preguntas`,`opciones` | [MSG-040](../14-mensajes-sistema/mensajes-sistema.md#msg-04x--catálogo-y-carga-masiva-mod-04-admin) · [RN-003/004](../06-reglas-negocio/reglas-principales.md) |
| API-044 | `POST /admin/estimulos` | admin | [RF-033](../05-requerimientos/RF-033-contenido-reactivo.md) | `estimulos` | [RN-008](../06-reglas-negocio/reglas-principales.md) |
| API-045 | `POST /admin/import/preguntas` | admin | [RF-035](../05-requerimientos/RF-035-carga-masiva-excel.md) | `importaciones`,`preguntas`,`opciones` | [MSG-041/042](../14-mensajes-sistema/mensajes-sistema.md#msg-04x--catálogo-y-carga-masiva-mod-04-admin) · [RNA-021/022](../06-reglas-negocio/reglas-alternas.md) |
| API-046 | `GET /admin/import/{import_id}` | admin | [RF-035](../05-requerimientos/RF-035-carga-masiva-excel.md) | `importaciones` | reporte por fila |
| API-047 | `GET /admin/import/plantilla` | admin | [RF-035](../05-requerimientos/RF-035-carga-masiva-excel.md) | — | descarga plantilla |

---

## API-05x · Evaluaciones (MOD-05)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-050 | `GET /evaluaciones/config` | auth | [RF-040](../05-requerimientos/RF-040-motor-evaluaciones.md) | `evaluacion_config` | [RN-050](../06-reglas-negocio/reglas-principales.md#evaluaciones-y-métricas) |
| API-051 | `POST /intentos` | auth | [RF-040](../05-requerimientos/RF-040-motor-evaluaciones.md) | `intentos` | [MSG-051](../14-mensajes-sistema/mensajes-sistema.md#msg-05x--evaluaciones-mod-05) · [RNA-032](../06-reglas-negocio/reglas-alternas.md) |
| API-052 | `POST /intentos/{id}/responder` | auth | [RF-040](../05-requerimientos/RF-040-motor-evaluaciones.md) | `respuestas_intento` | [RN-054](../06-reglas-negocio/reglas-principales.md#evaluaciones-y-métricas) |
| API-053 | `POST /intentos/{id}/finalizar` | auth | [RF-040](../05-requerimientos/RF-040-motor-evaluaciones.md) | `intentos` | [MSG-053](../14-mensajes-sistema/mensajes-sistema.md#msg-05x--evaluaciones-mod-05) · [RN-052](../06-reglas-negocio/reglas-principales.md#evaluaciones-y-métricas) |
| API-054 | `GET /intentos/{id}` | auth | [RF-040](../05-requerimientos/RF-040-motor-evaluaciones.md) | `intentos`,`respuestas_intento` | — |
| API-055 | `GET /intentos/{id}/tiempo` | auth | [RF-042](../05-requerimientos/RF-042-simulador.md) | `intentos` | [MSG-050](../14-mensajes-sistema/mensajes-sistema.md#msg-05x--evaluaciones-mod-05) · [RN-051](../06-reglas-negocio/reglas-principales.md#evaluaciones-y-métricas) |

---

## API-06x · Progreso y métricas (MOD-06)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-060 | `GET /progreso` | auth | [RF-050](../05-requerimientos/RF-050-dashboard-progreso.md) | `v_desempeno_tema`,`intentos` | [MSG-060](../14-mensajes-sistema/mensajes-sistema.md#msg-06x--progreso-y-métricas-mod-06) · [RN-053](../06-reglas-negocio/reglas-principales.md#evaluaciones-y-métricas) |
| API-061 | `GET /progreso/historial` | auth | [RF-050](../05-requerimientos/RF-050-dashboard-progreso.md) | `intentos` | — |

---

## API-07x · Material y medios (MOD-07)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-070 | `GET /media/{materialId}/url` | auth | [RF-060](../05-requerimientos/RF-060-visor-material.md) · [RF-110](../05-requerimientos/RF-110-proteccion-contenido.md) | `materiales`,`accesos_contenido` | [MSG-070/074](../14-mensajes-sistema/mensajes-sistema.md#msg-07x--material-y-protección-de-contenido-mod-07) · [RN-110-01/02](../05-requerimientos/RF-110-proteccion-contenido.md) · URL firmada (EXT-03) |

---

## API-08x · Referidos (MOD-08)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-080 | `GET /referidos` | auth | [RF-070](../05-requerimientos/RF-070-referidos.md) | `referidos`,`beneficios_otorgados` | [MSG-080/081](../14-mensajes-sistema/mensajes-sistema.md#msg-08x--referidos-mod-08) · [RN-040](../06-reglas-negocio/reglas-principales.md#referidos) |
| API-081 | `GET /referidos/codigo` | auth | [RF-070](../05-requerimientos/RF-070-referidos.md) | `codigos_referido` | [RN-045](../06-reglas-negocio/reglas-principales.md#referidos) |

---

## API-10x · Panel administrativo (MOD-10)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-100 | `GET /admin/usuarios` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | `usuarios` | [MSG-100](../14-mensajes-sistema/mensajes-sistema.md#msg-10x--panel-administrativo-mod-10) · [RF-101](../05-requerimientos/RF-100-panel-administrativo.md) |
| API-101 | `PUT /admin/usuarios/{id}/estado` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | `usuarios`,`auditoria` | RNF-004 |
| API-102 | `GET /admin/pagos` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | `pagos` | — |
| API-103 | `PUT /admin/suscripciones/{id}` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | `suscripciones`,`auditoria` | — |
| API-104 | `PUT /admin/referidos/beneficios` | admin | [RF-070](../05-requerimientos/RF-070-referidos.md) | (config) | [RN-042](../06-reglas-negocio/reglas-principales.md#referidos) |
| API-105 | `GET /admin/auditoria` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | `auditoria`,`audit_accesos` | RNF-004 |
| API-106 | `GET /admin/reportes/{tipo}` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | varios | exportable |
| API-107 | `POST /admin/{entidad}` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | CRUD genérico | [MSG-101](../14-mensajes-sistema/mensajes-sistema.md#msg-10x--panel-administrativo-mod-10) |
| API-108 | `PUT /admin/{entidad}/{id}` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | CRUD genérico | — |
| API-109 | `DELETE /admin/{entidad}/{id}` | admin | [RF-100](../05-requerimientos/RF-100-panel-administrativo.md) | borrado lógico | [MSG-043](../14-mensajes-sistema/mensajes-sistema.md#msg-04x--catálogo-y-carga-masiva-mod-04-admin) · [RN-006](../06-reglas-negocio/reglas-principales.md) |

---

## API-12x · Anuncios (MOD-12)

| ID | Método · Ruta | Auth | RF | Tablas BD | Mensajes / reglas |
|----|---------------|------|----|-----------|-------------------|
| API-120 | `GET /anuncios/activos` | auth | [RF-120](../05-requerimientos/RF-120-anuncios.md) | `anuncios`,`anuncios_acuse` | [MSG-120/121](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12) · [RN-120-02](../06-reglas-negocio/reglas-principales.md#anuncios) |
| API-121 | `POST /anuncios/{id}/acuse` | auth | [RF-120](../05-requerimientos/RF-120-anuncios.md) | `anuncios_acuse` | [RN-120-03](../06-reglas-negocio/reglas-principales.md#anuncios) |
| API-122 | `POST /admin/anuncios` | admin | [RF-120](../05-requerimientos/RF-120-anuncios.md) | `anuncios` | [MSG-122/100](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12) · V-120-01 |

---

## Errores transversales

Todos los endpoints pueden devolver los mensajes globales [MSG-110..115](../14-mensajes-sistema/mensajes-sistema.md#msg-11x--globales-y-seguridad-mod-11) (error interno, sin conexión, rate limit, 404, sesión expirada, mantenimiento). El formato de error es uniforme `{ error, message }` ([08 §2](../08-especificaciones-tecnicas/00-indice-especificaciones.md#2-convenciones-de-api)).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/16-apis-servicios/catalogo-endpoints.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
