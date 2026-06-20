-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 01_roles_usuarios.sql
-- Módulo:  MOD-02 Identidad y acceso · MOD-10/11 (roles, seguridad)
-- Origen:  RF-100 (roles), RF-001 (usuarios, verificación), RF-016 (MFA)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- Roles (RF-100). Debe existir antes de 'usuarios' (FK rol_id).
CREATE TABLE IF NOT EXISTS roles (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(20) NOT NULL UNIQUE
         CHECK (nombre IN ('admin','editor','soporte','alumno'))
);

-- Usuarios (RF-001). Incluye columna MFA fusionada desde RF-016.
CREATE TABLE IF NOT EXISTS usuarios (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email            VARCHAR(100) NOT NULL UNIQUE,
  password_hash    VARCHAR(128) NOT NULL,            -- BCrypt; nunca texto plano (RN-071)
  nombre           VARCHAR(120),
  email_verificado BOOLEAN NOT NULL DEFAULT FALSE,
  estado           VARCHAR(24) NOT NULL DEFAULT 'VERIFICADA_PENDIENTE',
  rol_id           UUID NOT NULL REFERENCES roles(id),
  mfa_habilitado   BOOLEAN NOT NULL DEFAULT FALSE,   -- RF-016
  creado_en        TIMESTAMP DEFAULT now(),
  CONSTRAINT chk_estado CHECK (estado IN
    ('VERIFICADA_PENDIENTE','ACTIVA','VENCIDA','SUSPENDIDA'))
);
-- Unicidad case-insensitive del correo (RF-001).
CREATE UNIQUE INDEX IF NOT EXISTS uniq_usuarios_email ON usuarios(lower(email));

-- Verificación de correo (RF-001 / RF-011).
CREATE TABLE IF NOT EXISTS tokens_verificacion (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  token_hash VARCHAR(128) NOT NULL UNIQUE,
  expira     TIMESTAMP NOT NULL,
  usado_en   TIMESTAMP
);

-- MFA opcional (RF-016).
CREATE TABLE IF NOT EXISTS mfa_secretos (
  usuario_id      UUID PRIMARY KEY REFERENCES usuarios(id) ON DELETE CASCADE,
  secreto_cifrado VARCHAR(255) NOT NULL,   -- TOTP secret cifrado en reposo
  activado_en     TIMESTAMP
);
CREATE TABLE IF NOT EXISTS mfa_codigos_respaldo (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id  UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  codigo_hash VARCHAR(128) NOT NULL,
  usado_en    TIMESTAMP
);
