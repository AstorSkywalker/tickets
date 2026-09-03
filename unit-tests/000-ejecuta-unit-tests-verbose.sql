-- Script maestro de pruebas unitarias (modo verbose).
-- Ejecuta todas las pruebas mostrando el detalle de cada asercion.

SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE
ACCEPT DB_USER CHAR DEFAULT TICKETS PROMPT 'Usuario [TICKETS]: '
ACCEPT DB_PASSWORD CHAR DEFAULT Tickets123 HIDE PROMPT 'Password [Tickets123]: '
ACCEPT DB_CONNECT CHAR DEFAULT '//192.168.0.17:1521/freepdb1' PROMPT 'EZ Connect [//192.168.0.17:1521/freepdb1]: '

@@001-test-tk-areas-crud.sql
@@002-test-tk-tickets-negocio.sql
@@003-test-tk-tickets-negocio-reglas.sql
@@004-test-tk-tickets-negocio-operaciones.sql
@@005-test-tk-categorias-crud.sql
@@006-test-tk-base-conocimientos-crud.sql
@@007-test-tk-cat-estados-crud.sql
@@008-test-tk-cat-prioridades-crud.sql
@@009-test-tk-comentarios-crud.sql
@@010-test-tk-encuestas-crud.sql
@@011-test-tk-roles-crud.sql
@@012-test-tk-usuarios-crud.sql
@@013-test-tk-usuarios-roles-crud.sql
@@015-test-tk-tickets-crud.sql
@@014-test-tk-ticket-adjuntos-crud.sql
@@016-test-tk-tickets-historial-crud.sql
@@017-test-tk-tipos-activos-crud.sql
@@018-test-tk-activos-crud.sql
@@019-test-tk-activos-tickets-crud.sql

EXIT
