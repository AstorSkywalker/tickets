-- Spec CRUD para TICKETS.TK_ENCUESTAS_CRUD_PKG
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_ENCUESTAS_CRUD_PKG AS

    PROCEDURE TK_ENCUESTAS_CREAR_P(
        p_id_encuesta                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion                   IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario                     IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_ENCUESTA_generado        OUT TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ENCUESTAS_ACTUALIZAR_P(
        p_id_encuesta                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion                   IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario                     IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ENCUESTAS_ELIMINAR_P(
        p_ID_ENCUESTA                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ENCUESTAS_CONSULTAR_F(
        p_ID_ENCUESTA                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ENCUESTAS_CRUD_PKG;
/

