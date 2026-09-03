-- Spec CRUD para TICKETS.TK_AREAS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_AREAS_CRUD_PKG AS

    PROCEDURE TK_AREAS_CREAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        p_nombre_area                    IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        p_descripcion                    IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_AREAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_AREAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_AREAS.ACTIVA%TYPE,
        po_ID_AREA_generado            OUT TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        p_nombre_area                    IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        p_descripcion                    IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_AREAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_AREAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_AREAS.ACTIVA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_AREAS_ELIMINAR_P(
        p_ID_AREA                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_AREAS_CONSULTAR_F(
        p_ID_AREA                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_AREAS_CRUD_PKG;
/

