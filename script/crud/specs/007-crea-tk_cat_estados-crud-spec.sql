-- Spec CRUD para TICKETS.TK_CAT_ESTADOS_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_CAT_ESTADOS_CRUD_PKG AS

    PROCEDURE TK_CAT_ESTADOS_CREAR_P(
        p_id_estado                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        p_nombre_estado                  IN  TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE,
        p_descripcion_estado             IN  TICKETS.TK_CAT_ESTADOS.DESCRIPCION_ESTADO%TYPE,
        p_cerrado                        IN  TICKETS.TK_CAT_ESTADOS.CERRADO%TYPE,
        p_orden_visualizacion            IN  TICKETS.TK_CAT_ESTADOS.ORDEN_VISUALIZACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_ESTADOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_ESTADOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_ESTADOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_ESTADOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_CAT_ESTADOS.ACTIVO%TYPE,
        po_ID_ESTADO_generado          OUT TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CAT_ESTADOS_ACTUALIZAR_P(
        p_id_estado                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        p_nombre_estado                  IN  TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE,
        p_descripcion_estado             IN  TICKETS.TK_CAT_ESTADOS.DESCRIPCION_ESTADO%TYPE,
        p_cerrado                        IN  TICKETS.TK_CAT_ESTADOS.CERRADO%TYPE,
        p_orden_visualizacion            IN  TICKETS.TK_CAT_ESTADOS.ORDEN_VISUALIZACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_ESTADOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_ESTADOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_ESTADOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_ESTADOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_CAT_ESTADOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CAT_ESTADOS_ELIMINAR_P(
        p_ID_ESTADO                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_CAT_ESTADOS_CONSULTAR_F(
        p_ID_ESTADO                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_CAT_ESTADOS_CRUD_PKG;
/

