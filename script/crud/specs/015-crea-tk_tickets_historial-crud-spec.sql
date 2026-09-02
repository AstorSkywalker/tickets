-- Spec CRUD para TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG AS

    PROCEDURE TK_TICKETS_HISTORIAL_CREAR_P(
        p_id_historial_ticket            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TICKET%TYPE,
        p_operacion                      IN  TICKETS.TK_TICKETS_HISTORIAL.OPERACION%TYPE,
        p_id_estado_anterior             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_ANTERIOR%TYPE,
        p_id_estado_nuevo                IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_NUEVO%TYPE,
        p_id_usuario_reporta_viejo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_VIEJO%TYPE,
        p_id_usuario_reporta_nuevo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_NUEVO%TYPE,
        p_id_tecnico_asignado_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_VIEJO%TYPE,
        p_id_tecnico_asignado_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_NUEVO%TYPE,
        p_id_categoria_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_VIEJO%TYPE,
        p_id_categoria_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_NUEVO%TYPE,
        p_id_prioridad_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_VIEJO%TYPE,
        p_id_prioridad_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_NUEVO%TYPE,
        p_id_area_viejo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_VIEJO%TYPE,
        p_id_area_nuevo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_NUEVO%TYPE,
        p_horas_estimadas_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_VIEJO%TYPE,
        p_horas_estimadas_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_NUEVO%TYPE,
        p_horas_reales_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_VIEJO%TYPE,
        p_horas_reales_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_NUEVO%TYPE,
        p_porcentaje_avance_viejo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_VIEJO%TYPE,
        p_porcentaje_avance_nuevo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_NUEVO%TYPE,
        p_nombre_ticket_viejo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_VIEJO%TYPE,
        p_nombre_ticket_nuevo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_NUEVO%TYPE,
        p_descripcion_viejo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_VIEJO%TYPE,
        p_descripcion_nuevo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_NUEVO%TYPE,
        p_descripcion_solucion_viejo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_VIEJO%TYPE,
        p_descripcion_solucion_nuevo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_NUEVO%TYPE,
        p_fecha_solicitud_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_VIEJO%TYPE,
        p_fecha_solicitud_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_NUEVO%TYPE,
        p_fecha_asignacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_VIEJO%TYPE,
        p_fecha_asignacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_NUEVO%TYPE,
        p_fecha_inicio_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_VIEJO%TYPE,
        p_fecha_inicio_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_NUEVO%TYPE,
        p_fecha_resolucion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_VIEJO%TYPE,
        p_fecha_resolucion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_NUEVO%TYPE,
        p_fecha_cierre_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_VIEJO%TYPE,
        p_fecha_cierre_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_NUEVO%TYPE,
        p_usuario_creacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_VIEJO%TYPE,
        p_usuario_creacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_NUEVO%TYPE,
        p_fecha_creacion_viejo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_VIEJO%TYPE,
        p_fecha_creacion_nuevo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_NUEVO%TYPE,
        p_usuario_actualizacion_viejo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_VIEJO%TYPE,
        p_usuario_actualizacion_nuevo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_NUEVO%TYPE,
        p_fecha_actualizacion_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_VIEJO%TYPE,
        p_fecha_actualizacion_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_NUEVO%TYPE,
        p_usuario_cambio                 IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CAMBIO%TYPE,
        p_fecha_cambio                   IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CAMBIO%TYPE,
        po_ID_HISTORIAL_TICKET_generado  OUT TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_HISTORIAL_ACTUALIZAR_P(
        p_id_historial_ticket            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TICKET%TYPE,
        p_operacion                      IN  TICKETS.TK_TICKETS_HISTORIAL.OPERACION%TYPE,
        p_id_estado_anterior             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_ANTERIOR%TYPE,
        p_id_estado_nuevo                IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_NUEVO%TYPE,
        p_id_usuario_reporta_viejo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_VIEJO%TYPE,
        p_id_usuario_reporta_nuevo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_NUEVO%TYPE,
        p_id_tecnico_asignado_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_VIEJO%TYPE,
        p_id_tecnico_asignado_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_NUEVO%TYPE,
        p_id_categoria_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_VIEJO%TYPE,
        p_id_categoria_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_NUEVO%TYPE,
        p_id_prioridad_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_VIEJO%TYPE,
        p_id_prioridad_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_NUEVO%TYPE,
        p_id_area_viejo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_VIEJO%TYPE,
        p_id_area_nuevo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_NUEVO%TYPE,
        p_horas_estimadas_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_VIEJO%TYPE,
        p_horas_estimadas_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_NUEVO%TYPE,
        p_horas_reales_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_VIEJO%TYPE,
        p_horas_reales_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_NUEVO%TYPE,
        p_porcentaje_avance_viejo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_VIEJO%TYPE,
        p_porcentaje_avance_nuevo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_NUEVO%TYPE,
        p_nombre_ticket_viejo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_VIEJO%TYPE,
        p_nombre_ticket_nuevo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_NUEVO%TYPE,
        p_descripcion_viejo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_VIEJO%TYPE,
        p_descripcion_nuevo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_NUEVO%TYPE,
        p_descripcion_solucion_viejo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_VIEJO%TYPE,
        p_descripcion_solucion_nuevo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_NUEVO%TYPE,
        p_fecha_solicitud_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_VIEJO%TYPE,
        p_fecha_solicitud_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_NUEVO%TYPE,
        p_fecha_asignacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_VIEJO%TYPE,
        p_fecha_asignacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_NUEVO%TYPE,
        p_fecha_inicio_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_VIEJO%TYPE,
        p_fecha_inicio_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_NUEVO%TYPE,
        p_fecha_resolucion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_VIEJO%TYPE,
        p_fecha_resolucion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_NUEVO%TYPE,
        p_fecha_cierre_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_VIEJO%TYPE,
        p_fecha_cierre_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_NUEVO%TYPE,
        p_usuario_creacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_VIEJO%TYPE,
        p_usuario_creacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_NUEVO%TYPE,
        p_fecha_creacion_viejo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_VIEJO%TYPE,
        p_fecha_creacion_nuevo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_NUEVO%TYPE,
        p_usuario_actualizacion_viejo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_VIEJO%TYPE,
        p_usuario_actualizacion_nuevo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_NUEVO%TYPE,
        p_fecha_actualizacion_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_VIEJO%TYPE,
        p_fecha_actualizacion_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_NUEVO%TYPE,
        p_usuario_cambio                 IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CAMBIO%TYPE,
        p_fecha_cambio                   IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CAMBIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_HISTORIAL_ELIMINAR_P(
        p_ID_HISTORIAL_TICKET            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TICKETS_HISTORIAL_CONSULTAR_F(
        p_ID_HISTORIAL_TICKET            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TICKETS_HISTORIAL_CRUD_PKG;
/

