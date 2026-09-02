-- Body CRUD para TICKETS.TK_USUARIOS_CRUD_PKG
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_USUARIOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_USUARIOS_CRUD_PKG';

    PROCEDURE TK_USUARIOS_CREAR_P(
        p_id_usuario                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        p_nombre                         IN  TICKETS.TK_USUARIOS.NOMBRE%TYPE,
        p_apellido                       IN  TICKETS.TK_USUARIOS.APELLIDO%TYPE,
        p_username                       IN  TICKETS.TK_USUARIOS.USERNAME%TYPE,
        p_email                          IN  TICKETS.TK_USUARIOS.EMAIL%TYPE,
        p_telefono                       IN  TICKETS.TK_USUARIOS.TELEFONO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_USUARIOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_USUARIOS.ACTIVO%TYPE,
        po_ID_USUARIO_generado              OUT TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_CREAR_P');
        po_ID_USUARIO_generado := NULL;
        INSERT INTO TICKETS.TK_USUARIOS (
            ID_USUARIO,
            NOMBRE,
            APELLIDO,
            USERNAME,
            EMAIL,
            TELEFONO,
            UBICACION,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVO
        ) VALUES (
            p_id_usuario,
            p_nombre,
            p_apellido,
            p_username,
            p_email,
            p_telefono,
            p_ubicacion,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activo
        ) RETURNING ID_USUARIO INTO po_ID_USUARIO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_USUARIO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_USUARIO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_USUARIOS_CREAR_P + ': ' || SQLERRM;
    END TK_USUARIOS_CREAR_P;

    PROCEDURE TK_USUARIOS_ACTUALIZAR_P(
        p_id_usuario                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        p_nombre                         IN  TICKETS.TK_USUARIOS.NOMBRE%TYPE,
        p_apellido                       IN  TICKETS.TK_USUARIOS.APELLIDO%TYPE,
        p_username                       IN  TICKETS.TK_USUARIOS.USERNAME%TYPE,
        p_email                          IN  TICKETS.TK_USUARIOS.EMAIL%TYPE,
        p_telefono                       IN  TICKETS.TK_USUARIOS.TELEFONO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_USUARIOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_USUARIOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_USUARIOS SET
            NOMBRE = p_nombre,
            APELLIDO = p_apellido,
            USERNAME = p_username,
            EMAIL = p_email,
            TELEFONO = p_telefono,
            UBICACION = p_ubicacion,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVO = p_activo
         WHERE ID_USUARIO = p_id_usuario;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_USUARIOS_ACTUALIZAR_P + ': ' || SQLERRM;
    END TK_USUARIOS_ACTUALIZAR_P;

    PROCEDURE TK_USUARIOS_ELIMINAR_P(
        p_ID_USUARIO                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_USUARIOS WHERE ID_USUARIO = p_id_usuario;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_USUARIOS_ELIMINAR_P + ': ' || SQLERRM;
    END TK_USUARIOS_ELIMINAR_P;

    FUNCTION TK_USUARIOS_CONSULTAR_F(
        p_ID_USUARIO                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_USUARIOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_USUARIO,
                   NOMBRE,
                   APELLIDO,
                   USERNAME,
                   EMAIL,
                   TELEFONO,
                   UBICACION,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_USUARIOS
             WHERE p_id_usuario IS NULL
                OR ID_USUARIO = p_id_usuario
             ORDER BY ID_USUARIO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' + TK_USUARIOS_CONSULTAR_F + ': ' || SQLERRM);
    END TK_USUARIOS_CONSULTAR_F;

END TK_USUARIOS_CRUD_PKG;
/

