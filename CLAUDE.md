# CLAUDE.md — Contexto del proyecto Alexandrya

> Archivo de contexto para asistentes de IA. Resume **qué es** este repositorio, **cómo está organizado** y **dónde buscar** cada cosa, para poder responder y trabajar sin re-explorar todo desde cero.

---

## 1. Qué es Alexandrya

**Alexandrya — Web Study Platform.** Plataforma educativa **por suscripción** para preparación académica (exámenes de admisión, certificación, nivelación). Los alumnos practican y se evalúan con exámenes, cuestionarios y simuladores organizados por **materia → módulo → tema → subtema → banco de preguntas**, con retroalimentación inmediata, métricas de progreso y recomendaciones.

- **Acceso de pago obligatorio**, vigencia de **1 año** (no hay capa gratuita; la landing es la única zona libre).
- **Clientes:** Web (landing pública + portal del alumno + panel admin) y **app Android** (primera fase móvil, solo consumo).
- **Mercado objetivo:** México (MXN, español, pagos SPEI/tarjeta).
- **11 materias iniciales:** Química, Matemáticas, Competencias escritas, Biología, Competencia lectora, Historia, Física, Español / Literatura, Filosofía, Geografía, Historia Universal. El catálogo es **data-driven**: se agregan materias sin tocar código (RN-001 / ADR-005).

> ⚠️ Este proyecto **no es de Podemos Progresar**. Es un proyecto/cliente distinto que vive en el directorio personal del usuario. No aplicar la terminología institucional de Podemos (socios/integrantes) aquí.

---

## 2. Estado actual del repositorio

**Este repositorio contiene SOLO documentación** — fase de **análisis y diseño (Fase 0)**. **No hay código de aplicación todavía** (no hay backend, frontend ni app implementados). Lo único "ejecutable" son los **scripts DDL de PostgreSQL** en [docs/15-base-datos/scripts/](docs/15-base-datos/scripts/).

- **Versión documental actual:** `v0.3.0` (2026-06-19).
- No es un repositorio git (al momento de escribir esto).
- Raíz: este `CLAUDE.md`, el logo (`alexandrya_logo_variant_*.png`) y la carpeta [docs/](docs/).

---

## 3. Stack tecnológico de referencia

Definido en [docs/08-especificaciones-tecnicas/00-indice-especificaciones.md](docs/08-especificaciones-tecnicas/00-indice-especificaciones.md). Aún **no implementado**, es el stack objetivo:

| Capa | Tecnología |
|------|-----------|
| Frontend Web | **Next.js (React)** — SSR/SSG para SEO de la landing |
| Mobile | **Flutter** (Android primero; iOS a futuro) |
| Backend | **NestJS** (TypeScript), modular 1:1 con los módulos `MOD-##` (ADR-001) |
| Base de datos | **PostgreSQL** (PK UUID con `gen_random_uuid()`/pgcrypto) |
| Caché | **Redis** (sesión única, rate limiting, caché de catálogo) |
| Mensajería | **RabbitMQ** (correos, reporte semanal, webhooks async) |
| Storage / CDN | **S3** + CloudFront (URLs firmadas para medios) |
| CI/CD | **GitHub Actions** |
| Observabilidad | Prometheus + Grafana; logs en ELK |
| Nube | **AWS** (alternativa Azure; comparativa de costos pendiente) |

**API:** REST sobre HTTPS, JSON, versionada por path (`/api/v1/...`), auth JWT `Bearer`, errores uniformes `{ error, message }`, idempotencia en pagos/webhooks, contrato OpenAPI como fuente de verdad compartida web↔móvil.

**Decisión abierta clave:** **ADR-007** (monorepo vs polyrepo) sigue en *Propuesta* — [docs/08-especificaciones-tecnicas/01-estrategia-repositorios.md](docs/08-especificaciones-tecnicas/01-estrategia-repositorios.md).

---

## 4. Arquitectura funcional: los 12 módulos (`MOD-##`)

Columna vertebral del producto. El backend NestJS se alinea 1:1 con estos módulos. Definidos en [docs/04-modulos/modulos-secciones.md](docs/04-modulos/modulos-secciones.md).

