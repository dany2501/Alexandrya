# 05 — Requerimientos (Índice)

Catálogo de requerimientos funcionales. Cada `RF-###` se documenta con la [plantilla de 14 secciones](_PLANTILLA-RF.md). El catálogo resumido (tabla RF/RNF de una línea) está en [00-catalogo-requerimientos.md](00-catalogo-requerimientos.md).

> **Convención de subdivisión:** un requerimiento grande se separa en sufijos (RF-001A, RF-001B…) cuando conviene documentarlo por separado, como en el ejemplo de autenticación.

---

## 1. Estado de documentación detallada

| ID | Requerimiento | Módulo | Prioridad | Doc detallado |
|----|---------------|--------|-----------|--------------:|
| **RF-001** | **Registro de usuarios** | MOD-02 | 🔴 Crítica | ✅ [Detallado](RF-001-registro.md) |
| **RF-001A** | **Autenticación e inicio de sesión** | MOD-02 | 🔴 Crítica | ✅ [Detallado](RF-001A-autenticacion.md) |
| **RF-001B** | **Recuperación / cambio de contraseña** | MOD-02 | 🔴 Crítica | ✅ [Detallado](RF-001B-recuperacion-contrasena.md) |
| **RF-002** | **Planes y compra desde landing** | MOD-01 | 🔴 Crítica | ✅ [Detallado](RF-002-planes-compra.md) |
| **RF-003** | **Páginas legales** | MOD-01 | 🟡 Media | ✅ [Detallado](RF-003-paginas-legales.md) |
| RF-010 | Alta de cuenta | MOD-02 | 🔴 Crítica | 🔗 Fusionado en [RF-001](RF-001-registro.md) |
| **RF-016** | **MFA opcional** | MOD-02 | 🟡 Media | ✅ [Detallado](RF-016-mfa.md) |
| **RF-020** | **Contratación de suscripción** | MOD-03 | 🔴 Crítica | ✅ [Detallado](RF-020-contratacion-suscripcion.md) |
| **RF-023** | **Validación de pago por webhook** | MOD-03 | 🔴 Crítica | ✅ [Detallado](RF-023-webhook-pago.md) |
| **RF-024** | **Pagos recurrentes y renovación** | MOD-03 | 🔴 Crítica | ✅ [Detallado](RF-024-renovacion.md) |
| **RF-030** | **Catálogo de materias configurable** | MOD-04 | 🔴 Crítica | ✅ [Detallado](RF-030-catalogo-contenido.md) |
| **RF-033** | **Contenido del reactivo (enriquecido + estímulos)** | MOD-04 | 🔴 Crítica | ✅ [Detallado](RF-033-contenido-reactivo.md) |
| **RF-035** | **Carga masiva por Excel** | MOD-04 | 🟠 Alta | ✅ [Detallado](RF-035-carga-masiva-excel.md) |
| **RF-040** | **Motor de evaluaciones** | MOD-05 | 🔴 Crítica | ✅ [Detallado](RF-040-motor-evaluaciones.md) |
| **RF-042** | **Simulador con tiempo** | MOD-05 | 🟠 Alta | ✅ [Detallado](RF-042-simulador.md) |
| **RF-050** | **Dashboard de progreso** | MOD-06 | 🟠 Alta | ✅ [Detallado](RF-050-dashboard-progreso.md) |
| **RF-060** | **Visor de material protegido** | MOD-07 | 🟠 Alta | ✅ [Detallado](RF-060-visor-material.md) |
| **RF-070** | **Sistema de referidos** | MOD-08 | 🟡 Media | ✅ [Detallado](RF-070-referidos.md) |
| **RF-080** | **Control de sesión única** | MOD-02 | 🔴 Crítica | ✅ [Detallado](RF-080-sesion-unica.md) |
| **RF-090** | **Notificaciones transaccionales** | MOD-09 | 🟠 Alta | ✅ [Detallado](RF-090-notificaciones.md) |
| **RF-100** | **Panel administrativo** | MOD-10 | 🔴 Crítica | ✅ [Detallado](RF-100-panel-administrativo.md) |
| **RF-110** | **Protección de contenido** | MOD-07 | 🟠 Alta | ✅ [Detallado](RF-110-proteccion-contenido.md) |
| **RF-120** | **Anuncios y comunicados** | MOD-12 | 🟡 Media | ✅ [Detallado](RF-120-anuncios.md) |

> Lista completa de RF/RNF (una línea cada uno) en [00-catalogo-requerimientos.md](00-catalogo-requerimientos.md).

---

## 2. Orden sugerido de elaboración (siguientes lotes)

1. ✅ **Lote 1 — Acceso y cuenta:** RF-001 (registro), RF-001B (contraseña), RF-080 (sesión única). **Completado.**
2. ✅ **Lote 2 — Monetización:** RF-002, RF-020, RF-023, RF-024. **Completado.**
3. ✅ **Lote 3 — Núcleo de aprendizaje:** RF-030, RF-040, RF-042, RF-050. **Completado.**
4. ✅ **Lote 4 — Contenido y crecimiento:** RF-035, RF-060, RF-070, RF-110. **Completado.**
5. ✅ **Lote 5 — Operación:** RF-090, RF-100, RF-016. **Completado.**

> 🎉 **Los 5 lotes están completos: los 19 requerimientos del plan están documentados con la plantilla de 14 secciones.**
>
> ➕ **Cierre adicional:** RF-003 (Páginas legales) documentado como tarea de contenido/legal (incluye checklist para jurídico). RF-010 (Alta de cuenta) **fusionado en [RF-001](RF-001-registro.md)** (no tiene documento propio). Con esto, **todos los RF del índice están resueltos** (detallados o fusionados).
>
> 🧩 **Adecuación por reactivos reales:** se añadió [RF-033](RF-033-contenido-reactivo.md) (contenido enriquecido con fórmulas LaTeX/MathML, opciones con imagen y **estímulos/lecturas compartidas** por varios reactivos), con impacto en ERD, glosario, reglas RN-007/RN-008, RF-030, RF-035, RF-040 y EP-041.

Cada RF se redactó siguiendo [_PLANTILLA-RF.md](_PLANTILLA-RF.md), tomando [RF-001A](RF-001A-autenticacion.md) como referencia de calidad.

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/05-requerimientos/00-indice-requerimientos.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
