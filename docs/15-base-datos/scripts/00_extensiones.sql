-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 00_extensiones.sql
-- Propósito: extensiones requeridas antes de crear el esquema.
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

-- gen_random_uuid(): nativo desde PostgreSQL 13+. En versiones previas
-- lo provee pgcrypto. Se habilita por compatibilidad.
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- (opcional) búsqueda case-insensitive / acentos para catálogos:
-- CREATE EXTENSION IF NOT EXISTS unaccent;
