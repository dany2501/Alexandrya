-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 11_auditoria.sql
-- Módulo:  MOD-10/11 Administración, Seguridad y auditoría
-- Origen:  RF-100 (auditoría de acciones), RNF-004 (registro inmutable)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Auditoría general de acciones sensibles (RF-100 / RNF-004 / RN-072).
CREATE TABLE IF NOT EXISTS auditoria (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_usuario_id UUID REFERENCES usuarios(id),
  accion           VARCHAR(60) NOT NULL,
  entidad          VARCHAR(40),
  entidad_id       UUID,
  origen_ip        INET,
  fecha_hora       TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_auditoria_actor ON auditoria(actor_usuario_id, fecha_hora);
