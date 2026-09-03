-- Datos semilla para TK_TIPOS_ACTIVOS
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

MERGE INTO TICKETS.TK_TIPOS_ACTIVOS t
USING (
    SELECT 'Equipo de Cómputo' AS nombre_tipo_activo, 'Computadoras de escritorio y portátiles.' AS descripcion_tipo_activo, 'S' AS activo FROM DUAL
    UNION ALL SELECT 'Dispositivo Móvil', 'Teléfonos, tabletas y otros dispositivos móviles.', 'S' FROM DUAL
    UNION ALL SELECT 'Impresora', 'Impresoras y equipos multifunción.', 'S' FROM DUAL
    UNION ALL SELECT 'Servidor', 'Servidores físicos o virtuales.', 'S' FROM DUAL
    UNION ALL SELECT 'Red y Comunicaciones', 'Switches, routers, puntos de acceso y equipos de comunicación.', 'S' FROM DUAL
    UNION ALL SELECT 'Licencia de Software', 'Licencias y suscripciones de software.', 'S' FROM DUAL
    UNION ALL SELECT 'Periférico', 'Monitores, teclados, mouse y otros periféricos.', 'S' FROM DUAL
) s
ON (t.NOMBRE_TIPO_ACTIVO = s.NOMBRE_TIPO_ACTIVO)
WHEN MATCHED THEN UPDATE SET
    t.DESCRIPCION_TIPO_ACTIVO = s.DESCRIPCION_TIPO_ACTIVO,
    t.ACTIVO = s.ACTIVO
WHEN NOT MATCHED THEN INSERT (
    NOMBRE_TIPO_ACTIVO, DESCRIPCION_TIPO_ACTIVO, ACTIVO
)
VALUES (
    s.NOMBRE_TIPO_ACTIVO, s.DESCRIPCION_TIPO_ACTIVO, s.ACTIVO
);

COMMIT;
