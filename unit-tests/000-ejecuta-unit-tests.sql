-- Script maestro de pruebas unitarias (modo resumido).
-- Muestra ÃƒÂºnicamente el resultado de cada prueba; ante un error se detiene.

SET ECHO OFF
SET FEEDBACK OFF
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE
ACCEPT DB_USER CHAR DEFAULT TICKETS PROMPT 'Usuario [TICKETS]: '
ACCEPT DB_PASSWORD CHAR DEFAULT Tickets123 PROMPT 'Password [Tickets123]: '
ACCEPT DB_CONNECT CHAR DEFAULT '//192.168.0.17:1521/freepdb1' PROMPT 'EZ Connect [//192.168.0.17:1521/freepdb1]: '

PROMPT [01/19] areas ...
SET TERMOUT OFF
@@001-test-tk-areas-crud.sql
SET TERMOUT ON
PROMPT [OK] areas
PROMPT [02/19] tickets negocio ...
SET TERMOUT OFF
@@002-test-tk-tickets-negocio.sql
SET TERMOUT ON
PROMPT [OK] tickets negocio
PROMPT [03/19] reglas de negocio ...
SET TERMOUT OFF
@@003-test-tk-tickets-negocio-reglas.sql
SET TERMOUT ON
PROMPT [OK] reglas de negocio
PROMPT [04/19] operaciones de negocio ...
SET TERMOUT OFF
@@004-test-tk-tickets-negocio-operaciones.sql
SET TERMOUT ON
PROMPT [OK] operaciones de negocio
PROMPT [05/19] categorias ...
SET TERMOUT OFF
@@005-test-tk-categorias-crud.sql
SET TERMOUT ON
PROMPT [OK] categorias
PROMPT [06/19] base de conocimientos ...
SET TERMOUT OFF
@@006-test-tk-base-conocimientos-crud.sql
SET TERMOUT ON
PROMPT [OK] base de conocimientos
PROMPT [07/19] estados ...
SET TERMOUT OFF
@@007-test-tk-cat-estados-crud.sql
SET TERMOUT ON
PROMPT [OK] estados
PROMPT [08/19] prioridades ...
SET TERMOUT OFF
@@008-test-tk-cat-prioridades-crud.sql
SET TERMOUT ON
PROMPT [OK] prioridades
PROMPT [09/19] comentarios ...
SET TERMOUT OFF
@@009-test-tk-comentarios-crud.sql
SET TERMOUT ON
PROMPT [OK] comentarios
PROMPT [10/19] encuestas ...
SET TERMOUT OFF
@@010-test-tk-encuestas-crud.sql
SET TERMOUT ON
PROMPT [OK] encuestas
PROMPT [11/19] roles ...
SET TERMOUT OFF
@@011-test-tk-roles-crud.sql
SET TERMOUT ON
PROMPT [OK] roles
PROMPT [12/19] usuarios ...
SET TERMOUT OFF
@@012-test-tk-usuarios-crud.sql
SET TERMOUT ON
PROMPT [OK] usuarios
PROMPT [13/19] usuarios-roles ...
SET TERMOUT OFF
@@013-test-tk-usuarios-roles-crud.sql
SET TERMOUT ON
PROMPT [OK] usuarios-roles
PROMPT [14/19] tickets CRUD ...
SET TERMOUT OFF
@@015-test-tk-tickets-crud.sql
SET TERMOUT ON
PROMPT [OK] tickets CRUD
PROMPT [15/19] adjuntos ...
SET TERMOUT OFF
@@014-test-tk-ticket-adjuntos-crud.sql
SET TERMOUT ON
PROMPT [OK] adjuntos
PROMPT [16/19] historial ...
SET TERMOUT OFF
@@016-test-tk-tickets-historial-crud.sql
SET TERMOUT ON
PROMPT [OK] historial
PROMPT [17/19] tipos de activos ...
SET TERMOUT OFF
@@017-test-tk-tipos-activos-crud.sql
SET TERMOUT ON
PROMPT [OK] tipos de activos
PROMPT [18/19] activos ...
SET TERMOUT OFF
@@018-test-tk-activos-crud.sql
SET TERMOUT ON
PROMPT [OK] activos
PROMPT [19/19] activos-tickets ...
SET TERMOUT OFF
@@019-test-tk-activos-tickets-crud.sql
SET TERMOUT ON
PROMPT [OK] activos-tickets
PROMPT === TODAS LAS PRUEBAS PASARON ===

EXIT
