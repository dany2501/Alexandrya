-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 04_catalogo_contenido.sql
-- Módulo:  MOD-04 Catálogo de contenido
-- Origen:  RF-030 (jerarquía), RF-033 (estímulos + contenido enriquecido),
--          RF-032/034 (preguntas y opciones)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Jerarquía: materia -> módulo -> tema -> subtema (RF-030 / RN-002).
CREATE TABLE IF NOT EXISTS materias (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(120) NOT NULL,
  activa BOOLEAN NOT NULL DEFAULT TRUE,
  orden  INT DEFAULT 0
);
CREATE TABLE IF NOT EXISTS modulos (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  materia_id UUID NOT NULL REFERENCES materias(id),
  nombre     VARCHAR(120) NOT NULL,
  activa     BOOLEAN DEFAULT TRUE,
  orden      INT DEFAULT 0
);
CREATE TABLE IF NOT EXISTS temas (
  id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  modulo_id UUID NOT NULL REFERENCES modulos(id),
  nombre    VARCHAR(120) NOT NULL,
  activa    BOOLEAN DEFAULT TRUE,
  orden     INT DEFAULT 0
);
CREATE TABLE IF NOT EXISTS subtemas (
  id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tema_id UUID NOT NULL REFERENCES temas(id),
  nombre  VARCHAR(120) NOT NULL,
  activa  BOOLEAN DEFAULT TRUE,
  orden   INT DEFAULT 0
);

-- Estímulos: lecturas/casos/imágenes compartidos por 1..N reactivos (RF-033 / RN-008).
CREATE TABLE IF NOT EXISTS estimulos (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tema_id    UUID NOT NULL REFERENCES temas(id),
  tipo       VARCHAR(12) NOT NULL CHECK (tipo IN ('lectura','caso','imagen','grafico')),
  titulo     VARCHAR(200),
  contenido  TEXT,                 -- párrafos numerados, notas al pie, etc.
  formato    VARCHAR(10) NOT NULL DEFAULT 'markdown' CHECK (formato IN ('markdown','html','latex')),
  imagen_url VARCHAR(255),
  activo     BOOLEAN NOT NULL DEFAULT TRUE,
  creado_en  TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_estimulos_tema ON estimulos(tema_id, activo);

-- ---------------------------------------------------------------------
-- Banco de preguntas — estado FINAL consolidado.
-- Base documentada en RF-030 §6.3; extensión (estímulos, formatos enriquecidos,
-- orden) en RF-033 §6.2. Aquí se fusionan en su forma final.
-- ---------------------------------------------------------------------

-- Preguntas / reactivos (RF-032/033/034). Estado final con campos de RF-033.
CREATE TABLE IF NOT EXISTS preguntas (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tema_id             UUID REFERENCES temas(id),
  subtema_id          UUID REFERENCES subtemas(id),
  estimulo_id         UUID REFERENCES estimulos(id),         -- RF-033
  enunciado           TEXT NOT NULL,
  descripcion         TEXT,
  formato_enunciado   VARCHAR(10) NOT NULL DEFAULT 'texto'
                      CHECK (formato_enunciado IN ('texto','markdown','latex','html')),
  explicacion         TEXT,
  formato_explicacion VARCHAR(10) NOT NULL DEFAULT 'texto'
                      CHECK (formato_explicacion IN ('texto','markdown','latex','html')),
  tip                 TEXT,
  dificultad          VARCHAR(10) CHECK (dificultad IN ('facil','media','dificil')),
  tiempo_estimado_seg INT,
  orden               INT DEFAULT 0,                          -- orden dentro del estímulo
  activa              BOOLEAN NOT NULL DEFAULT TRUE,          -- borrado lógico (RN-006)
  creado_en           TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_preguntas_tema ON preguntas(tema_id, activa);

-- Opciones de respuesta (RF-034). Exactamente 4 (A-D), una correcta (RN-003).
-- Estado final con campos de RF-033 (contenido enriquecido).
CREATE TABLE IF NOT EXISTS opciones (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pregunta_id UUID NOT NULL REFERENCES preguntas(id) ON DELETE CASCADE,
  etiqueta    CHAR(1) CHECK (etiqueta IN ('A','B','C','D')),
  contenido   TEXT NOT NULL,
  formato     VARCHAR(10) NOT NULL DEFAULT 'texto'
              CHECK (formato IN ('texto','markdown','latex','html')),
  imagen_url  VARCHAR(255),
  es_correcta BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE INDEX IF NOT EXISTS idx_opciones_pregunta ON opciones(pregunta_id);
