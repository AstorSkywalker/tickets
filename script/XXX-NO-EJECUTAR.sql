-- Ejecutar con SQL*Plus o SQLcl.
-- Borra el usuario y tablespace de la base de datos.
-- El usuario TICKETS no debe estar conectado al momento de ejecutar el script.

SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK ON
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT
PROMPT === Conexion a Oracle ===
PROMPT Presione ENTER para aceptar el valor mostrado entre corchetes.

ACCEPT password CHAR HIDE PROMPT 'Password de SYS: '
ACCEPT host CHAR DEFAULT '192.168.80.178' PROMPT 'Host [192.168.80.178]: '
ACCEPT puerto CHAR DEFAULT '1521' PROMPT 'Puerto [1521]: '
ACCEPT servicio CHAR DEFAULT 'freepdb1' PROMPT 'Servicio/PDB [freepdb1]: '

-- El usuario y el privilegio quedan fijados como SYS AS SYSDBA.
DISCONNECT
CONNECT sys/&password@//&host:&puerto/&servicio AS SYSDBA

PROMPT
PROMPT ATENCION: Este script eliminara el usuario TICKETS y su tablespace TBS_TICKETS.
ACCEPT continuar CHAR DEFAULT 'N' FORMAT 'A1' PROMPT 'Desea continuar? (S/N) [N]: '

BEGIN
    IF UPPER(TRIM('&continuar')) <> 'S' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operacion cancelada por el usuario.');
    END IF;
END;
/

DROP USER tickets CASCADE;
DROP TABLESPACE tbs_tickets INCLUDING CONTENTS AND DATAFILES;
