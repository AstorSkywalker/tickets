-- Spec CRUD para TICKETS.TK_TICKETS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKETS_CRUD_PKG AS

    PROCEDURE TK_TICKETS_CREAR_P(
        p_id_ticket                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_nombre_ticket                  IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion                    IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_usuario_reporta             IN  TICKETS.TK_TICKETS.ID_USUARIO_REPORTA%TYPE,
        p_id_tecnico_asignado            IN  TICKETS.TK_TICKETS.ID_TECNICO_ASIGNADO%TYPE,
        p_id_categoria                   IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad                   IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_estado                      IN  TICKETS.TK_TICKETS.ID_ESTADO%TYPE,
        p_id_area                        IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_fecha_solicitud                IN  TICKETS.TK_TICKETS.FECHA_SOLICITUD%TYPE,
        p_fecha_asignacion               IN  TICKETS.TK_TICKETS.FECHA_ASIGNACION%TYPE,
        p_fecha_inicio                   IN  TICKETS.TK_TICKETS.FECHA_INICIO%TYPE,
        p_fecha_resolucion               IN  TICKETS.TK_TICKETS.FECHA_RESOLUCION%TYPE,
        p_fecha_cierre                   IN  TICKETS.TK_TICKETS.FECHA_CIERRE%TYPE,
        p_horas_estimadas                IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE,
        p_horas_reales                   IN  TICKETS.TK_TICKETS.HORAS_REALES%TYPE,
        p_porcentaje_avance              IN  TICKETS.TK_TICKETS.PORCENTAJE_AVANCE%TYPE,
        p_descripcion_solucion           IN  TICKETS.TK_TICKETS.DESCRIPCION_SOLUCION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKETS.FECHA_ACTUALIZACION%TYPE,
        po_ID_TICKET_generado          OUT TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_ACTUALIZAR_P(
        p_id_ticket                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_nombre_ticket                  IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion                    IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_usuario_reporta             IN  TICKETS.TK_TICKETS.ID_USUARIO_REPORTA%TYPE,
        p_id_tecnico_asignado            IN  TICKETS.TK_TICKETS.ID_TECNICO_ASIGNADO%TYPE,
        p_id_categoria                   IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad                   IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_estado                      IN  TICKETS.TK_TICKETS.ID_ESTADO%TYPE,
        p_id_area                        IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_fecha_solicitud                IN  TICKETS.TK_TICKETS.FECHA_SOLICITUD%TYPE,
        p_fecha_asignacion               IN  TICKETS.TK_TICKETS.FECHA_ASIGNACION%TYPE,
        p_fecha_inicio                   IN  TICKETS.TK_TICKETS.FECHA_INICIO%TYPE,
        p_fecha_resolucion               IN  TICKETS.TK_TICKETS.FECHA_RESOLUCION%TYPE,
        p_fecha_cierre                   IN  TICKETS.TK_TICKETS.FECHA_CIERRE%TYPE,
        p_horas_estimadas                IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE,
        p_horas_reales                   IN  TICKETS.TK_TICKETS.HORAS_REALES%TYPE,
        p_porcentaje_avance              IN  TICKETS.TK_TICKETS.PORCENTAJE_AVANCE%TYPE,
        p_descripcion_solucion           IN  TICKETS.TK_TICKETS.DESCRIPCION_SOLUCION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKETS.FECHA_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_ELIMINAR_P(
        p_ID_TICKET                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TICKETS_CONSULTAR_F(
        p_ID_TICKET                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TICKETS_CRUD_PKG;
/

