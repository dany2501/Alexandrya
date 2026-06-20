-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: 99_drop_all.sql  —  TEARDOWN: elimina TODO el esquema.
-- ⚠️  DESTRUCTIVO. Borra tablas y datos. Úsese solo en entornos
--     desechables (dev/test). NUNCA en producción.
-- Uso:  psql -h <host> -U <user> -d <db> -v ON_ERROR_STOP=1 -f 99_drop_all.sql
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

\set ON_ERROR_STOP on

-- Salvaguarda: descomenta para abortar si la BD parece de producción.
-- DO $$ BEGIN
--   IF current_database() NOT IN ('alexandrya_dev','alexandrya_test') THEN
--     RAISE EXCEPTION 'Teardown bloqueado en BD "%": no es dev/test', current_database();
--   END IF;
-- END $$;

BEGIN;

-- Vistas primero.
DROP VIEW IF EXISTS v_desempeno_tema;

-- Tablas en orden inverso de dependencias (CASCADE cubre FKs residuales).
DROP TABLE IF EXISTS anuncios_acuse        CASCADE;
DROP TABLE IF EXISTS anuncios              CASCADE;
DROP TABLE IF EXISTS auditoria             CASCADE;
DROP TABLE IF EXISTS consentimientos       CASCADE;
DROP TABLE IF EXISTS documentos_legales    CASCADE;
DROP TABLE IF EXISTS importaciones         CASCADE;
DROP TABLE IF EXISTS notificaciones        CASCADE;
DROP TABLE IF EXISTS beneficios_otorgados  CASCADE;
DROP TABLE IF EXISTS referidos             CASCADE;
DROP TABLE IF EXISTS codigos_referido      CASCADE;
DROP TABLE IF EXISTS accesos_contenido     CASCADE;
DROP TABLE IF EXISTS materiales            CASCADE;
DROP TABLE IF EXISTS respuestas_intento    CASCADE;
DROP TABLE IF EXISTS intentos              CASCADE;
DROP TABLE IF EXISTS evaluacion_config     CASCADE;
DROP TABLE IF EXISTS opciones              CASCADE;
DROP TABLE IF EXISTS preguntas             CASCADE;
DROP TABLE IF EXISTS estimulos             CASCADE;
DROP TABLE IF EXISTS subtemas              CASCADE;
DROP TABLE IF EXISTS temas                 CASCADE;
DROP TABLE IF EXISTS modulos               CASCADE;
DROP TABLE IF EXISTS materias              CASCADE;
DROP TABLE IF EXISTS eventos_pago          CASCADE;
DROP TABLE IF EXISTS pagos                 CASCADE;
DROP TABLE IF EXISTS suscripciones         CASCADE;
DROP TABLE IF EXISTS planes                CASCADE;
DROP TABLE IF EXISTS tokens_reset          CASCADE;
DROP TABLE IF EXISTS audit_accesos         CASCADE;
DROP TABLE IF EXISTS acceso_historial      CASCADE;
DROP TABLE IF EXISTS sesiones              CASCADE;
DROP TABLE IF EXISTS mfa_codigos_respaldo  CASCADE;
DROP TABLE IF EXISTS mfa_secretos          CASCADE;
DROP TABLE IF EXISTS tokens_verificacion   CASCADE;
DROP TABLE IF EXISTS usuarios              CASCADE;
DROP TABLE IF EXISTS roles                 CASCADE;

COMMIT;

\echo '== Esquema Alexandrya eliminado =='
