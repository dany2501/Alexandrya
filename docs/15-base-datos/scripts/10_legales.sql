-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 10_legales.sql
-- Módulo:  MOD-01 Legal · Cumplimiento (datos personales)
-- Origen:  RF-003 (documentos legales y consentimientos)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Documentos legales versionados: un solo vigente por tipo (RF-003).
CREATE TABLE IF NOT EXISTS documentos_legales (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo           VARCHAR(20) NOT NULL
                 CHECK (tipo IN ('aviso_privacidad','terminos','politica_uso')),
  version        VARCHAR(20) NOT NULL,
  contenido_html TEXT NOT NULL,
  vigente_desde  TIMESTAMP NOT NULL,
  vigente        BOOLEAN NOT NULL DEFAULT FALSE,
  creado_en      TIMESTAMP DEFAULT now(),
  UNIQUE (tipo, version)
);
CREATE UNIQUE INDEX IF NOT EXISTS uniq_doc_vigente ON documentos_legales(tipo) WHERE vigente;

-- Consentimientos del usuario (RF-003 / RN-070, RNF-005).
CREATE TABLE IF NOT EXISTS consentimientos (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id   UUID NOT NULL REFERENCES usuarios(id),
  documento_id UUID NOT NULL REFERENCES documentos_legales(id),
  aceptado_en  TIMESTAMP DEFAULT now(),
  ip           INET
);
CREATE INDEX IF NOT EXISTS idx_consent_usuario ON consentimientos(usuario_id);
