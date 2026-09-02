-- Script maestro del proyecto de tickets
-- Ejecuta todos los scripts en el orden de dependencias.

SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

-- El maestro usa la conexión SYS AS SYSDBA abierta por SQL*Plus/SQLcl.
-- Ejemplo: CONNECT SYS/<password>@192.168.80.178:1521/FREEpdb1 AS SYSDBA

-- 001-004: estructura base
@@estructura/001-crea-tablespaces.sql

@@estructura/002-crea-usuario-tickets.sql

@@estructura/003-crea-tablas.sql

@@estructura/004-crea-triggers.sql

-- 005-020: especificaciones CRUD
@@crud/specs/005-crea-tk_areas-crud-spec.sql
@@crud/specs/006-crea-tk_base_conocimientos-crud-spec.sql
@@crud/specs/007-crea-tk_cat_estados-crud-spec.sql
@@crud/specs/008-crea-tk_cat_prioridades-crud-spec.sql
@@crud/specs/009-crea-tk_categorias-crud-spec.sql
@@crud/specs/010-crea-tk_comentarios-crud-spec.sql
@@crud/specs/011-crea-tk_encuestas-crud-spec.sql
@@crud/specs/012-crea-tk_roles-crud-spec.sql
@@crud/specs/013-crea-tk_ticket_adjuntos-crud-spec.sql
@@crud/specs/014-crea-tk_tickets-crud-spec.sql
@@crud/specs/015-crea-tk_tickets_historial-crud-spec.sql
@@crud/specs/016-crea-tk_tipos_activos-crud-spec.sql
@@crud/specs/017-crea-tk_usuarios-crud-spec.sql
@@crud/specs/018-crea-tk_usuarios_roles-crud-spec.sql
@@crud/specs/019-crea-tk_activos-crud-spec.sql
@@crud/specs/020-crea-tk_activos_tickets-crud-spec.sql

-- 005-020: cuerpos CRUD
@@crud/bodies/005-crea-tk_areas-crud-body.sql
@@crud/bodies/006-crea-tk_base_conocimientos-crud-body.sql
@@crud/bodies/007-crea-tk_cat_estados-crud-body.sql
@@crud/bodies/008-crea-tk_cat_prioridades-crud-body.sql
@@crud/bodies/009-crea-tk_categorias-crud-body.sql
@@crud/bodies/010-crea-tk_comentarios-crud-body.sql
@@crud/bodies/011-crea-tk_encuestas-crud-body.sql
@@crud/bodies/012-crea-tk_roles-crud-body.sql
@@crud/bodies/013-crea-tk_ticket_adjuntos-crud-body.sql
@@crud/bodies/014-crea-tk_tickets-crud-body.sql
@@crud/bodies/015-crea-tk_tickets_historial-crud-body.sql
@@crud/bodies/016-crea-tk_tipos_activos-crud-body.sql
@@crud/bodies/017-crea-tk_usuarios-crud-body.sql
@@crud/bodies/018-crea-tk_usuarios_roles-crud-body.sql
@@crud/bodies/019-crea-tk_activos-crud-body.sql
@@crud/bodies/020-crea-tk_activos_tickets-crud-body.sql

-- 021-027: datos semilla
@@semillas/021-seed-tk-areas.sql
@@semillas/022-seed-tk-categorias.sql
@@semillas/023-seed-tk-cat-estados.sql
@@semillas/024-seed-tk-cat-prioridades.sql
@@semillas/025-seed-tk-roles.sql
@@semillas/026-seed-tk-tipos-activos.sql
@@semillas/027-seed-usuarios-roles.sql

-- 028: reglas de negocio
@@negocio/028-crea-paquete-negocio-spec.sql
@@negocio/028-crea-paquete-negocio-body.sql

EXIT
