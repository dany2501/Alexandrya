# 📚 Alexandrya — Documentación del Proyecto

**Alexandrya — Web Study Platform.** Plataforma educativa por suscripción para preparación académica mediante exámenes, cuestionarios y simuladores. Web pública + portal del alumno + app Android (primera fase).

> **Estado:** Fase de análisis y diseño · **Última actualización:** 2026-06-19 · **Versión doc:** v0.3.0

---

## 🗂️ Índice maestro

La documentación está organizada en carpetas numeradas por tipo de artefacto. Cada carpeta tiene su propio índice interno.

| # | Carpeta | Contenido | Índice |
|---|---------|-----------|--------|
| 01 | [`01-vision/`](01-vision/) | Visión de producto y división de alcance Web/Mobile | [vision-producto.md](01-vision/vision-producto.md) · [division-web-mobile.md](01-vision/division-web-mobile.md) |
| 02 | [`02-glosario/`](02-glosario/) | Vocabulario único del dominio | [glosario.md](02-glosario/glosario.md) |
| 03 | [`03-actores/`](03-actores/) | Actores, roles y permisos | [actores.md](03-actores/actores.md) |
| 04 | [`04-modulos/`](04-modulos/) | Mapa de módulos y secciones de la plataforma | [modulos-secciones.md](04-modulos/modulos-secciones.md) |
| 05 | [`05-requerimientos/`](05-requerimientos/) | Requerimientos funcionales detallados (formato 14 secciones) | [00-indice-requerimientos.md](05-requerimientos/00-indice-requerimientos.md) |
| 06 | [`06-reglas-negocio/`](06-reglas-negocio/) | Reglas de negocio principales y alternas | [reglas-principales.md](06-reglas-negocio/reglas-principales.md) · [reglas-alternas.md](06-reglas-negocio/reglas-alternas.md) |
| 07 | [`07-casos-uso/`](07-casos-uso/) | Casos de uso y flujos alternos | [00-indice-casos-uso.md](07-casos-uso/00-indice-casos-uso.md) · [flujos-alternos.md](07-casos-uso/flujos-alternos.md) |
| 08 | [`08-especificaciones-tecnicas/`](08-especificaciones-tecnicas/) | Stack, contratos de API, decisiones técnicas | [00-indice-especificaciones.md](08-especificaciones-tecnicas/00-indice-especificaciones.md) |
| 09 | [`09-diagramas/`](09-diagramas/) | Arquitectura, componentes, ERD, flujos (Mermaid) | 🖥️ [Visor HTML de los 97 diagramas](09-diagramas/diagramas.html) · [01-arquitectura.md](09-diagramas/01-arquitectura.md) |
| 10 | [`10-casos-prueba/`](10-casos-prueba/) | Catálogo de casos de prueba | [00-catalogo-casos-prueba.md](10-casos-prueba/00-catalogo-casos-prueba.md) |
| 11 | [`11-ux-estados-pantalla/`](11-ux-estados-pantalla/) | Estados de pantalla iniciales (wireframes textuales) | [estados-pantalla-iniciales.md](11-ux-estados-pantalla/estados-pantalla-iniciales.md) |
| 12 | [`12-notificaciones/`](12-notificaciones/) | Matriz de notificaciones y plantillas de correo | [notificaciones.md](12-notificaciones/notificaciones.md) · [plantillas-correo/](12-notificaciones/plantillas-correo/) |
| 13 | [`13-roadmap/`](13-roadmap/) | Roadmap, MVP y plan a 3 años | [roadmap.md](13-roadmap/roadmap.md) |
| 14 | [`14-mensajes-sistema/`](14-mensajes-sistema/) | **Catálogo central de mensajes del sistema** (microcopy: errores, avisos, bloqueos, vacíos) | [mensajes-sistema.md](14-mensajes-sistema/mensajes-sistema.md) |
| 15 | [`15-base-datos/`](15-base-datos/) | **Scripts DDL consolidados** (PostgreSQL) en orden de dependencias | [00-indice-base-datos.md](15-base-datos/00-indice-base-datos.md) · [scripts/](15-base-datos/scripts/) |
| 16 | [`16-apis-servicios/`](16-apis-servicios/) | **Catálogo de endpoints y servicios** cruzado con RF, reglas, tablas y mensajes | [00-indice-apis-servicios.md](16-apis-servicios/00-indice-apis-servicios.md) |
| 17 | [`17-inventario/`](17-inventario/) | **Inventario general** (mapa maestro de todos los artefactos y sus relaciones) | [inventario-general.md](17-inventario/inventario-general.md) |

