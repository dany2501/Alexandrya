-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 90_seed.sql
-- Propósito: datos semilla mínimos para arrancar (roles obligatorios).
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Roles base (usuarios.rol_id es NOT NULL → deben existir antes de crear usuarios).
INSERT INTO roles (nombre) VALUES
  ('admin'), ('editor'), ('soporte'), ('alumno')
ON CONFLICT (nombre) DO NOTHING;

-- (opcional) Plan anual de ejemplo — ajustar precio real (RF-002).
-- INSERT INTO planes (nombre, precio, moneda, duracion_dias, beneficios, activo, orden)
-- VALUES ('Plan Anual Alexandrya', 0.00, 'MXN', 365, '[]', TRUE, 1)
-- ON CONFLICT DO NOTHING;
