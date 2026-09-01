-- Correr con un dba
CONNECT SYS AS SYSDBA

-- Tablespace para el proyecto de tickets
CREATE TABLESPACE TBS_TICKETS
    DATAFILE 'TBS_TICKETS_01.DBF'
    SIZE 100M
    AUTOEXTEND ON
    NEXT 50M;
