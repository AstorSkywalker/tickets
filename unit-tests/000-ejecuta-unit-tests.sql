-- Script maestro de pruebas unitarias
-- Ejecuta todas las pruebas disponibles en orden.

SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

@@001-test-tk-areas-crud.sql
@@002-test-tk-tickets-negocio.sql
@@003-test-tk-tickets-negocio-reglas.sql
@@004-test-tk-tickets-negocio-operaciones.sql
@@005-test-tk-categorias-crud.sql

EXIT
