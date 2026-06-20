# Diagrama — Flujos de negocio

Secuencias y máquinas de estado de los procesos críticos.

## 1. Registro + pago + activación de suscripción

```mermaid
sequenceDiagram
    actor V as Visitante
    participant W as Web (Next.js)
    participant API as API (NestJS)
    participant PAY as Pasarela de pago
    participant MQ as RabbitMQ
    participant MAIL as Correo

    V->>W: Registro (correo + contraseña)
    W->>API: POST /auth/register
    API->>MQ: evento "registro"
    MQ->>MAIL: Correo de verificación
    V->>API: GET /auth/verify (enlace)
    API-->>V: Cuenta verificada

    V->>W: Elige plan y paga
    W->>API: POST /checkout
    API->>PAY: Crea sesión de pago
    PAY-->>V: Flujo de pago (tarjeta/SPEI)
    PAY-->>API: Webhook pago confirmado
    API->>API: Idempotencia (RN-021) + activa suscripción 365d (RN-011)
    API->>MQ: evento "pago_exitoso"
    MQ->>MAIL: Correo de pago exitoso
    API-->>W: Suscripción activa
```

## 2. Login con control de sesión única

```mermaid
sequenceDiagram
    actor AL as Alumno
    participant CLI as Cliente (Web o App)
    participant API as API
    participant R as Redis
    participant MQ as RabbitMQ
    participant MAIL as Correo

    AL->>CLI: Inicia sesión
    CLI->>API: POST /auth/login (+ MFA si aplica)
    API->>R: ¿Existe sesión activa previa?
    alt Hay sesión previa
        API->>R: Invalida sesión anterior (RN-031)
    end
    API->>R: Registra sesión actual como única
    API->>API: Emite JWT + refresh token
    API->>MQ: evento "nuevo_acceso" (IP, dispositivo)
    MQ->>MAIL: Correo de aviso de acceso (RN-034)
    API-->>CLI: Tokens + sesión activa
    Note over CLI,API: El dispositivo anterior queda expulsado al usar su token
```

## 3. Realizar una evaluación

```mermaid
sequenceDiagram
    actor AL as Alumno
    participant CLI as Cliente
    participant API as API
    participant DB as PostgreSQL

    AL->>CLI: Selecciona evaluación (tema/módulo/.../simulador)
    CLI->>API: GET /evaluaciones/{config}
    API->>API: Valida suscripción activa (RN-010)
    API->>DB: Arma preguntas según config (RN-050)
    API-->>CLI: Set de preguntas (sin respuesta correcta)
    loop Por cada pregunta
        AL->>CLI: Responde opción
    end
    CLI->>API: POST /intentos (respuestas)
    API->>API: Califica (RN-054) y, si simulador, valida tiempo (RN-051)
    API->>DB: Guarda intento + respuestas (RF-044)
    API-->>CLI: Calificación + retroalimentación + explicaciones (RF-043)
```

## 4. Estados de la suscripción

```mermaid
stateDiagram-v2
    [*] --> SinSuscripcion
    SinSuscripcion --> Activa: Pago confirmado (RN-020)
    Activa --> Activa: Renovación anticipada (extiende, RN-013)
    Activa --> Vencida: Llega fin_vigencia (RN-012)
    Vencida --> Activa: Renovación tardía (nueva vigencia 365d, RN-014)
    Activa --> Cancelada: Cancelación / reembolso
    Cancelada --> Activa: Nuevo pago confirmado
    Vencida --> [*]
    Cancelada --> [*]
    note right of Vencida
        Cuenta y historial se conservan (RN-015);
        solo se bloquea el acceso al contenido.
    end note
```

## 5. Estados de un pago

```mermaid
stateDiagram-v2
    [*] --> Pendiente: Inicia checkout
    Pendiente --> Confirmado: Webhook OK (RN-020)
    Pendiente --> Fallido: Rechazo / timeout
    Confirmado --> Reembolsado: Reembolso
    Fallido --> [*]
    Reembolsado --> [*]
    Confirmado --> [*]
    note right of Confirmado
        Solo Confirmado activa/extiende
        la suscripción (RN-016).
    end note
```

## 6. Referido efectivo y otorgamiento de beneficio

```mermaid
sequenceDiagram
    actor A as Alumno (refiere)
    actor B as Invitado
    participant API as API
    participant DB as PostgreSQL

    A->>API: Comparte código de referido (RN-045)
    B->>API: Se registra con el código
    API->>API: ¿Auto-referido? (RN-044) -> rechaza si aplica
    API->>DB: Crea REFERIDO estado=registrado
    B->>API: Paga su suscripción
    API->>API: ¿Posición <= 3? (RN-040)
    alt Dentro del límite
        API->>DB: REFERIDO -> efectivo (RN-041)
        API->>DB: Otorga beneficio configurado, idempotente (RN-042, RN-043)
    else Excede el límite
        API->>API: No otorga beneficio adicional
    end
```

## 7. Vencimiento y reporte semanal (jobs programados)

```mermaid
sequenceDiagram
    participant CRON as Scheduler
    participant API as API / Worker
    participant DB as PostgreSQL
    participant MQ as RabbitMQ
    participant MAIL as Correo

    CRON->>API: Job diario de vigencias
    API->>DB: Suscripciones por vencer / vencidas
    API->>MQ: eventos "por_vencer" / "vencida"
    MQ->>MAIL: Correos de aviso (RF-026)
    API->>DB: Marca vencidas y suspende acceso (RN-012)

    CRON->>API: Job semanal de avance
    API->>DB: Calcula avance + recomendaciones por alumno
    API->>MQ: evento "reporte_semanal"
    MQ->>MAIL: Correo con estadísticas (RF-091)
```

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/09-diagramas/04-flujos.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
