# 15 — Base de Datos (Scripts DDL)

Consolida en **un solo lugar** todos los scripts a nivel base de datos (PostgreSQL) que estaban dispersos en la sección 6 de cada `RF-###`. Es la **referencia declarativa** del esquema; en la implementación, estos scripts se convierten en **migraciones** dentro del repo de backend/API ([ver ADR-007 — estrategia de repositorios](../08-especificaciones-tecnicas/01-estrategia-repositorios.md)).

> **Motor:** PostgreSQL · **Estado:** esquema de referencia v0.3.0 · **Validación:** orden de dependencias (FKs) y vistas verificado.

---

## 1. Cómo ejecutar

Los scripts viven en [`scripts/`](scripts/) numerados por **orden de dependencias**. Para crear el esquema completo:

```bash
cd docs/15-base-datos/scripts
psql -h <host> -U <user> -d <db> -v ON_ERROR_STOP=1 -f run_all.sql
```

`run_all.sql` ejecuta cada archivo en orden. Todos usan `CREATE TABLE IF NOT EXISTS` / `CREATE INDEX IF NOT EXISTS`, por lo que **re-ejecutarlos es seguro** (idempotente para la estructura).

---

## 2. Orden de ejecución y contenido

| # | Script | Módulo | Tablas / objetos | Origen (RF) |
|---|--------|--------|------------------|-------------|
| 00 | [`00_extensiones.sql`](scripts/00_extensiones.sql) | — | `pgcrypto` (uuid) | — |
| 01 | [`01_roles_usuarios.sql`](scripts/01_roles_usuarios.sql) | MOD-02/10 | `roles`, `usuarios`, `tokens_verificacion`, `mfa_secretos`, `mfa_codigos_respaldo` | RF-100, RF-001, RF-016 |
| 02 | [`02_sesiones_seguridad.sql`](scripts/02_sesiones_seguridad.sql) | MOD-02/11 | `sesiones`, `acceso_historial`, `audit_accesos`, `tokens_reset` | RF-001A, RF-080, RF-001B |
| 03 | [`03_suscripcion_pagos.sql`](scripts/03_suscripcion_pagos.sql) | MOD-03 | `planes`, `suscripciones`, `pagos`, `eventos_pago` | RF-002, RF-024, RF-020, RF-023 |
| 04 | [`04_catalogo_contenido.sql`](scripts/04_catalogo_contenido.sql) | MOD-04 | `materias`, `modulos`, `temas`, `subtemas`, `estimulos`, `preguntas`*, `opciones`* | RF-030, RF-033, RF-032/034 |
| 05 | [`05_evaluaciones.sql`](scripts/05_evaluaciones.sql) | MOD-05/06 | `evaluacion_config`*, `intentos`, `respuestas_intento`, vista `v_desempeno_tema` | RF-040/041/042, RF-050 |
| 06 | [`06_material_proteccion.sql`](scripts/06_material_proteccion.sql) | MOD-07 | `materiales`, `accesos_contenido` | RF-060, RF-110 |
| 07 | [`07_referidos.sql`](scripts/07_referidos.sql) | MOD-08 | `codigos_referido`, `referidos`, `beneficios_otorgados` | RF-070..073 |
| 08 | [`08_notificaciones.sql`](scripts/08_notificaciones.sql) | MOD-09 | `notificaciones` | RF-090 |
| 09 | [`09_importaciones.sql`](scripts/09_importaciones.sql) | MOD-04/10 | `importaciones` | RF-035 |
| 10 | [`10_legales.sql`](scripts/10_legales.sql) | MOD-01 | `documentos_legales`, `consentimientos` | RF-003 |
| 11 | [`11_auditoria.sql`](scripts/11_auditoria.sql) | MOD-10/11 | `auditoria` | RF-100, RNF-004 |
| 12 | [`12_anuncios.sql`](scripts/12_anuncios.sql) | MOD-12 | `anuncios`, `anuncios_acuse` | RF-120 |
| 90 | [`90_seed.sql`](scripts/90_seed.sql) | — | seed de `roles` (y plan de ejemplo opcional) | RF-100, RF-002 |
| — | [`run_all.sql`](scripts/run_all.sql) | — | runner que ejecuta todo en orden | — |
| 99 | [`99_drop_all.sql`](scripts/99_drop_all.sql) | — | **teardown** completo (⚠️ destructivo, solo dev/test) | — |
| — | [`scripts/README.md`](scripts/README.md) | — | guía rápida del directorio de scripts | — |

