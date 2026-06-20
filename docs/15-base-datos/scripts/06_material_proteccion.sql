-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 06_material_proteccion.sql
-- Módulo:  MOD-07 Material y medios · Protección de contenido
-- Origen:  RF-060 (materiales), RF-110 (accesos / detección de abuso)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Material de apoyo / medios (RF-060). Sin URL pública: storage_key en S3.
CREATE TABLE IF NOT EXISTS materiales (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pregunta_id UUID REFERENCES preguntas(id),
  tema_id     UUID REFERENCES temas(id),
  tipo        VARCHAR(12) NOT NULL CHECK (tipo IN ('video','pdf','imagen','enlace')),
  storage_key VARCHAR(255),     -- clave en S3 (no URL pública)
  url_interna VARCHAR(255),     -- para tipo 'enlace'
  activo      BOOLEAN DEFAULT TRUE,
  creado_en   TIMESTAMP DEFAULT now()
);

-- Registro de accesos a contenido para detección de abuso/scraping (RF-110).
CREATE TABLE IF NOT EXISTS accesos_contenido (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuarios(id),
  media_id   UUID,
  ip         INET,
  fecha_hora TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_acc_cont_usuario_tiempo
  ON accesos_contenido(usuario_id, fecha_hora);
