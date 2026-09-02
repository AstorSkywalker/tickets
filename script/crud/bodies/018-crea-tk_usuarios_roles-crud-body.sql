-- Body CRUD para TICKETS.TK_USUARIOS_ROLES_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_USUARIOS_ROLES_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_USUARIOS_ROLES_CRUD_PKG';

    PROCEDURE TK_USUARIOS_ROLES_CREAR_P(
        p_id_usuario_rol                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        p_id_rol                         IN  TICKETS.TK_USUARIOS_ROLES.ID_ROL%TYPE,
        p_id_usuario                     IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_ACTUALIZACION%TYPE,
        po_ID_USUARIO_ROL_generado              OUT TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_ROLES_CREAR_P');
        po_ID_USUARIO_ROL_generado := NULL;
        INSERT INTO TICKETS.TK_USUARIOS_ROLES (
            ID_USUARIO_ROL,
            ID_ROL,
            ID_USUARIO,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION
        ) VALUES (
            p_id_usuario_rol,
            p_id_rol,
            p_id_usuario,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion
        ) RETURNING ID_USUARIO_ROL INTO po_ID_USUARIO_ROL_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_USUARIO_ROL_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_USUARIO_ROL_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_USUARIOS_ROLES_CREAR_P' || ': ' || SQLERRM;
    END TK_USUARIOS_ROLES_CREAR_P;

    PROCEDURE TK_USUARIOS_ROLES_ACTUALIZAR_P(
        p_id_usuario_rol                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        p_id_rol                         IN  TICKETS.TK_USUARIOS_ROLES.ID_ROL%TYPE,
        p_id_usuario                     IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_ROLES_ACTUALIZAR_P');
        UPDATE TICKETS.TK_USUARIOS_ROLES SET
            ID_ROL = p_id_rol,
            ID_USUARIO = p_id_usuario,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion
         WHERE ID_USUARIO_ROL = p_id_usuario_rol;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_USUARIOS_ROLES_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_USUARIOS_ROLES_ACTUALIZAR_P;

    PROCEDURE TK_USUARIOS_ROLES_ELIMINAR_P(
        p_ID_USUARIO_ROL                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_ROLES_ELIMINAR_P');
        DELETE FROM TICKETS.TK_USUARIOS_ROLES WHERE ID_USUARIO_ROL = p_id_usuario_rol;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_USUARIOS_ROLES_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_USUARIOS_ROLES_ELIMINAR_P;

    FUNCTION TK_USUARIOS_ROLES_CONSULTAR_F(
        p_ID_USUARIO_ROL                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_ROLES_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_USUARIO_ROL,
                   ID_ROL,
                   ID_USUARIO,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION
              FROM TICKETS.TK_USUARIOS_ROLES
             WHERE p_id_usuario_rol IS NULL
                OR ID_USUARIO_ROL = p_id_usuario_rol
             ORDER BY ID_USUARIO_ROL;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_USUARIOS_ROLES_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_USUARIOS_ROLES_CONSULTAR_F;

END TK_USUARIOS_ROLES_CRUD_PKG;
/

