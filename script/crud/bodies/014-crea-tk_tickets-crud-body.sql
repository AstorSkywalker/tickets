-- Body CRUD para TICKETS.TK_TICKETS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_TICKETS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_TICKETS_CRUD_PKG';

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
        po_ID_TICKET_generado              OUT TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_CREAR_P');
        po_ID_TICKET_generado := NULL;
        INSERT INTO TICKETS.TK_TICKETS (
            ID_TICKET,
            NOMBRE_TICKET,
            DESCRIPCION,
            ID_USUARIO_REPORTA,
            ID_TECNICO_ASIGNADO,
            ID_CATEGORIA,
            ID_PRIORIDAD,
            ID_ESTADO,
            ID_AREA,
            FECHA_SOLICITUD,
            FECHA_ASIGNACION,
            FECHA_INICIO,
            FECHA_RESOLUCION,
            FECHA_CIERRE,
            HORAS_ESTIMADAS,
            HORAS_REALES,
            PORCENTAJE_AVANCE,
            DESCRIPCION_SOLUCION,
            USUARIO_CREACION,
            FECHA_CREACION,
            USUARIO_ACTUALIZACION,
            FECHA_ACTUALIZACION
        ) VALUES (
            p_id_ticket,
            p_nombre_ticket,
            p_descripcion,
            p_id_usuario_reporta,
            p_id_tecnico_asignado,
            p_id_categoria,
            p_id_prioridad,
            p_id_estado,
            p_id_area,
            p_fecha_solicitud,
            p_fecha_asignacion,
            p_fecha_inicio,
            p_fecha_resolucion,
            p_fecha_cierre,
            p_horas_estimadas,
            p_horas_reales,
            p_porcentaje_avance,
            p_descripcion_solucion,
            p_usuario_creacion,
            p_fecha_creacion,
            p_usuario_actualizacion,
            p_fecha_actualizacion
        ) RETURNING ID_TICKET INTO po_ID_TICKET_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_TICKET_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_TICKET_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TICKETS_CREAR_P' || ': ' || SQLERRM;
    END TK_TICKETS_CREAR_P;

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
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_TICKETS SET
            NOMBRE_TICKET = p_nombre_ticket,
            DESCRIPCION = p_descripcion,
            ID_USUARIO_REPORTA = p_id_usuario_reporta,
            ID_TECNICO_ASIGNADO = p_id_tecnico_asignado,
            ID_CATEGORIA = p_id_categoria,
            ID_PRIORIDAD = p_id_prioridad,
            ID_ESTADO = p_id_estado,
            ID_AREA = p_id_area,
            FECHA_SOLICITUD = p_fecha_solicitud,
            FECHA_ASIGNACION = p_fecha_asignacion,
            FECHA_INICIO = p_fecha_inicio,
            FECHA_RESOLUCION = p_fecha_resolucion,
            FECHA_CIERRE = p_fecha_cierre,
            HORAS_ESTIMADAS = p_horas_estimadas,
            HORAS_REALES = p_horas_reales,
            PORCENTAJE_AVANCE = p_porcentaje_avance,
            DESCRIPCION_SOLUCION = p_descripcion_solucion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion
         WHERE ID_TICKET = p_id_ticket;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TICKETS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_TICKETS_ACTUALIZAR_P;

    PROCEDURE TK_TICKETS_ELIMINAR_P(
        p_ID_TICKET                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = p_id_ticket;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TICKETS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_TICKETS_ELIMINAR_P;

    FUNCTION TK_TICKETS_CONSULTAR_F(
        p_ID_TICKET                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKETS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_TICKET,
                   NOMBRE_TICKET,
                   DESCRIPCION,
                   ID_USUARIO_REPORTA,
                   ID_TECNICO_ASIGNADO,
                   ID_CATEGORIA,
                   ID_PRIORIDAD,
                   ID_ESTADO,
                   ID_AREA,
                   FECHA_SOLICITUD,
                   FECHA_ASIGNACION,
                   FECHA_INICIO,
                   FECHA_RESOLUCION,
                   FECHA_CIERRE,
                   HORAS_ESTIMADAS,
                   HORAS_REALES,
                   PORCENTAJE_AVANCE,
                   DESCRIPCION_SOLUCION,
                   USUARIO_CREACION,
                   FECHA_CREACION,
                   USUARIO_ACTUALIZACION,
                   FECHA_ACTUALIZACION
              FROM TICKETS.TK_TICKETS
             WHERE p_id_ticket IS NULL
                OR ID_TICKET = p_id_ticket
             ORDER BY ID_TICKET;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_TICKETS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_TICKETS_CONSULTAR_F;

END TK_TICKETS_CRUD_PKG;
/