| Módulo | Nombre | Núcleo |
|--------|--------|--------|
| MOD-01 | Landing pública | Hero, planes, legal, contacto (solo web) |
| MOD-02 | Identidad y acceso | Registro, login, verificación, recuperación, MFA, sesión única |
| MOD-03 | Suscripción y pagos | Checkout, vigencia, renovación, webhooks (pago **solo web** en MVP) |
| MOD-04 | Catálogo de contenido | Materias→módulos→temas→subtemas, banco de preguntas, carga masiva Excel |
| MOD-05 | Evaluaciones | Tipos (tema/módulo/materia/general/simulador), motor, temporizador, retro |
| MOD-06 | Progreso y métricas | Dashboard, áreas de oportunidad, recomendaciones, historial |
| MOD-07 | Material y medios | Visor embebido (video/PDF/imagen), entrega protegida (URLs firmadas, watermark, FLAG_SECURE) |
| MOD-08 | Referidos | Código único, hasta 3 referidos, beneficios configurables |
| MOD-09 | Notificaciones | Correos transaccionales + reporte semanal (backend/RabbitMQ) |
| MOD-10 | Panel administrativo | Gestión, roles (admin/editor/soporte), reportes (solo web) |
| MOD-11 | Seguridad y auditoría | JWT, OWASP Top 10, rate limiting, auditoría inmutable |
| MOD-12 | Anuncios | Comunicados in-app (banner/modal/centro) + correo opcional |

**Actores:** Visitante · Alumno · Alumno con suscripción vencida · Referido · Administrador · Editor de contenido · (+ sistemas externos de pago y correo). Ver [docs/03-actores/actores.md](docs/03-actores/actores.md).

**División Web vs Android:** backend único, dos clientes. Detalle en [docs/01-vision/division-web-mobile.md](docs/01-vision/division-web-mobile.md). Clave: pago y panel admin **solo web**; app Android = cliente de consumo (estudiar + evaluarse); **sesión única transversal** (un login en app expulsa la web y viceversa).

---

## 5. Mapa de la documentación (`docs/`)

Carpetas numeradas por tipo de artefacto; cada una tiene su propio índice. El **índice maestro** es [docs/README.md](docs/README.md) y el **mapa cruzado** (entrada recomendada para navegar relaciones) es [docs/17-inventario/inventario-general.md](docs/17-inventario/inventario-general.md).

| # | Carpeta | Contenido |
|---|---------|-----------|
| 01 | `01-vision/` | Visión de producto + división web/móvil |
| 02 | `02-glosario/` | Vocabulario único del dominio |
| 03 | `03-actores/` | Actores, roles y permisos |
| 04 | `04-modulos/` | Mapa de módulos y secciones (columna vertebral) |
| 05 | `05-requerimientos/` | **22 RF detallados** (plantilla de 14 secciones) + catálogo RNF |
| 06 | `06-reglas-negocio/` | Reglas principales (`RN`, 47) y alternas (`RNA`, 32) |
| 07 | `07-casos-uso/` | Casos de uso (`CU`) y flujos alternos (`FA`) |
| 08 | `08-especificaciones-tecnicas/` | Stack, ADRs, convenciones de API |
| 09 | `09-diagramas/` | Arquitectura, componentes, ERD, flujos (Mermaid) + visor HTML |
| 10 | `10-casos-prueba/` | Catálogo de casos de prueba (`TC`/`CP`) |
| 11 | `11-ux-estados-pantalla/` | Estados de pantalla (`EP`, wireframes textuales) |
| 12 | `12-notificaciones/` | Matriz de notificaciones (`NT`) + plantillas de correo (`CT`) |
| 13 | `13-roadmap/` | Roadmap, MVP y plan a 3 años |
| 14 | `14-mensajes-sistema/` | **Catálogo central de microcopy** (`MSG`): errores, avisos, vacíos |
| 15 | `15-base-datos/` | **Scripts DDL PostgreSQL** (35 tablas + 1 vista) en orden de dependencias |
| 16 | `16-apis-servicios/` | Catálogo de **57 endpoints** (`API`) + 12 servicios (`SVC`) |
| 17 | `17-inventario/` | Inventario general / mapa maestro de relaciones |

---

## 6. Convención de identificadores y trazabilidad

El proyecto usa IDs con prefijo en TODOS los artefactos. **Al referirte a algo, usa su ID** (p. ej. "RF-001A", "RN-011") — así es trazable.

| Prefijo | Artefacto |
|---------|-----------|
| `MOD-##` | Módulo |
| `RF-###` | Requerimiento funcional (subdivisible: `RF-001A`) |
| `RNF-###` | Requerimiento no funcional |
| `RN-###` / `RNA-###` | Regla de negocio principal / alterna (excepción) |
| `CU-###` / `FA-###` | Caso de uso / flujo alterno |
| `V-###` / `TC-###` (`CP-###`) | Validación / caso de prueba |
| `EP-###` | Estado de pantalla |
| `NT-###` / `CT-###` | Notificación / plantilla de correo |
| `MSG-###` | Mensaje del sistema (la centena indica el módulo) |
| `API-###` / `SVC-##` | Endpoint REST / servicio de dominio |
| `ADR-###` | Decisión técnica registrada |