---

## 🧭 Cómo leer esta documentación

- **Si eres nuevo:** empieza por [Visión de producto](01-vision/vision-producto.md) → [Glosario](02-glosario/glosario.md) → [Actores](03-actores/actores.md) → [Módulos](04-modulos/modulos-secciones.md).
- **Si vas a implementar:** [Requerimientos detallados](05-requerimientos/00-indice-requerimientos.md) → [Especificaciones técnicas](08-especificaciones-tecnicas/00-indice-especificaciones.md) → [Diagramas](09-diagramas/).
- **Si vas a probar (QA):** [Casos de prueba](10-casos-prueba/00-catalogo-casos-prueba.md) + sección 13 de cada RF.
- **Si defines producto:** [Roadmap](13-roadmap/roadmap.md) + [Reglas de negocio](06-reglas-negocio/reglas-principales.md).

---

## 🏷️ Convención de identificadores

| Prefijo | Artefacto | Ejemplo |
|---------|-----------|---------|
| `RF-###` | Requerimiento funcional (puede subdividirse con sufijo: `RF-001A`) | RF-001A |
| `RNF-###` | Requerimiento no funcional | RNF-010 |
| `RN-###` | Regla de negocio principal | RN-011 |
| `RNA-###` | Regla de negocio alterna / de excepción | RNA-003 |
| `CU-###` | Caso de uso | CU-001 |
| `FA-###` | Flujo alterno | FA-001 |
| `CP-###` / `TC-###` | Caso de prueba | CP-021 |
| `V-###` | Validación | V-001A-01 |
| `EP-###` | Estado de pantalla | EP-001 |
| `NT-###` | Notificación | NT-004 |
| `CT-###` | Plantilla de correo (Correo Transaccional) | CT-001 |
| `MSG-###` | Mensaje del sistema (microcopy) — la centena indica el módulo | MSG-022 |
| `MOD-##` | Módulo | MOD-01 |

**Trazabilidad:** `RF → RN/RNA → V → CU/FA → EP → MSG → CP → NT`. Cada RF cierra con su matriz de trazabilidad (sección 14). Los textos al usuario se concentran en el [catálogo de mensajes (`MSG-###`)](14-mensajes-sistema/mensajes-sistema.md).

---

## 📐 Estándar de los documentos de requerimiento

Cada `RF-###` se documenta con la **plantilla de 14 secciones** ([_PLANTILLA-RF.md](05-requerimientos/_PLANTILLA-RF.md)):

1. Información General · 2. Histórico de Cambios · 3. Introducción · 4. Objetivo · 5. Diagramas · 6. Especificación de Datos · 7. Validaciones · 8. Reglas de Negocio · 9. RNF · 10. Mockups / Estados de pantalla · 11. Criterios de Aceptación · 12. Especificación Técnica · 13. Casos de Prueba · 14. Trazabilidad.

Documento de referencia ya completo: [RF-001A — Autenticación](05-requerimientos/RF-001A-autenticacion.md).

---

## 🔢 Versionado

| Versión | Etiqueta | Descripción |
|---------|----------|-------------|
| `vX.Y.Z-alpha` | Interno | Funcionalidad incompleta |
| `vX.Y.Z-beta` | QA/UAT | Candidata a pruebas |
| `vX.Y.Z-rc` | Pre-producción | Release Candidate |
| `vX.Y.Z-MVP` | Producción | Versión mínima funcional |

**Versión de trabajo actual del conjunto documental: `v0.3.0` (2026-06-19).**

---

## 🦶 Pie de página estándar

Todos los documentos `.md` cierran con un **pie de página** uniforme que indica la versión de trabajo, la fecha y los enlaces de navegación (Índice y Mensajes del sistema). Va precedido de un marcador HTML (`FOOTER:ALEXANDRYA`) que permite regenerarlo de forma automática. El ejemplo vivo está al final de este mismo archivo.

- La **versión** del pie es la del conjunto documental en curso (`v0.3.0`), no la versión interna de cada RF (que vive en su sección 1).
- El bloque se regenera con un script que reescribe todo lo que sigue al **último** marcador; así, al subir la versión de trabajo, se actualizan los ~52 archivos en una sola pasada.
- Las rutas del pie (Índice, Mensajes) son relativas a la profundidad de cada archivo.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/README.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 Índice (este documento) · 💬 [Mensajes del sistema](14-mensajes-sistema/mensajes-sistema.md)</sub>
