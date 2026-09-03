-- Body CRUD para TICKETS.TK_ACTIVOS_TICKETS_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_ACTIVOS_TICKETS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_ACTIVOS_TICKETS_CRUD_PKG';

    PROCEDURE TK_ACTIVOS_TICKETS_CREAR_P(
        p_id_activo_ticket               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        p_id_activo                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_ACTIVO_TICKET_generado              OUT TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_TICKETS_CREAR_P');
        po_ID_ACTIVO_TICKET_generado := NULL;
        INSERT INTO TICKETS.TK_ACTIVOS_TICKETS (
            ID_ACTIVO_TICKET,
            ID_ACTIVO,
            ID_TICKET,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION
        ) VALUES (
            p_id_activo_ticket,
            p_id_activo,
            p_id_ticket,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion
        ) RETURNING ID_ACTIVO_TICKET INTO po_ID_ACTIVO_TICKET_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_ACTIVO_TICKET_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_ACTIVO_TICKET_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ACTIVOS_TICKETS_CREAR_P' || ': ' || SQLERRM;
    END TK_ACTIVOS_TICKETS_CREAR_P;

    PROCEDURE TK_ACTIVOS_TICKETS_ACTUALIZAR_P(
        p_id_activo_ticket               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        p_id_activo                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_TICKETS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_ACTIVOS_TICKETS SET
            ID_ACTIVO = p_id_activo,
            ID_TICKET = p_id_ticket,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion
         WHERE ID_ACTIVO_TICKET = p_id_activo_ticket;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ACTIVOS_TICKETS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_ACTIVOS_TICKETS_ACTUALIZAR_P;

    PROCEDURE TK_ACTIVOS_TICKETS_ELIMINAR_P(
        p_ID_ACTIVO_TICKET               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_TICKETS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_ACTIVOS_TICKETS WHERE ID_ACTIVO_TICKET = p_id_activo_ticket;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ACTIVOS_TICKETS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_ACTIVOS_TICKETS_ELIMINAR_P;

    FUNCTION TK_ACTIVOS_TICKETS_CONSULTAR_F(
        p_ID_ACTIVO_TICKET               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_TICKETS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_ACTIVO_TICKET,
                   ID_ACTIVO,
                   ID_TICKET,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION
              FROM TICKETS.TK_ACTIVOS_TICKETS
             WHERE p_id_activo_ticket IS NULL
                OR ID_ACTIVO_TICKET = p_id_activo_ticket
             ORDER BY ID_ACTIVO_TICKET;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_ACTIVOS_TICKETS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_ACTIVOS_TICKETS_CONSULTAR_F;

END TK_ACTIVOS_TICKETS_CRUD_PKG;
/
