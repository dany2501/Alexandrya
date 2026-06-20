-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 02_sesiones_seguridad.sql
-- Módulo:  MOD-02 Identidad y acceso · MOD-11 Seguridad
-- Origen:  RF-001A (sesiones, historial, audit), RF-080 (sesión única),
--          RF-001B (recuperación de contraseña)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Sesiones (RF-001A). Sesión única gestionada con índice parcial (RF-080).
CREATE TABLE IF NOT EXISTS sesiones (
  id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id           UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  refresh_token_hash   VARCHAR(128) NOT NULL UNIQUE,
  access_token_expira  TIMESTAMP NOT NULL,
  refresh_token_expira TIMESTAMP NOT NULL,
  ip_address           INET,
  user_agent           TEXT,
  ubicacion_aprox      VARCHAR(120),
  activa               BOOLEAN NOT NULL DEFAULT TRUE,  -- una sola TRUE por usuario
  creada_en            TIMESTAMP DEFAULT now(),
  invalidada_en        TIMESTAMP
);
-- Garantiza UNA sola sesión activa por usuario (RF-080 / RN-030/031).
CREATE UNIQUE INDEX IF NOT EXISTS uniq_sesion_activa ON sesiones(usuario_id) WHERE activa;
CREATE INDEX IF NOT EXISTS idx_sesiones_refresh ON sesiones(refresh_token_hash);
-- Nota: el cierre por inactividad (10 min, RN-035/036) marca activa=false
-- e invalidada_en; se gestiona en backend + Redis, no requiere DDL extra.

-- Historial de accesos (RF-001A / RF-082).
CREATE TABLE IF NOT EXISTS acceso_historial (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id      UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  ip_address      INET NOT NULL,
  user_agent      TEXT,
  ubicacion_aprox VARCHAR(120),
  fecha_hora      TIMESTAMP DEFAULT now()
);

-- Auditoría de accesos / autenticación (RF-001A).
CREATE TABLE IF NOT EXISTS audit_accesos (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id  UUID REFERENCES usuarios(id) ON DELETE SET NULL,
  accion      VARCHAR(40) NOT NULL,    -- LOGIN, LOGOUT, LOGIN_FALLIDO, TOKEN_REFRESH, MFA_FALLIDO
  resultado   VARCHAR(20) NOT NULL,    -- EXITO, FALLO
  razon_fallo VARCHAR(255),
  ip_address  INET NOT NULL,
  fecha_hora  TIMESTAMP DEFAULT now()
);

-- Tokens de recuperación de contraseña (RF-001B). Un solo uso, 1h.
CREATE TABLE IF NOT EXISTS tokens_reset (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  token_hash VARCHAR(128) NOT NULL UNIQUE,
  expira     TIMESTAMP NOT NULL,       -- now() + 1h
  usado_en   TIMESTAMP,
  creado_en  TIMESTAMP DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_reset_usuario ON tokens_reset(usuario_id) WHERE usado_en IS NULL;
