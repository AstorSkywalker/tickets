-- Datos semilla para TK_ROLES
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

MERGE INTO TICKETS.TK_ROLES t
USING (
    SELECT 'Administrador' AS nombre_rol, 'Administra la configuración y los catálogos del sistema.' AS descripcion, 'S' AS activo FROM DUAL
    UNION ALL SELECT 'Técnico', 'Atiende, actualiza y resuelve tickets asignados.', 'S' FROM DUAL
    UNION ALL SELECT 'Supervisor', 'Supervisa la operación y distribución de tickets.', 'S' FROM DUAL
    UNION ALL SELECT 'Usuario', 'Registra solicitudes y consulta sus propios tickets.', 'S' FROM DUAL
) s
ON (t.NOMBRE_ROL = s.NOMBRE_ROL)
WHEN MATCHED THEN UPDATE SET
    t.DESCRIPCION = s.DESCRIPCION,
    t.ACTIVO = s.ACTIVO
WHEN NOT MATCHED THEN INSERT (NOMBRE_ROL, DESCRIPCION, ACTIVO)
VALUES (s.NOMBRE_ROL, s.DESCRIPCION, s.ACTIVO);

COMMIT;
