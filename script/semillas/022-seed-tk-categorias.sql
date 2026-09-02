-- Datos semilla para TK_CATEGORIAS
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

MERGE INTO TICKETS.TK_CATEGORIAS t
USING (
    SELECT 'Hardware' AS nombre_categoria, 'Equipos y componentes físicos.' AS descripcion, 'S' AS activa FROM DUAL
    UNION ALL SELECT 'Software', 'Sistemas operativos, aplicaciones y licencias.', 'S' FROM DUAL
    UNION ALL SELECT 'Accesos y Permisos', 'Solicitudes de cuentas, accesos y autorizaciones.', 'S' FROM DUAL
    UNION ALL SELECT 'Redes y Conectividad', 'Problemas de red, Internet, VPN y conectividad.', 'S' FROM DUAL
    UNION ALL SELECT 'Aplicaciones', 'Incidentes o solicitudes relacionados con aplicaciones.', 'S' FROM DUAL
    UNION ALL SELECT 'Incidentes', 'Interrupciones o degradaciones no planificadas del servicio.', 'S' FROM DUAL
    UNION ALL SELECT 'Solicitudes', 'Peticiones de servicio o información.', 'S' FROM DUAL
) s
ON (t.NOMBRE_CATEGORIA = s.NOMBRE_CATEGORIA)
WHEN MATCHED THEN UPDATE SET
    t.DESCRIPCION = s.DESCRIPCION,
    t.ACTIVA = s.ACTIVA
WHEN NOT MATCHED THEN INSERT (NOMBRE_CATEGORIA, DESCRIPCION, ACTIVA)
VALUES (s.NOMBRE_CATEGORIA, s.DESCRIPCION, s.ACTIVA);

COMMIT;