**Cadena de trazabilidad:** `RF → RN/RNA → V → CU/FA → EP → MSG → TC → NT`. Cada `RF-###` cierra con su matriz de trazabilidad (sección 14). **Todos los textos visibles al usuario se centralizan en el catálogo `MSG-###`** ([docs/14-mensajes-sistema/mensajes-sistema.md](docs/14-mensajes-sistema/mensajes-sistema.md)) — no inventar microcopy disperso.

**Plantilla de cada RF (14 secciones):** Info general · Histórico · Introducción · Objetivo · Diagramas · Datos · Validaciones · Reglas · RNF · Mockups/EP · Criterios de aceptación · Especificación técnica · Casos de prueba · Trazabilidad. Referencia completa: [docs/05-requerimientos/RF-001A-autenticacion.md](docs/05-requerimientos/RF-001A-autenticacion.md).

---

## 7. Base de datos (referencia rápida)

PostgreSQL, **35 tablas + 1 vista**. Scripts numerados por orden de dependencias en [docs/15-base-datos/scripts/](docs/15-base-datos/scripts/); `run_all.sql` los ejecuta todos (idempotentes con `IF NOT EXISTS`). `99_drop_all.sql` es teardown destructivo (solo dev/test).

Convenciones: PK `UUID`; **borrado lógico** (`activo/activa BOOLEAN`, RN-006); unicidad condicional con índices parciales (`WHERE activa`/`WHERE vigente`) para "una sola sesión activa" y "un solo documento legal vigente"; idempotencia de pagos (`idempotency_key`, `payload_hash`); datos sensibles solo como hash/cifrado (RN-071); auditoría inmutable (`audit_accesos`, `auditoria`). Redis y RabbitMQ **no son DDL** (estado de sesión/colas vive en backend).

---

## 8. Roadmap (resumen)

- **Fase 0 (T0, meses 0–3):** esta documentación + arquitectura + setup CI/CD. ← *estamos aquí*
- **Fase 1 / MVP (meses 3–12):** Web + backend (auth, suscripción, catálogo, evaluaciones, progreso) → app Android de consumo → referidos, notificaciones, panel admin → hardening y lanzamiento.
- **Fase 2 (Año 2):** pagos in-app + push Android, analítica avanzada, gamificación.
- **Fase 3 (Año 3):** iOS, DRM premium / contenido en vivo, modo offline, internacionalización, recomendaciones predictivas.

Detalle: [docs/13-roadmap/roadmap.md](docs/13-roadmap/roadmap.md).

---

## 9. Cómo navegar según la tarea

- **Entender el producto:** [Visión](docs/01-vision/vision-producto.md) → [Glosario](docs/02-glosario/glosario.md) → [Actores](docs/03-actores/actores.md) → [Módulos](docs/04-modulos/modulos-secciones.md).
- **Implementar:** [Requerimientos](docs/05-requerimientos/00-indice-requerimientos.md) → [Especificaciones técnicas](docs/08-especificaciones-tecnicas/00-indice-especificaciones.md) → [Diagramas](docs/09-diagramas/) → [Base de datos](docs/15-base-datos/00-indice-base-datos.md) → [APIs](docs/16-apis-servicios/00-indice-apis-servicios.md).
- **QA:** [Casos de prueba](docs/10-casos-prueba/00-catalogo-casos-prueba.md) + sección 13 de cada RF.
- **Producto / planeación:** [Roadmap](docs/13-roadmap/roadmap.md) + [Reglas de negocio](docs/06-reglas-negocio/reglas-principales.md).
- **Navegación cruzada (de un módulo a todos sus artefactos):** [Inventario general](docs/17-inventario/inventario-general.md).

---

## 10. Convenciones al editar la documentación

- **Idioma:** español (México). Tono profesional, directo.
- **Pie de página estándar:** todo `.md` cierra con un bloque tras el marcador `<!-- FOOTER:ALEXANDRYA -->` que indica versión documental, fecha y enlaces (Índice + Mensajes). Se regenera por script reescribiendo lo que sigue al **último** marcador; la versión del pie es la del conjunto documental (`v0.3.0`), no la versión interna de cada RF.
- **Rutas relativas** según la profundidad del archivo.
- Mantener la **trazabilidad por IDs** y la **centralización de microcopy en `MSG-###`** al agregar o cambiar contenido.
- Pendientes abiertos conocidos (ver [Inventario §5](docs/17-inventario/inventario-general.md)): ADR-007 (repos), `evaluacion_config.alcance_id` (referencia polimórfica), `API-015 /contacto`, varias plantillas `CT` por redactar.
