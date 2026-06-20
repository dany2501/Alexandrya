-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 12_anuncios.sql
-- Módulo:  MOD-12 Anuncios
-- Origen:  RF-120 (anuncios y acuse de lectura)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Anuncios editoriales in-app (RF-120 / RN-120-01..03).
CREATE TABLE IF NOT EXISTS anuncios (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo         VARCHAR(80) NOT NULL,
  cuerpo         TEXT NOT NULL,
  tipo           VARCHAR(20) NOT NULL,   -- informativo|mantenimiento|promocion|critico
  canal          VARCHAR(10) NOT NULL,   -- banner|modal|centro
  audiencia      VARCHAR(20) NOT NULL,   -- todos|activos|vencidos|segmento
  cta_texto      VARCHAR(40),
  cta_url        TEXT,
  inicio         TIMESTAMP NOT NULL,
  fin            TIMESTAMP NOT NULL,
  requiere_acuse BOOLEAN DEFAULT false,
  estado         VARCHAR(15) NOT NULL DEFAULT 'borrador', -- borrador|programado|publicado|expirado|despublicado
  creado_por     UUID NOT NULL REFERENCES usuarios(id),
  creado_en      TIMESTAMP DEFAULT now(),
  CONSTRAINT chk_anuncio_vigencia CHECK (fin > inicio)    -- V-120-01
);
CREATE INDEX IF NOT EXISTS idx_anuncios_vigencia ON anuncios(estado, inicio, fin);

-- Acuse de lectura para anuncios críticos / de un solo despliegue (RN-120-03).
CREATE TABLE IF NOT EXISTS anuncios_acuse (
  anuncio_id UUID NOT NULL REFERENCES anuncios(id) ON DELETE CASCADE,
  usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  visto_en   TIMESTAMP DEFAULT now(),
  PRIMARY KEY (anuncio_id, usuario_id)
);
