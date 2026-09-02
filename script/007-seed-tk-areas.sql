-- Datos semilla para TK_AREAS
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

MERGE INTO TICKETS.TK_AREAS t
USING (
    SELECT 'Mesa de Ayuda' AS nombre_area, 'Atención y seguimiento de solicitudes de soporte.' AS descripcion, 'S' AS activa FROM DUAL
    UNION ALL SELECT 'Infraestructura', 'Servidores, almacenamiento y plataformas tecnológicas.', 'S' FROM DUAL
    UNION ALL SELECT 'Desarrollo de Aplicaciones', 'Desarrollo, mantenimiento y soporte de aplicaciones.', 'S' FROM DUAL
    UNION ALL SELECT 'Seguridad de la Información', 'Gestión de seguridad, accesos y cumplimiento.', 'S' FROM DUAL
    UNION ALL SELECT 'Redes y Comunicaciones', 'Conectividad, redes y servicios de comunicación.', 'S' FROM DUAL
) s
ON (t.NOMBRE_AREA = s.NOMBRE_AREA)
WHEN MATCHED THEN UPDATE SET
    t.DESCRIPCION = s.DESCRIPCION,
    t.ACTIVA = s.ACTIVA
WHEN NOT MATCHED THEN INSERT (NOMBRE_AREA, DESCRIPCION, ACTIVA)
VALUES (s.NOMBRE_AREA, s.DESCRIPCION, s.ACTIVA);

COMMIT;
