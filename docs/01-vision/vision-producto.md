# 00 — Visión de Producto

## 1. Resumen ejecutivo

**Alexandrya** es una plataforma educativa por suscripción para preparación académica. Los alumnos practican y se evalúan con exámenes, cuestionarios y simuladores organizados por materia, módulo, tema y subtema. La plataforma entrega retroalimentación inmediata, mide el progreso y recomienda áreas de estudio.

El acceso es **de pago obligatorio** con vigencia de **1 año**. Se ofrece en **web** (landing pública + portal del alumno) y en **app Android** (primera fase móvil).

## 2. Problema

Los estudiantes que se preparan para exámenes (de admisión, certificación o nivelación) carecen de una herramienta única que:
- Combine banco de preguntas de calidad con explicaciones y material de apoyo.
- Simule el examen real con tiempos y estructura.
- Mida objetivamente sus fortalezas y debilidades por tema.
- Funcione tanto en escritorio como en móvil con la misma cuenta.

Las soluciones actuales suelen ser PDFs estáticos, grupos de mensajería, o apps con contenido desordenado y sin métricas accionables.

## 3. Propuesta de valor

| Para el alumno | Para el negocio |
|----------------|-----------------|
| Práctica ilimitada estructurada por materia/tema | Ingreso recurrente por suscripción anual |
| Retroalimentación inmediata y explicación por pregunta | Crecimiento orgánico vía sistema de referidos |
| Dashboard de progreso con áreas de oportunidad | Contenido reutilizable y escalable por materia |
| Simuladores que replican el examen real | Panel administrativo para operar sin tocar código |
| Acceso multiplataforma (web + Android) con una cuenta | Catálogo de materias configurable sin desarrollo |

## 4. Objetivos del producto

### Objetivos de negocio
1. Lanzar un MVP de pago con las 11 materias iniciales.
2. Lograr conversión de visitante → suscriptor a través de la landing.
3. Activar el crecimiento referido (cada alumno invita hasta 3).
4. Retener vía renovación anual antes del vencimiento.

### Objetivos de producto
1. Que el alumno pueda evaluarse en menos de 1 minuto desde el login.
2. Que el dashboard muestre debilidades/fortalezas de forma accionable.
3. Que el contenido (materias, módulos, temas, preguntas) se administre 100% desde el panel, incluida carga masiva por Excel.

## 5. Materias iniciales

Las 11 materias del catálogo inicial son:

1. Química
2. Matemáticas
3. Competencias escritas
4. Biología
5. Competencia lectora
6. Historia
7. Física
8. Español / Literatura
9. Filosofía
10. Geografía
11. Historia Universal

La arquitectura debe permitir **agregar materias nuevas sin modificar código** (ver [RN-001](../06-reglas-negocio/reglas-principales.md)).

## 6. Actores del sistema

| Actor | Descripción |
|-------|-------------|
| **Visitante** | Usuario no autenticado que navega la landing pública. |
| **Alumno** | Usuario registrado con suscripción activa. Consume contenido y se evalúa. |
| **Alumno con suscripción vencida** | Cuenta válida sin acceso al contenido hasta renovar. |
| **Referido** | Visitante que se registra usando el enlace/código de un alumno. |
| **Administrador** | Opera el panel: contenido, usuarios, pagos, referidos, reportes. |
| **Editor de contenido** | Rol acotado: crea/edita materias, módulos, temas y preguntas. |
| **Sistema de pagos** | Pasarela externa (Stripe/Mercado Pago/etc.) que confirma cobros. |
| **Sistema de correo** | Servicio externo que envía notificaciones transaccionales y reportes. |

## 7. Alcance del producto (visión completa)

**Incluido:**
- Landing pública con planes y registro.
- Autenticación con verificación de correo, recuperación y MFA opcional.
- Suscripción anual de pago con renovación y validación automática.
- Catálogo configurable: materias → módulos → temas → subtemas → banco de preguntas.
- Evaluaciones: por tema, módulo, materia, generales y simuladores.
- Métricas, historial y dashboard de progreso con recomendaciones.
- Material de apoyo (video, PDF, imagen) visible **solo dentro** de la plataforma.
- Sistema de referidos (hasta 3, beneficios configurables).
- Control de sesión única por cuenta con historial e IP/dispositivo.
- Notificaciones por correo (transaccionales + reporte semanal).
- Panel administrativo con carga masiva por Excel.
- App Android (consumo y evaluación).

**Fuera del alcance inicial (futuro):**
- App iOS.
- Contenido en vivo (clases sincrónicas).
- Marketplace de profesores / contenido de terceros.
- Pagos por materia individual (modelo es suscripción global).

## 8. Métricas de éxito (KPIs)

| KPI | Definición |
|-----|------------|
| Conversión landing → suscripción | % de visitantes que pagan. |
| Activación | % de alumnos que completan ≥1 examen en su primera semana. |
| Tasa de renovación | % de suscripciones renovadas antes/al vencer. |
| Coeficiente de referidos | Promedio de referidos efectivos por alumno (objetivo: ≥1, máx 3). |
| Retención semanal | % de alumnos que regresan cada semana. |
| Disponibilidad | Uptime ≥ 99.9% (ver [RNF](../05-requerimientos/00-catalogo-requerimientos.md)). |

## 9. Supuestos y restricciones

- **Mercado objetivo: México.** Pagos, moneda (MXN), idioma (español) y métodos (SPEI/tarjeta) priorizan este mercado.
- El acceso al contenido **siempre** requiere suscripción activa; no hay capa gratuita de contenido (la landing es la única zona libre).
- La primera fase móvil es **solo Android**.
- La protección de contenido se diseña con expectativas realistas: ver el apartado de anti-piratería en [requerimientos](../05-requerimientos/00-catalogo-requerimientos.md) y [reglas de negocio](../06-reglas-negocio/reglas-principales.md).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/01-vision/vision-producto.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
