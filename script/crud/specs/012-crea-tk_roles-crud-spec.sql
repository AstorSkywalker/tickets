-- Spec CRUD para TICKETS.TK_ROLES_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_ROLES_CRUD_PKG AS

    PROCEDURE TK_ROLES_CREAR_P(
        p_id_rol                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE,
        p_nombre_rol                     IN  TICKETS.TK_ROLES.NOMBRE_ROL%TYPE,
        p_descripcion                    IN  TICKETS.TK_ROLES.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ROLES.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ROLES.ACTIVO%TYPE,
        po_ID_ROL_generado             OUT TICKETS.TK_ROLES.ID_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ROLES_ACTUALIZAR_P(
        p_id_rol                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE,
        p_nombre_rol                     IN  TICKETS.TK_ROLES.NOMBRE_ROL%TYPE,
        p_descripcion                    IN  TICKETS.TK_ROLES.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ROLES.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ROLES.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ROLES_ELIMINAR_P(
        p_ID_ROL                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ROLES_CONSULTAR_F(
        p_ID_ROL                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ROLES_CRUD_PKG;
/

