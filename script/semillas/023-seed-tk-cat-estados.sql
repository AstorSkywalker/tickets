-- Datos semilla para TK_CAT_ESTADOS
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

MERGE INTO TICKETS.TK_CAT_ESTADOS t
USING (
    SELECT 'Nuevo' AS nombre_estado, 'Ticket recién registrado y pendiente de atención.' AS descripcion_estado, 'N' AS cerrado, 1 AS orden_visualizacion, 'S' AS activo FROM DUAL
    UNION ALL SELECT 'Asignado', 'Ticket asignado a un técnico responsable.', 'N', 2, 'S' FROM DUAL
    UNION ALL SELECT 'En Proceso', 'El ticket está siendo atendido.', 'N', 3, 'S' FROM DUAL
    UNION ALL SELECT 'Pendiente', 'La atención depende de información o acción externa.', 'N', 4, 'S' FROM DUAL
    UNION ALL SELECT 'Resuelto', 'La solución fue aplicada y está pendiente de cierre.', 'S', 5, 'S' FROM DUAL
    UNION ALL SELECT 'Cerrado', 'La atención fue finalizada y el ticket está cerrado.', 'S', 6, 'S' FROM DUAL
    UNION ALL SELECT 'Cancelado', 'El ticket fue cancelado sin requerir atención adicional.', 'S', 7, 'S' FROM DUAL
) s
ON (t.NOMBRE_ESTADO = s.NOMBRE_ESTADO)
WHEN MATCHED THEN UPDATE SET
    t.DESCRIPCION_ESTADO = s.DESCRIPCION_ESTADO,
    t.CERRADO = s.CERRADO,
    t.ORDEN_VISUALIZACION = s.ORDEN_VISUALIZACION,
    t.ACTIVO = s.ACTIVO
WHEN NOT MATCHED THEN INSERT (
    NOMBRE_ESTADO, DESCRIPCION_ESTADO, CERRADO, ORDEN_VISUALIZACION, ACTIVO
)
VALUES (
    s.NOMBRE_ESTADO, s.DESCRIPCION_ESTADO, s.CERRADO, s.ORDEN_VISUALIZACION, s.ACTIVO
);

COMMIT;
