-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 07_referidos.sql
-- Módulo:  MOD-08 Referidos
-- Origen:  RF-070..073 (código único, hasta 3, beneficios idempotentes)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Código de referido único e inmutable por alumno (RN-045).
CREATE TABLE IF NOT EXISTS codigos_referido (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL UNIQUE REFERENCES usuarios(id),
  codigo     VARCHAR(12) NOT NULL UNIQUE
);

-- Referidos: hasta 3 por alumno (RN-040); invitado único (RN-041..044).
CREATE TABLE IF NOT EXISTS referidos (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo_referido_id  UUID NOT NULL REFERENCES codigos_referido(id),
  usuario_invitado_id UUID NOT NULL UNIQUE REFERENCES usuarios(id),
  posicion            INT CHECK (posicion BETWEEN 1 AND 3),
  estado              VARCHAR(12) DEFAULT 'registrado'
                      CHECK (estado IN ('registrado','efectivo','expirado')),
  creado_en           TIMESTAMP DEFAULT now()
);

-- Beneficios otorgados: uno por referido efectivo (idempotencia RN-043).
CREATE TABLE IF NOT EXISTS beneficios_otorgados (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referido_id    UUID NOT NULL UNIQUE REFERENCES referidos(id),  -- idempotencia
  tipo_beneficio VARCHAR(40) NOT NULL,
  otorgado_en    TIMESTAMP DEFAULT now()
);
