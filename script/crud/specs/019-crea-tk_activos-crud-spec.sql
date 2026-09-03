-- Spec CRUD para TICKETS.TK_ACTIVOS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_ACTIVOS_CRUD_PKG AS

    PROCEDURE TK_ACTIVOS_CREAR_P(
        p_id_activo                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        p_numero_serie                   IN  TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE,
        p_numero_inventario              IN  TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE,
        p_descripcion_activo             IN  TICKETS.TK_ACTIVOS.DESCRIPCION_ACTIVO%TYPE,
        p_marca                          IN  TICKETS.TK_ACTIVOS.MARCA%TYPE,
        p_modelo                         IN  TICKETS.TK_ACTIVOS.MODELO%TYPE,
        p_id_tipo_activo                 IN  TICKETS.TK_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_id_usuario_asignado            IN  TICKETS.TK_ACTIVOS.ID_USUARIO_ASIGNADO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_ACTIVOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ACTIVOS.ACTIVO%TYPE,
        po_ID_ACTIVO_generado          OUT TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_ACTUALIZAR_P(
        p_id_activo                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        p_numero_serie                   IN  TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE,
        p_numero_inventario              IN  TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE,
        p_descripcion_activo             IN  TICKETS.TK_ACTIVOS.DESCRIPCION_ACTIVO%TYPE,
        p_marca                          IN  TICKETS.TK_ACTIVOS.MARCA%TYPE,
        p_modelo                         IN  TICKETS.TK_ACTIVOS.MODELO%TYPE,
        p_id_tipo_activo                 IN  TICKETS.TK_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_id_usuario_asignado            IN  TICKETS.TK_ACTIVOS.ID_USUARIO_ASIGNADO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_ACTIVOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ACTIVOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_ELIMINAR_P(
        p_ID_ACTIVO                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ACTIVOS_CONSULTAR_F(
        p_ID_ACTIVO                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ACTIVOS_CRUD_PKG;
/

