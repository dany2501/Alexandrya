-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 08_notificaciones.sql
-- Módulo:  MOD-09 Notificaciones
-- Origen:  RF-090 (cola/registro de notificaciones), NT/CT (sección 12)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Registro/cola de notificaciones transaccionales (RF-090).
-- 'tipo' = NT-001..013 ; 'plantilla' = CT-001..013 (incluye anuncio NT-013/CT-013).
CREATE TABLE IF NOT EXISTS notificaciones (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id   UUID REFERENCES usuarios(id),
  tipo         VARCHAR(12) NOT NULL,        -- NT-001..013
  plantilla    VARCHAR(12) NOT NULL,        -- CT-001..013
  destinatario VARCHAR(120) NOT NULL,
  estado       VARCHAR(16) DEFAULT 'encolada'
               CHECK (estado IN ('encolada','enviada','reintentando','fallida')),
  intentos     INT DEFAULT 0,
  payload      JSONB,
  proveedor_id VARCHAR(120),
  creada_en    TIMESTAMP DEFAULT now(),
  enviada_en   TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_notif_estado ON notificaciones(estado);
