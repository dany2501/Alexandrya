# Diagrama — Arquitectura general

Modelo C4 simplificado: contexto (actores y sistemas externos) y contenedores (despliegue lógico).

## 1. Diagrama de contexto

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
graph TB
    subgraph Usuarios
        V[Visitante]
        AL[Alumno]
        ADM[Administrador / Editor]
    end

    SYS[["Alexandrya - Plataforma educativa"]]

    subgraph Externos
        PAY[Pasarela de pago - Stripe / Mercado Pago / SPEI]
        MAIL[Servicio de correo transaccional]
        CDN[CDN + Object Storage]
    end

    V -->|Navega landing, se registra y paga| SYS
    AL -->|Estudia, se evalúa, ve progreso| SYS
    ADM -->|Administra contenido y operación| SYS

    SYS -->|Cobros y webhooks| PAY
    PAY -.->|Confirmación de pago| SYS
    SYS -->|Envía notificaciones y reportes| MAIL
    SYS -->|Sirve medios protegidos| CDN
```

## 2. Diagrama de contenedores

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
graph TB
    subgraph Clientes
        WEB["Web pública + Portal alumno (Next.js / React)"]
        ADMUI["Panel administrativo (Web)"]
        APP["App Android (Flutter)"]
    end

    LB["Balanceador de carga + API Gateway"]

    subgraph Backend
        API["API REST (NestJS)"]
        WORKER["Workers asíncronos (correo, reportes, webhooks)"]
    end

    subgraph Datos
        PG[("PostgreSQL - datos transaccionales")]
        REDIS[("Redis - caché + sesiones")]
        MQ{{"RabbitMQ - colas de eventos"}}
        S3[("S3 - medios y material")]
    end

    subgraph Externos
        PAY[Pasarela de pago]
        MAIL[Servicio de correo]
        CDNX[CDN]
    end

    WEB --> LB
    ADMUI --> LB
    APP --> LB
    LB --> API

    API --> PG
    API --> REDIS
    API --> MQ
    API -->|URLs firmadas| S3
    API --> PAY

    MQ --> WORKER
    WORKER --> MAIL
    WORKER --> PG
    PAY -.->|webhook| API

    S3 --> CDNX
    CDNX --> WEB
    CDNX --> APP

    subgraph Observabilidad
        PROM[Prometheus]
        GRAF[Grafana]
        ELK[ELK]
    end
    API -.métricas.-> PROM
    API -.logs.-> ELK
    PROM --> GRAF
```

## 3. Notas de arquitectura

- **API cliente-agnóstica:** un solo backend sirve a web, panel y app (ver [división web/mobile](../01-vision/division-web-mobile.md)).
- **Asíncrono vía RabbitMQ:** correos, reporte semanal y procesamiento de webhooks corren en workers para no bloquear la API ([RF-090](../05-requerimientos/00-catalogo-requerimientos.md), [RF-091](../05-requerimientos/00-catalogo-requerimientos.md)).
- **Caché en Redis:** catálogo de contenido y lista de sesión activa por cuenta (soporta [RN-030](../06-reglas-negocio/reglas-principales.md) sesión única y [RNF-013](../05-requerimientos/00-catalogo-requerimientos.md)).
- **Medios por CDN con URLs firmadas:** soporta [RF-062](../05-requerimientos/00-catalogo-requerimientos.md) y [RF-110](../05-requerimientos/00-catalogo-requerimientos.md).
- **Escalamiento horizontal** de API y workers detrás del balanceador ([RNF-011](../05-requerimientos/00-catalogo-requerimientos.md)).

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/09-diagramas/01-arquitectura.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