**Total:** 35 tablas + 1 vista. El modelo entidad-relación visual está en [09-diagramas/03-modelo-datos-erd.md](../09-diagramas/03-modelo-datos-erd.md).

\* `preguntas`/`opciones` y `evaluacion_config`: su DDL **ya quedó documentado** en el RF correspondiente. Ver §4.

---

## 3. Convenciones del esquema

- **PK:** `UUID` con `gen_random_uuid()` (pgcrypto / PG13+).
- **Borrado lógico:** las entidades con historial usan `activo/activa BOOLEAN` en vez de borrado físico ([RN-006](../06-reglas-negocio/reglas-principales.md)).
- **Unicidad condicional:** índices parciales (`WHERE activa`, `WHERE vigente`) para reglas como "una sola sesión activa" ([RF-080](../05-requerimientos/RF-080-sesion-unica.md)) o "un solo documento legal vigente".
- **Idempotencia de pagos:** `idempotency_key` (pagos) y `payload_hash` (eventos_pago) únicos ([ADR-006](../08-especificaciones-tecnicas/00-indice-especificaciones.md)).
- **Datos sensibles:** contraseñas/secretos solo como hash o cifrados; nunca texto plano ([RN-071](../06-reglas-negocio/reglas-principales.md)).
- **Auditoría:** `audit_accesos` (autenticación) y `auditoria` (acciones admin) — registro inmutable ([RNF-004](../05-requerimientos/00-catalogo-requerimientos.md)).
- **Caché/colas no son DDL:** sesión única en Redis, auto-logout por inactividad ([RN-035](../06-reglas-negocio/reglas-principales.md)) y envío de correos (RabbitMQ) se gestionan en backend; aquí solo persiste el estado.

---

## 4. Tablas antes implícitas — ahora documentadas en su RF ✅

Estas tablas se **referenciaban** (vía FK y `ALTER TABLE`) pero **no tenían `CREATE TABLE`** propio. Su DDL **ya se incorporó** al RF correspondiente (fuente única), y aquí aparece en su **estado final consolidado**:

| Tabla | DDL documentado en | Notas |
|-------|--------------------|-------|
| `preguntas` | [RF-030 §6.3](../05-requerimientos/RF-030-catalogo-contenido.md#63-ddl-banco-de-preguntas--base) (base) + [RF-033 §6.2](../05-requerimientos/RF-033-contenido-reactivo.md) (extensión) | Borrado lógico (`activa`); 4 opciones, una correcta (RN-003/004) |
| `opciones` | [RF-030 §6.3](../05-requerimientos/RF-030-catalogo-contenido.md#63-ddl-banco-de-preguntas--base) (base) + [RF-033 §6.2](../05-requerimientos/RF-033-contenido-reactivo.md) (extensión) | RF-033 renombra `texto`→`contenido` y añade `formato`/`imagen_url` |
| `evaluacion_config` | [RF-040 §6.2](../05-requerimientos/RF-040-motor-evaluaciones.md#6--especificación-de-datos) | `tiempo_limite_seg` obligatorio para `simulador` (RF-042) |

> Pendiente menor de validar con el equipo: forma exacta de `alcance_id` en `evaluacion_config` (referencia polimórfica a materia/módulo/tema).

---

## 5. Relación con la estrategia de repositorios

Según [ADR-007](../08-especificaciones-tecnicas/01-estrategia-repositorios.md), el esquema vive operativamente como **migraciones en el repo del backend (NestJS)**. Este directorio es la **fuente declarativa de referencia** dentro del repo de documentación: se mantiene sincronizado y sirve de contrato de datos para diseño y QA. Al implementar, conviene generar las migraciones (p. ej. con el ORM/migrador elegido) a partir de estos scripts.

---

## 6. Trazabilidad
| Tipo | Referencia |
|------|------------|
| ERD visual | [09-diagramas/03-modelo-datos-erd.md](../09-diagramas/03-modelo-datos-erd.md) |
| Componentes backend | [09-diagramas/02-componentes.md](../09-diagramas/02-componentes.md) |
| Estrategia de repos / migraciones | [08.1 ADR-007](../08-especificaciones-tecnicas/01-estrategia-repositorios.md) |
| Requerimientos (sección 6 de cada RF) | [05-requerimientos](../05-requerimientos/00-indice-requerimientos.md) |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/15-base-datos/00-indice-base-datos.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
