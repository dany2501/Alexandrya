-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 05_evaluaciones.sql
-- Módulo:  MOD-05 Evaluaciones · MOD-06 Progreso
-- Origen:  RF-040 (intentos/respuestas), RF-041/042 (config/simulador),
--          RF-050 (vista de desempeño)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- ---------------------------------------------------------------------
-- evaluacion_config — documentada en RF-040 §6.2 (RF-041/042, RN-050/051).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS evaluacion_config (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre            VARCHAR(120),
  tipo              VARCHAR(16) NOT NULL
                    CHECK (tipo IN ('tema','modulo','materia','general','simulador')),
  alcance_id        UUID,              -- id de materia/módulo/tema según 'tipo'
  num_preguntas     INT NOT NULL,
  tiempo_limite_seg INT,               -- NOT NULL en la práctica para 'simulador' (RF-042)
  modo_feedback     VARCHAR(16) NOT NULL DEFAULT 'al_final'
                    CHECK (modo_feedback IN ('inmediato','al_final')),
  activa            BOOLEAN NOT NULL DEFAULT TRUE,
  creada_en         TIMESTAMP DEFAULT now()
);

-- Intentos (RF-040). Columnas de simulador fusionadas desde RF-042.
CREATE TABLE IF NOT EXISTS intentos (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id           UUID NOT NULL REFERENCES usuarios(id),
  evaluacion_config_id UUID NOT NULL REFERENCES evaluacion_config(id),
  calificacion         NUMERIC(5,2),
  tiempo_invertido_seg INT,
  estado               VARCHAR(16) DEFAULT 'iniciado'
                       CHECK (estado IN ('iniciado','en_curso','finalizado','abandonado')),
  expira_en            TIMESTAMP,                 -- RF-042 (simulador con tiempo)
  cerrado_por_tiempo   BOOLEAN DEFAULT FALSE,     -- RF-042 / RN-051
  iniciado_en          TIMESTAMP DEFAULT now(),
  finalizado_en        TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_intentos_usuario ON intentos(usuario_id, finalizado_en);

-- Respuestas por intento (RF-040). Calificación binaria (RN-054).
CREATE TABLE IF NOT EXISTS respuestas_intento (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  intento_id  UUID NOT NULL REFERENCES intentos(id) ON DELETE CASCADE,
  pregunta_id UUID NOT NULL REFERENCES preguntas(id),
  opcion_id   UUID REFERENCES opciones(id),
  correcta    BOOLEAN
);

-- Vista de desempeño por tema (RF-050). Puede materializarse y refrescarse.
CREATE OR REPLACE VIEW v_desempeno_tema AS
SELECT i.usuario_id,
       p.tema_id,
       AVG(CASE WHEN ri.correcta THEN 1.0 ELSE 0.0 END) * 100 AS porcentaje,
       COUNT(*) AS respuestas
FROM intentos i
JOIN respuestas_intento ri ON ri.intento_id = i.id
JOIN preguntas p           ON p.id = ri.pregunta_id
WHERE i.estado = 'finalizado'
GROUP BY i.usuario_id, p.tema_id;
