-- Body CRUD para TICKETS.TK_COMENTARIOS_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_COMENTARIOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_COMENTARIOS_CRUD_PKG';

    PROCEDURE TK_COMENTARIOS_CREAR_P(
        p_id_comentario                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario                     IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario                     IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_COMENTARIOS.ACTIVO%TYPE,
        po_ID_COMENTARIO_generado              OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_COMENTARIOS_CREAR_P');
        po_ID_COMENTARIO_generado := NULL;
        INSERT INTO TICKETS.TK_COMENTARIOS (
            ID_COMENTARIO,
            ID_TICKET,
            ID_USUARIO,
            COMENTARIO,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVO
        ) VALUES (
            p_id_comentario,
            p_id_ticket,
            p_id_usuario,
            p_comentario,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activo
        ) RETURNING ID_COMENTARIO INTO po_ID_COMENTARIO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_COMENTARIO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_COMENTARIO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_COMENTARIOS_CREAR_P' || ': ' || SQLERRM;
    END TK_COMENTARIOS_CREAR_P;

    PROCEDURE TK_COMENTARIOS_ACTUALIZAR_P(
        p_id_comentario                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario                     IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario                     IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_COMENTARIOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_COMENTARIOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_COMENTARIOS SET
            ID_TICKET = p_id_ticket,
            ID_USUARIO = p_id_usuario,
            COMENTARIO = p_comentario,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVO = p_activo
         WHERE ID_COMENTARIO = p_id_comentario;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_COMENTARIOS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_COMENTARIOS_ACTUALIZAR_P;

    PROCEDURE TK_COMENTARIOS_ELIMINAR_P(
        p_ID_COMENTARIO                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_COMENTARIOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_COMENTARIO = p_id_comentario;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_COMENTARIOS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_COMENTARIOS_ELIMINAR_P;

    FUNCTION TK_COMENTARIOS_CONSULTAR_F(
        p_ID_COMENTARIO                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_COMENTARIOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_COMENTARIO,
                   ID_TICKET,
                   ID_USUARIO,
                   COMENTARIO,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_COMENTARIOS
             WHERE p_id_comentario IS NULL
                OR ID_COMENTARIO = p_id_comentario
             ORDER BY ID_COMENTARIO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_COMENTARIOS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_COMENTARIOS_CONSULTAR_F;

END TK_COMENTARIOS_CRUD_PKG;
/

