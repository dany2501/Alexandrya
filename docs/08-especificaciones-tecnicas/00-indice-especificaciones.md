# 08 — Especificaciones Técnicas (Índice)

Decisiones técnicas, stack y contratos de API. Es el puente entre los [requerimientos](../05-requerimientos/00-indice-requerimientos.md) y la implementación.

> La comparativa detallada de pasarelas de pago, costos AWS vs Azure e IaC se entregan en la fase de arquitectura. Aquí se fija el stack de referencia y los contratos.

---

## 1. Stack tecnológico

| Capa | Tecnología | Justificación breve |
|------|-----------|---------------------|
| Frontend Web | **Next.js (React)** | SSR/SSG para SEO de la landing, ecosistema maduro, buen rendimiento. |
| Mobile | **Flutter** (Android primera fase) | Un solo código base para futuro iOS; UI consistente; buen rendimiento. |
| Backend | **NestJS** | Estructura modular (encaja con MOD-##), TypeScript compartido con el front, soporte de colas/guards. |
| Base de datos | **PostgreSQL** | Relacional, transaccional, robusto para pagos y catálogo jerárquico. |
| Caché | **Redis** | Sesión única, rate limiting, caché de catálogo. |
| Mensajería | **RabbitMQ** | Correos, reporte semanal y procesamiento de webhooks de forma asíncrona. |
| Storage | **S3** | Medios y material de apoyo con URLs firmadas. |
| CDN | CloudFront / equivalente | Entrega de estáticos y medios. |
| CI/CD | **GitHub Actions** | Build, test y despliegue automatizados. |
| Monitoreo | **Prometheus + Grafana** | Métricas e indicadores de disponibilidad. |
| Logs | **ELK** | Centralización y búsqueda de logs. |
| Nube | **AWS** (alternativa Azure) | Servicios gestionados; comparativa de costos pendiente. |

---

## 2. Convenciones de API

- **Estilo:** REST sobre HTTPS, JSON. Versionado por path: `/api/v1/...`.
- **Autenticación:** `Authorization: Bearer <access_token>` (JWT). Refresh por endpoint dedicado.
- **Documentación:** OpenAPI/Swagger generado desde el código (RNF-031).
- **Errores:** formato uniforme `{ error, message, ... }` con códigos HTTP estándar (400/401/403/404/409/422/429/5xx).
- **Idempotencia:** operaciones de pago y webhooks usan claves de idempotencia.
- **Paginación:** `?page=&limit=` con metadatos de total.

### 2.1 Mapa de endpoints (alto nivel)

| Recurso | Endpoints | Módulo |
|---------|-----------|--------|
| Auth | `POST /auth/register`, `/auth/verify`, `/auth/login`, `/auth/refresh`, `/auth/logout`, `/auth/password/*` | MOD-02 |
| Suscripción | `POST /checkout`, `GET /subscription`, `POST /subscription/renew`, `POST /webhooks/payment` | MOD-03 |
| Catálogo | `GET/POST/PUT /materias|modulos|temas|subtemas|preguntas`, `POST /import/excel` | MOD-04 |
| Evaluaciones | `GET /evaluaciones/config`, `POST /intentos`, `GET /intentos/{id}` | MOD-05 |
| Progreso | `GET /progreso`, `GET /historial` | MOD-06 |
| Medios | `GET /media/{id}/url` (URL firmada) | MOD-07 |
| Referidos | `GET /referidos`, `GET /referidos/codigo` | MOD-08 |
| Admin | `/admin/*` (usuarios, pagos, reportes, config) | MOD-10 |

> El contrato completo (request/response por endpoint) se documenta dentro de la **sección 12** de cada `RF-###`. Ejemplo ya detallado: [RF-001A §12](../05-requerimientos/RF-001A-autenticacion.md#12--especificación-técnica).
>
> 📇 **Catálogo consolidado de los 57 endpoints (`API-###`) y servicios (`SVC/EXT/INF`):** [16-apis-servicios](../16-apis-servicios/00-indice-apis-servicios.md).

---

## 3. Decisiones técnicas registradas (ADR resumido)

| ID | Decisión | Estado |
|----|----------|--------|
| ADR-001 | Backend modular NestJS alineado 1:1 con los módulos MOD-## | Aceptada |
| ADR-002 | Sesión única gestionada en Redis + tabla `sesiones` (no solo JWT stateless) | Aceptada |
| ADR-003 | Pagos solo en web para el MVP (evita comisión de tiendas) | Aceptada (ver [división](../01-vision/division-web-mobile.md)) |
| ADR-004 | Medios servidos con URLs firmadas + watermark; DRM (Widevine) para video premium | Propuesta |
| ADR-005 | Catálogo data-driven: materias como datos, no código | Aceptada |
| ADR-006 | Webhooks de pago idempotentes con `payload_hash` único | Aceptada |
| ADR-007 | [Estrategia de repositorios](01-estrategia-repositorios.md): monorepo de producto + repos satélite (A) vs polyrepo + shared (B) | 🟡 Propuesta — a validar (A recomendada) |

---

## 4. Documentos relacionados
- [Estrategia de repositorios (monorepo vs polyrepo)](01-estrategia-repositorios.md)
- [Diagramas de arquitectura y componentes](../09-diagramas/)
- [Modelo de datos (ERD)](../09-diagramas/03-modelo-datos-erd.md)
- [Catálogo de requerimientos](../05-requerimientos/00-indice-requerimientos.md)

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/08-especificaciones-tecnicas/00-indice-especificaciones.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
