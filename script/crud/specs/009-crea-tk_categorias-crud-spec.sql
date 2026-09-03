-- Spec CRUD para TICKETS.TK_CATEGORIAS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_CATEGORIAS_CRUD_PKG AS

    PROCEDURE TK_CATEGORIAS_CREAR_P(
        p_id_categoria                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        p_nombre_categoria               IN  TICKETS.TK_CATEGORIAS.NOMBRE_CATEGORIA%TYPE,
        p_descripcion                    IN  TICKETS.TK_CATEGORIAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CATEGORIAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CATEGORIAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CATEGORIAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CATEGORIAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CATEGORIAS.ACTIVA%TYPE,
        po_ID_CATEGORIA_generado       OUT TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CATEGORIAS_ACTUALIZAR_P(
        p_id_categoria                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        p_nombre_categoria               IN  TICKETS.TK_CATEGORIAS.NOMBRE_CATEGORIA%TYPE,
        p_descripcion                    IN  TICKETS.TK_CATEGORIAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CATEGORIAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CATEGORIAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CATEGORIAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CATEGORIAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CATEGORIAS.ACTIVA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CATEGORIAS_ELIMINAR_P(
        p_ID_CATEGORIA                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_CATEGORIAS_CONSULTAR_F(
        p_ID_CATEGORIA                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_CATEGORIAS_CRUD_PKG;
/

