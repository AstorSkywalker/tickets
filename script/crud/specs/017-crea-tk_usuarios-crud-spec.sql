-- Spec CRUD para TICKETS.TK_USUARIOS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_USUARIOS_CRUD_PKG AS

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
        po_ID_USUARIO_generado         OUT TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

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
    );

    PROCEDURE TK_USUARIOS_ELIMINAR_P(
        p_ID_USUARIO                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_USUARIOS_CONSULTAR_F(
        p_ID_USUARIO                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_USUARIOS_CRUD_PKG;
/

