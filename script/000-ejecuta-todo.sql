-- Script maestro del proyecto de tickets
-- Ejecuta todos los scripts en el orden de dependencias.

SET ECHO ON
SET FEEDBACK ON
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CONNECT SYS@192.168.80.178:1521/FREEpdb1 AS SYSDBA

@@001-crea-tablespaces.sql

@@002-crea-usuario-tickets.sql

@@003-crea-tablas.sql

@@004-crea-triggers.sql

@@005-crea-paquetes-spec.sql

@@006-crea-paquete-tk-areas-body.sql

EXIT
