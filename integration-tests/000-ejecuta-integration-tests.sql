-- Maestro de pruebas integrales.

SET ECHO OFF
SET FEEDBACK OFF
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE
ACCEPT DB_USER CHAR DEFAULT TICKETS PROMPT 'Usuario [TICKETS]: '
ACCEPT DB_PASSWORD CHAR DEFAULT Tickets123 PROMPT 'Password [Tickets123]: '
ACCEPT DB_CONNECT CHAR DEFAULT '//192.168.0.17:1521/freepdb1' PROMPT 'EZ Connect [//192.168.0.17:1521/freepdb1]: '

PROMPT [01/01] flujo completo de ticket ...
SET TERMOUT OFF
@@001-test-flujo-ticket-completo.sql
SET TERMOUT ON
PROMPT [OK] flujo completo de ticket
PROMPT [02/02] escenarios de ticket ...
SET TERMOUT OFF
@@002-test-escenarios-ticket.sql
SET TERMOUT ON
PROMPT [OK] escenarios de ticket
PROMPT [03/03] adjuntos en ticket ...
SET TERMOUT OFF
@@003-test-adjuntos-ticket.sql
SET TERMOUT ON
PROMPT [OK] adjuntos en ticket
PROMPT [04/04] base de conocimientos ...
SET TERMOUT OFF
@@004-test-base-conocimientos-ticket.sql
SET TERMOUT ON
PROMPT [OK] base de conocimientos
PROMPT === TODAS LAS PRUEBAS INTEGRALES PASARON ===

EXIT
