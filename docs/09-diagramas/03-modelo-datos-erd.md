# Diagrama — Modelo de datos (ERD)

Modelo entidad-relación conceptual. La especificación física (tipos, índices, constraints) se detalla en la fase de arquitectura; aquí se fija la estructura y las relaciones.

```mermaid
erDiagram
    USUARIO ||--o| SUSCRIPCION : tiene
    USUARIO ||--o{ SESION : abre
    USUARIO ||--o{ ACCESO_HISTORIAL : registra
    USUARIO ||--o{ INTENTO : realiza
    USUARIO ||--o{ PAGO : efectua
    USUARIO ||--o| CODIGO_REFERIDO : posee
    USUARIO ||--o{ REFERIDO : refiere
    USUARIO }o--o| ROL : tiene

    SUSCRIPCION ||--o{ PAGO : se_paga_con
    PAGO ||--o{ EVENTO_PAGO : genera

    CODIGO_REFERIDO ||--o{ REFERIDO : usa
    REFERIDO ||--o| BENEFICIO_OTORGADO : produce

    MATERIA ||--o{ MODULO : contiene
    MODULO ||--o{ TEMA : contiene
    TEMA ||--o{ SUBTEMA : contiene
    TEMA ||--o{ PREGUNTA : agrupa
    SUBTEMA ||--o{ PREGUNTA : agrupa
    TEMA ||--o{ ESTIMULO : agrupa
    ESTIMULO ||--o{ PREGUNTA : "agrupa (lectura/caso compartido)"
    PREGUNTA ||--|{ OPCION : tiene
    PREGUNTA ||--o{ MATERIAL_APOYO : adjunta

    EVALUACION_CONFIG ||--o{ INTENTO : instancia
    EVALUACION_CONFIG }o--o{ MATERIA : alcance
    INTENTO ||--o{ RESPUESTA_INTENTO : contiene
    RESPUESTA_INTENTO }o--|| PREGUNTA : responde
    RESPUESTA_INTENTO }o--|| OPCION : elige

    USUARIO ||--o{ AUDITORIA : origina

    USUARIO {
        uuid id PK
        string email UK
        string password_hash
        bool email_verificado
        bool mfa_habilitado
        uuid rol_id FK
        datetime creado_en
    }
    ROL {
        uuid id PK
        string nombre "admin|editor|alumno"
    }
    SUSCRIPCION {
        uuid id PK
        uuid usuario_id FK
        string estado "activa|vencida|cancelada"
        datetime inicio_vigencia
        datetime fin_vigencia
        datetime creado_en
    }
    PAGO {
        uuid id PK
        uuid usuario_id FK
        uuid suscripcion_id FK
        string metodo "tarjeta|spei|..."
        decimal monto
        string moneda "MXN"
        string estado "pendiente|confirmado|fallido|reembolsado"
        string ref_pasarela UK
        datetime creado_en
    }
    EVENTO_PAGO {
        uuid id PK
        uuid pago_id FK
        string tipo_webhook
        string payload_hash UK "idempotencia"
        datetime recibido_en
    }
    SESION {
        uuid id PK
        uuid usuario_id FK
        string refresh_token_hash
        bool activa "una sola por usuario"
        string dispositivo
        datetime creada_en
    }
    ACCESO_HISTORIAL {
        uuid id PK
        uuid usuario_id FK
        string ip
        string dispositivo
        string ubicacion_aprox
        datetime fecha_hora
    }
    CODIGO_REFERIDO {
        uuid id PK
        uuid usuario_id FK
        string codigo UK
    }
    REFERIDO {
        uuid id PK
        uuid codigo_referido_id FK
        uuid usuario_invitado_id FK
        int posicion "1|2|3"
        string estado "registrado|efectivo"
        datetime creado_en
    }
    BENEFICIO_OTORGADO {
        uuid id PK
        uuid referido_id FK
        string tipo_beneficio
        datetime otorgado_en
    }
    MATERIA {
        uuid id PK
        string nombre
        bool activa
        int orden
    }
    MODULO {
        uuid id PK
        uuid materia_id FK
        string nombre
        bool activa
        int orden
    }
    TEMA {
        uuid id PK
        uuid modulo_id FK
        string nombre
        bool activa
        int orden
    }
    SUBTEMA {
        uuid id PK
        uuid tema_id FK
        string nombre
        bool activa
        int orden
    }
    ESTIMULO {
        uuid id PK
        uuid tema_id FK
        string tipo "lectura|caso|imagen|grafico"
        string titulo
        text contenido "rico: párrafos numerados, notas al pie"
        string formato "markdown|html|latex"
        string imagen_url "nullable"
        bool activo
    }
    PREGUNTA {
        uuid id PK
        uuid tema_id FK
        uuid subtema_id FK "nullable"
        uuid estimulo_id FK "nullable - lectura/caso compartido"
        text enunciado "texto largo / enriquecido"
        string formato_enunciado "texto|markdown|latex|html"
        text descripcion
        string imagen_url "nullable"
        string video_url "nullable"
        text explicacion
        string formato_explicacion "texto|markdown|latex|html"
        text tip
        string dificultad "facil|media|dificil"
        string categoria
        int tiempo_estimado_seg
        int orden "dentro del estímulo"
        bool activa
    }
    OPCION {
        uuid id PK
        uuid pregunta_id FK
        string letra "A|B|C|D"
        text contenido "texto/fórmula largos"
        string formato "texto|markdown|latex|html"
        string imagen_url "nullable - opción con diagrama"
        bool es_correcta
    }
    MATERIAL_APOYO {
        uuid id PK
        uuid pregunta_id FK
        string tipo "video|pdf|imagen|enlace"
        string url
    }
    EVALUACION_CONFIG {
        uuid id PK
        string tipo "tema|modulo|materia|general|simulador"
        int num_preguntas
        int tiempo_limite_seg "nullable"
        string modo_feedback "inmediato|final"
        bool activa
    }
    INTENTO {
        uuid id PK
        uuid usuario_id FK
        uuid evaluacion_config_id FK
        decimal calificacion
        int tiempo_invertido_seg
        datetime iniciado_en
        datetime finalizado_en
    }
    RESPUESTA_INTENTO {
        uuid id PK
        uuid intento_id FK
        uuid pregunta_id FK
        uuid opcion_id FK
        bool correcta
    }
    AUDITORIA {
        uuid id PK
        uuid actor_usuario_id FK
        string accion
        string entidad
        string origen_ip
        datetime fecha_hora
    }
```

