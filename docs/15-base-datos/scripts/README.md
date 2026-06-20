# Scripts DDL — Alexandrya (PostgreSQL)

Scripts del esquema de base de datos, numerados por **orden de dependencias**. Referencia completa (mapa tabla→RF→módulo, convenciones y notas) en el [índice de la sección 15](../00-indice-base-datos.md).

## Uso rápido

```bash
cd docs/15-base-datos/scripts

# Crear todo el esquema (idempotente):
psql -h <host> -U <user> -d <db> -v ON_ERROR_STOP=1 -f run_all.sql

# Eliminar todo el esquema (⚠️ destructivo, solo dev/test):
psql -h <host> -U <user> -d <db> -v ON_ERROR_STOP=1 -f 99_drop_all.sql
```

## Contenido

| Archivo | Propósito |
|---------|-----------|
| `00_extensiones.sql` | Extensiones (`pgcrypto` para UUID) |
| `01_roles_usuarios.sql` | roles, usuarios, verificación, MFA |
| `02_sesiones_seguridad.sql` | sesiones, historial, auditoría de accesos, tokens de reset |
| `03_suscripcion_pagos.sql` | planes, suscripciones, pagos, eventos de pago |
| `04_catalogo_contenido.sql` | jerarquía, estímulos, preguntas, opciones |
| `05_evaluaciones.sql` | config, intentos, respuestas, vista de desempeño |
| `06_material_proteccion.sql` | materiales, accesos a contenido |
| `07_referidos.sql` | códigos, referidos, beneficios |
| `08_notificaciones.sql` | cola/registro de notificaciones |
| `09_importaciones.sql` | bitácora de carga masiva Excel |
| `10_legales.sql` | documentos legales, consentimientos |
| `11_auditoria.sql` | auditoría de acciones admin |
| `12_anuncios.sql` | anuncios y acuse de lectura |
| `90_seed.sql` | datos semilla (roles) |
| `run_all.sql` | ejecuta 00→12 + 90 en orden |
| `99_drop_all.sql` | **teardown** completo (destructivo) |

## Convenciones

- **PK** `UUID` con `gen_random_uuid()`; **borrado lógico** (`activa/activo`) en entidades con historial.
- **Idempotente** para estructura: `CREATE TABLE/INDEX IF NOT EXISTS`. Re-ejecutar `run_all.sql` es seguro.
- **No es la fuente operativa final.** Según [ADR-007](../../08-especificaciones-tecnicas/01-estrategia-repositorios.md), en implementación estos scripts se convierten en **migraciones** del repo de backend; aquí son la referencia declarativa.

> Cualquier cambio de esquema se hace primero en la **sección 6 del RF** correspondiente y luego se refleja aquí, para que la documentación siga siendo la fuente única.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/15-base-datos/scripts/README.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../../README.md) · 💬 [Mensajes del sistema](../../14-mensajes-sistema/mensajes-sistema.md)</sub>
