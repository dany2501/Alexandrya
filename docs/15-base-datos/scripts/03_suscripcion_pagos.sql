-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 03_suscripcion_pagos.sql
-- Módulo:  MOD-03 Suscripción y pagos
-- Origen:  RF-002 (planes), RF-024 (suscripciones), RF-020 (pagos),
--          RF-023 (eventos de pago / webhooks idempotentes)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Planes (RF-002).
CREATE TABLE IF NOT EXISTS planes (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre        VARCHAR(120) NOT NULL,
  precio        NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
  moneda        CHAR(3) NOT NULL DEFAULT 'MXN',
  duracion_dias INT NOT NULL DEFAULT 365,
  beneficios    JSONB NOT NULL DEFAULT '[]',
  activo        BOOLEAN NOT NULL DEFAULT TRUE,
  orden         INT DEFAULT 0
);

-- Suscripciones (RF-024). Vigencia 1 año (RN-011..016).
CREATE TABLE IF NOT EXISTS suscripciones (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id            UUID NOT NULL REFERENCES usuarios(id),
  plan_id               UUID NOT NULL REFERENCES planes(id),
  estado                VARCHAR(16) NOT NULL DEFAULT 'activa'
                        CHECK (estado IN ('activa','vencida','cancelada')),
  inicio_vigencia       TIMESTAMP NOT NULL,
  fin_vigencia          TIMESTAMP NOT NULL,
  auto_renovacion       BOOLEAN NOT NULL DEFAULT FALSE,
  metodo_recurrente_ref VARCHAR(120),   -- token de la pasarela (no datos de tarjeta)
  creada_en             TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_subs_usuario_estado ON suscripciones(usuario_id, estado);
CREATE INDEX IF NOT EXISTS idx_subs_fin ON suscripciones(fin_vigencia);

-- Pagos (RF-020). Idempotencia por idempotency_key y ref_pasarela.
CREATE TABLE IF NOT EXISTS pagos (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id      UUID NOT NULL REFERENCES usuarios(id),
  plan_id         UUID NOT NULL REFERENCES planes(id),
  suscripcion_id  UUID REFERENCES suscripciones(id),
  metodo          VARCHAR(16) NOT NULL CHECK (metodo IN ('tarjeta','spei')),
  monto           NUMERIC(10,2) NOT NULL,
  moneda          CHAR(3) NOT NULL DEFAULT 'MXN',
  estado          VARCHAR(16) NOT NULL DEFAULT 'pendiente'
                  CHECK (estado IN ('pendiente','confirmado','fallido','reembolsado')),
  ref_pasarela    VARCHAR(120) UNIQUE,
  idempotency_key VARCHAR(80) NOT NULL UNIQUE,
  creado_en       TIMESTAMP DEFAULT now()
);

-- Eventos de webhook de pago (RF-023). Idempotencia por payload_hash (ADR-006).
CREATE TABLE IF NOT EXISTS eventos_pago (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pago_id      UUID REFERENCES pagos(id),
  event_id     VARCHAR(120),
  tipo         VARCHAR(20) NOT NULL,
  payload_hash VARCHAR(128) NOT NULL UNIQUE,   -- idempotencia
  occurred_at  TIMESTAMP,
  recibido_en  TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_eventos_pago_pago ON eventos_pago(pago_id);
