-- =====================================================================
-- Alexandrya · Base de datos (PostgreSQL)
-- Archivo: run_all.sql  —  ejecuta todo el esquema en el orden correcto.
-- Uso:  psql -h <host> -U <user> -d <db> -v ON_ERROR_STOP=1 -f run_all.sql
-- (ejecutar desde el directorio scripts/)
-- Versión documental: v0.3.0 · 2026-06-19
-- =====================================================================

\set ON_ERROR_STOP on

\echo '== 00 extensiones =='        \i 00_extensiones.sql
\echo '== 01 roles y usuarios =='   \i 01_roles_usuarios.sql
\echo '== 02 sesiones y seguridad ==' \i 02_sesiones_seguridad.sql
\echo '== 03 suscripción y pagos ==' \i 03_suscripcion_pagos.sql
\echo '== 04 catálogo y contenido ==' \i 04_catalogo_contenido.sql
\echo '== 05 evaluaciones =='        \i 05_evaluaciones.sql
\echo '== 06 material y protección ==' \i 06_material_proteccion.sql
\echo '== 07 referidos =='           \i 07_referidos.sql
\echo '== 08 notificaciones =='      \i 08_notificaciones.sql
\echo '== 09 importaciones =='       \i 09_importaciones.sql
\echo '== 10 legales =='             \i 10_legales.sql
\echo '== 11 auditoría =='           \i 11_auditoria.sql
\echo '== 12 anuncios =='            \i 12_anuncios.sql
\echo '== 90 seed =='                \i 90_seed.sql
\echo '== Esquema Alexandrya aplicado =='
