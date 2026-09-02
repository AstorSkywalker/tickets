-- Body CRUD para TICKETS.TK_ENCUESTAS_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_ENCUESTAS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_ENCUESTAS_CRUD_PKG';

    PROCEDURE TK_ENCUESTAS_CREAR_P(
        p_id_encuesta                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion                   IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario                     IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_ENCUESTA_generado              OUT TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ENCUESTAS_CREAR_P');
        po_ID_ENCUESTA_generado := NULL;
        INSERT INTO TICKETS.TK_ENCUESTAS (
            ID_ENCUESTA,
            ID_TICKET,
            CALIFICACION,
            COMENTARIO,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION
        ) VALUES (
            p_id_encuesta,
            p_id_ticket,
            p_calificacion,
            p_comentario,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion
        ) RETURNING ID_ENCUESTA INTO po_ID_ENCUESTA_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_ENCUESTA_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_ENCUESTA_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ENCUESTAS_CREAR_P' || ': ' || SQLERRM;
    END TK_ENCUESTAS_CREAR_P;

    PROCEDURE TK_ENCUESTAS_ACTUALIZAR_P(
        p_id_encuesta                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion                   IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario                     IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ENCUESTAS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_ENCUESTAS SET
            ID_TICKET = p_id_ticket,
            CALIFICACION = p_calificacion,
            COMENTARIO = p_comentario,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion
         WHERE ID_ENCUESTA = p_id_encuesta;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ENCUESTAS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_ENCUESTAS_ACTUALIZAR_P;

    PROCEDURE TK_ENCUESTAS_ELIMINAR_P(
        p_ID_ENCUESTA                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ENCUESTAS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_ENCUESTAS WHERE ID_ENCUESTA = p_id_encuesta;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ENCUESTAS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_ENCUESTAS_ELIMINAR_P;

    FUNCTION TK_ENCUESTAS_CONSULTAR_F(
        p_ID_ENCUESTA                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ENCUESTAS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_ENCUESTA,
                   ID_TICKET,
                   CALIFICACION,
                   COMENTARIO,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION
              FROM TICKETS.TK_ENCUESTAS
             WHERE p_id_encuesta IS NULL
                OR ID_ENCUESTA = p_id_encuesta
             ORDER BY ID_ENCUESTA;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_ENCUESTAS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_ENCUESTAS_CONSULTAR_F;

END TK_ENCUESTAS_CRUD_PKG;
/

