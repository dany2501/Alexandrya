-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 09_importaciones.sql
-- Módulo:  MOD-04 Catálogo (carga masiva) · MOD-10 Admin
-- Origen:  RF-035 (carga masiva por Excel con reporte por fila)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Bitácora de importaciones por Excel (RF-035 / RNA-021).
CREATE TABLE IF NOT EXISTS importaciones (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id     UUID NOT NULL REFERENCES usuarios(id),
  archivo_nombre VARCHAR(255),
  total_filas    INT,
  importadas     INT,
  con_error      INT,
  reporte        JSONB,                     -- detalle de errores por fila
  estado         VARCHAR(16) DEFAULT 'procesando',
  creada_en      TIMESTAMP DEFAULT now()
);
