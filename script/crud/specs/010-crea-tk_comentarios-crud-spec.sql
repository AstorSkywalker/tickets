-- Spec CRUD para TICKETS.TK_COMENTARIOS_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_COMENTARIOS_CRUD_PKG AS

    PROCEDURE TK_COMENTARIOS_CREAR_P(
        p_id_comentario                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario                     IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario                     IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_COMENTARIOS.ACTIVO%TYPE,
        po_ID_COMENTARIO_generado      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_COMENTARIOS_ACTUALIZAR_P(
        p_id_comentario                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario                     IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario                     IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_COMENTARIOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_COMENTARIOS_ELIMINAR_P(
        p_ID_COMENTARIO                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_COMENTARIOS_CONSULTAR_F(
        p_ID_COMENTARIO                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_COMENTARIOS_CRUD_PKG;
/