## Notas del modelo

- **Borrado lógico** vía `activa` en catálogo (materia/módulo/tema/subtema/pregunta) para preservar historial ([RN-006](../06-reglas-negocio/reglas-principales.md)).
- **Idempotencia de pagos**: `EVENTO_PAGO.payload_hash` único evita doble procesamiento de webhooks ([RN-021](../06-reglas-negocio/reglas-principales.md)).
- **Sesión única**: regla de "una `SESION.activa` por usuario" se refuerza en backend + Redis ([RN-030](../06-reglas-negocio/reglas-principales.md)).
- **Pregunta**: exactamente 4 `OPCION` y una con `es_correcta = true` ([RN-003](../06-reglas-negocio/reglas-principales.md), [RN-004](../06-reglas-negocio/reglas-principales.md)).
- **Contenido enriquecido**: `enunciado`, `OPCION.contenido`, `explicacion` y `ESTIMULO.contenido` admiten `formato` (`texto|markdown|latex|html`) para renderizar **fórmulas matemáticas/químicas (LaTeX/MathML)** e imágenes por opción. Son `text`, no `varchar`, para soportar contenido largo ([RF-033](../05-requerimientos/RF-033-contenido-reactivo.md)).
- **Estímulo compartido**: un `ESTIMULO` (lectura, caso, imagen o gráfico) agrupa varias `PREGUNTA` mediante `estimulo_id`; modela comprensión lectora y casos con un texto base único reutilizado por N reactivos. `PREGUNTA.orden` ordena los reactivos dentro del estímulo.
- **Materias data-driven**: agregar una fila en `MATERIA` basta; sin cambios de código ([RN-001](../06-reglas-negocio/reglas-principales.md)).
- **Catálogo inicial de MATERIA**: Química, Matemáticas, Competencias escritas, Biología, Competencia lectora, Historia, Física, Español / Literatura, Filosofía, Geografía, Historia Universal.

## Índices recomendados (preliminar)

| Tabla | Índice | Motivo |
|-------|--------|--------|
| USUARIO | `email` (único) | Login y verificación de duplicados. |
| SUSCRIPCION | `(usuario_id, estado)`, `fin_vigencia` | Consulta de acceso y job de vencimiento. |
| PAGO | `ref_pasarela` (único) | Conciliación con la pasarela. |
| EVENTO_PAGO | `payload_hash` (único) | Idempotencia de webhooks. |
| SESION | `(usuario_id, activa)` | Resolver sesión única. |
| INTENTO | `(usuario_id, evaluacion_config_id)`, `finalizado_en` | Historial y métricas. |
| RESPUESTA_INTENTO | `(intento_id)`, `(pregunta_id)` | Cálculo de fortalezas/debilidades. |
| PREGUNTA | `(tema_id, activa)`, `(subtema_id, activa)`, `(estimulo_id, orden)` | Armado de evaluaciones y reactivos de una lectura. |
| ESTIMULO | `(tema_id, activo)` | Selección de lecturas/casos por tema. |
| REFERIDO | `(codigo_referido_id, estado)` | Conteo de referidos efectivos. |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/09-diagramas/03-modelo-datos-erd.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
