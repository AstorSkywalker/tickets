-- Body CRUD para TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_TICKETS_HISTORIAL_CRUD_PKG';

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
        po_ID_HISTORIAL_TICKET_generado              OUT TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_HISTORIAL_CREAR_P');
        po_ID_HISTORIAL_TICKET_generado := NULL;
        INSERT INTO TICKETS.TK_TICKETS_HISTORIAL (
            ID_HISTORIAL_TICKET,
            ID_TICKET,
            OPERACION,
            ID_ESTADO_ANTERIOR,
            ID_ESTADO_NUEVO,
            ID_USUARIO_REPORTA_VIEJO,
            ID_USUARIO_REPORTA_NUEVO,
            ID_TECNICO_ASIGNADO_VIEJO,
            ID_TECNICO_ASIGNADO_NUEVO,
            ID_CATEGORIA_VIEJO,
            ID_CATEGORIA_NUEVO,
            ID_PRIORIDAD_VIEJO,
            ID_PRIORIDAD_NUEVO,
            ID_AREA_VIEJO,
            ID_AREA_NUEVO,
            HORAS_ESTIMADAS_VIEJO,
            HORAS_ESTIMADAS_NUEVO,
            HORAS_REALES_VIEJO,
            HORAS_REALES_NUEVO,
            PORCENTAJE_AVANCE_VIEJO,
            PORCENTAJE_AVANCE_NUEVO,
            NOMBRE_TICKET_VIEJO,
            NOMBRE_TICKET_NUEVO,
            DESCRIPCION_VIEJO,
            DESCRIPCION_NUEVO,
            DESCRIPCION_SOLUCION_VIEJO,
            DESCRIPCION_SOLUCION_NUEVO,
            FECHA_SOLICITUD_VIEJO,
            FECHA_SOLICITUD_NUEVO,
            FECHA_ASIGNACION_VIEJO,
            FECHA_ASIGNACION_NUEVO,
            FECHA_INICIO_VIEJO,
            FECHA_INICIO_NUEVO,
            FECHA_RESOLUCION_VIEJO,
            FECHA_RESOLUCION_NUEVO,
            FECHA_CIERRE_VIEJO,
            FECHA_CIERRE_NUEVO,
            USUARIO_CREACION_VIEJO,
            USUARIO_CREACION_NUEVO,
            FECHA_CREACION_VIEJO,
            FECHA_CREACION_NUEVO,
            USUARIO_ACTUALIZACION_VIEJO,
            USUARIO_ACTUALIZACION_NUEVO,
            FECHA_ACTUALIZACION_VIEJO,
            FECHA_ACTUALIZACION_NUEVO,
            USUARIO_CAMBIO,
            FECHA_CAMBIO
        ) VALUES (
            p_id_historial_ticket,
            p_id_ticket,
            p_operacion,
            p_id_estado_anterior,
            p_id_estado_nuevo,
            p_id_usuario_reporta_viejo,
            p_id_usuario_reporta_nuevo,
            p_id_tecnico_asignado_viejo,
            p_id_tecnico_asignado_nuevo,
            p_id_categoria_viejo,
            p_id_categoria_nuevo,
            p_id_prioridad_viejo,
            p_id_prioridad_nuevo,
            p_id_area_viejo,
            p_id_area_nuevo,
            p_horas_estimadas_viejo,
            p_horas_estimadas_nuevo,
            p_horas_reales_viejo,
            p_horas_reales_nuevo,
            p_porcentaje_avance_viejo,
            p_porcentaje_avance_nuevo,
            p_nombre_ticket_viejo,
            p_nombre_ticket_nuevo,
            p_descripcion_viejo,
            p_descripcion_nuevo,
            p_descripcion_solucion_viejo,
            p_descripcion_solucion_nuevo,
            p_fecha_solicitud_viejo,
            p_fecha_solicitud_nuevo,
            p_fecha_asignacion_viejo,
            p_fecha_asignacion_nuevo,
            p_fecha_inicio_viejo,
            p_fecha_inicio_nuevo,
            p_fecha_resolucion_viejo,
            p_fecha_resolucion_nuevo,
            p_fecha_cierre_viejo,
            p_fecha_cierre_nuevo,
            p_usuario_creacion_viejo,
            p_usuario_creacion_nuevo,
            p_fecha_creacion_viejo,
            p_fecha_creacion_nuevo,
            p_usuario_actualizacion_viejo,
            p_usuario_actualizacion_nuevo,
            p_fecha_actualizacion_viejo,
            p_fecha_actualizacion_nuevo,
            p_usuario_cambio,
            p_fecha_cambio
        ) RETURNING ID_HISTORIAL_TICKET INTO po_ID_HISTORIAL_TICKET_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_HISTORIAL_TICKET_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_HISTORIAL_TICKET_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TICKETS_HISTORIAL_CREAR_P' || ': ' || SQLERRM;
    END TK_TICKETS_HISTORIAL_CREAR_P;

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
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_HISTORIAL_ACTUALIZAR_P');
        UPDATE TICKETS.TK_TICKETS_HISTORIAL SET
            ID_TICKET = p_id_ticket,
            OPERACION = p_operacion,
            ID_ESTADO_ANTERIOR = p_id_estado_anterior,
            ID_ESTADO_NUEVO = p_id_estado_nuevo,
            ID_USUARIO_REPORTA_VIEJO = p_id_usuario_reporta_viejo,
            ID_USUARIO_REPORTA_NUEVO = p_id_usuario_reporta_nuevo,
            ID_TECNICO_ASIGNADO_VIEJO = p_id_tecnico_asignado_viejo,
            ID_TECNICO_ASIGNADO_NUEVO = p_id_tecnico_asignado_nuevo,
            ID_CATEGORIA_VIEJO = p_id_categoria_viejo,
            ID_CATEGORIA_NUEVO = p_id_categoria_nuevo,
            ID_PRIORIDAD_VIEJO = p_id_prioridad_viejo,
            ID_PRIORIDAD_NUEVO = p_id_prioridad_nuevo,
            ID_AREA_VIEJO = p_id_area_viejo,
            ID_AREA_NUEVO = p_id_area_nuevo,
            HORAS_ESTIMADAS_VIEJO = p_horas_estimadas_viejo,
            HORAS_ESTIMADAS_NUEVO = p_horas_estimadas_nuevo,
            HORAS_REALES_VIEJO = p_horas_reales_viejo,
            HORAS_REALES_NUEVO = p_horas_reales_nuevo,
            PORCENTAJE_AVANCE_VIEJO = p_porcentaje_avance_viejo,
            PORCENTAJE_AVANCE_NUEVO = p_porcentaje_avance_nuevo,
            NOMBRE_TICKET_VIEJO = p_nombre_ticket_viejo,
            NOMBRE_TICKET_NUEVO = p_nombre_ticket_nuevo,
            DESCRIPCION_VIEJO = p_descripcion_viejo,
            DESCRIPCION_NUEVO = p_descripcion_nuevo,
            DESCRIPCION_SOLUCION_VIEJO = p_descripcion_solucion_viejo,
            DESCRIPCION_SOLUCION_NUEVO = p_descripcion_solucion_nuevo,
            FECHA_SOLICITUD_VIEJO = p_fecha_solicitud_viejo,
            FECHA_SOLICITUD_NUEVO = p_fecha_solicitud_nuevo,
            FECHA_ASIGNACION_VIEJO = p_fecha_asignacion_viejo,
            FECHA_ASIGNACION_NUEVO = p_fecha_asignacion_nuevo,
            FECHA_INICIO_VIEJO = p_fecha_inicio_viejo,
            FECHA_INICIO_NUEVO = p_fecha_inicio_nuevo,
            FECHA_RESOLUCION_VIEJO = p_fecha_resolucion_viejo,
            FECHA_RESOLUCION_NUEVO = p_fecha_resolucion_nuevo,
            FECHA_CIERRE_VIEJO = p_fecha_cierre_viejo,
            FECHA_CIERRE_NUEVO = p_fecha_cierre_nuevo,
            USUARIO_CREACION_VIEJO = p_usuario_creacion_viejo,
            USUARIO_CREACION_NUEVO = p_usuario_creacion_nuevo,
            FECHA_CREACION_VIEJO = p_fecha_creacion_viejo,
            FECHA_CREACION_NUEVO = p_fecha_creacion_nuevo,
            USUARIO_ACTUALIZACION_VIEJO = p_usuario_actualizacion_viejo,
            USUARIO_ACTUALIZACION_NUEVO = p_usuario_actualizacion_nuevo,
            FECHA_ACTUALIZACION_VIEJO = p_fecha_actualizacion_viejo,
            FECHA_ACTUALIZACION_NUEVO = p_fecha_actualizacion_nuevo,
            USUARIO_CAMBIO = p_usuario_cambio,
            FECHA_CAMBIO = p_fecha_cambio
         WHERE ID_HISTORIAL_TICKET = p_id_historial_ticket;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TICKETS_HISTORIAL_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_TICKETS_HISTORIAL_ACTUALIZAR_P;

    PROCEDURE TK_TICKETS_HISTORIAL_ELIMINAR_P(
        p_ID_HISTORIAL_TICKET            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_HISTORIAL_ELIMINAR_P');
        DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_HISTORIAL_TICKET = p_id_historial_ticket;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TICKETS_HISTORIAL_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_TICKETS_HISTORIAL_ELIMINAR_P;

    FUNCTION TK_TICKETS_HISTORIAL_CONSULTAR_F(
        p_ID_HISTORIAL_TICKET            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_HISTORIAL_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_HISTORIAL_TICKET,
                   ID_TICKET,
                   OPERACION,
                   ID_ESTADO_ANTERIOR,
                   ID_ESTADO_NUEVO,
                   ID_USUARIO_REPORTA_VIEJO,
                   ID_USUARIO_REPORTA_NUEVO,
                   ID_TECNICO_ASIGNADO_VIEJO,
                   ID_TECNICO_ASIGNADO_NUEVO,
                   ID_CATEGORIA_VIEJO,
                   ID_CATEGORIA_NUEVO,
                   ID_PRIORIDAD_VIEJO,
                   ID_PRIORIDAD_NUEVO,
                   ID_AREA_VIEJO,
                   ID_AREA_NUEVO,
                   HORAS_ESTIMADAS_VIEJO,
                   HORAS_ESTIMADAS_NUEVO,
                   HORAS_REALES_VIEJO,
                   HORAS_REALES_NUEVO,
                   PORCENTAJE_AVANCE_VIEJO,
                   PORCENTAJE_AVANCE_NUEVO,
                   NOMBRE_TICKET_VIEJO,
                   NOMBRE_TICKET_NUEVO,
                   DESCRIPCION_VIEJO,
                   DESCRIPCION_NUEVO,
                   DESCRIPCION_SOLUCION_VIEJO,
                   DESCRIPCION_SOLUCION_NUEVO,
                   FECHA_SOLICITUD_VIEJO,
                   FECHA_SOLICITUD_NUEVO,
                   FECHA_ASIGNACION_VIEJO,
                   FECHA_ASIGNACION_NUEVO,
                   FECHA_INICIO_VIEJO,
                   FECHA_INICIO_NUEVO,
                   FECHA_RESOLUCION_VIEJO,
                   FECHA_RESOLUCION_NUEVO,
                   FECHA_CIERRE_VIEJO,
                   FECHA_CIERRE_NUEVO,
                   USUARIO_CREACION_VIEJO,
                   USUARIO_CREACION_NUEVO,
                   FECHA_CREACION_VIEJO,
                   FECHA_CREACION_NUEVO,
                   USUARIO_ACTUALIZACION_VIEJO,
                   USUARIO_ACTUALIZACION_NUEVO,
                   FECHA_ACTUALIZACION_VIEJO,
                   FECHA_ACTUALIZACION_NUEVO,
                   USUARIO_CAMBIO,
                   FECHA_CAMBIO
              FROM TICKETS.TK_TICKETS_HISTORIAL
             WHERE p_id_historial_ticket IS NULL
                OR ID_HISTORIAL_TICKET = p_id_historial_ticket
             ORDER BY ID_HISTORIAL_TICKET;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_TICKETS_HISTORIAL_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_TICKETS_HISTORIAL_CONSULTAR_F;

END TK_TICKETS_HISTORIAL_CRUD_PKG;
/

