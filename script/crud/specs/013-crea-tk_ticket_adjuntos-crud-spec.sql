-- Spec CRUD para TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG AS

    PROCEDURE TK_TICKET_ADJUNTOS_CREAR_P(
        p_id_adjunto                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKET_ADJUNTOS.ID_TICKET%TYPE,
        p_nombre_archivo                 IN  TICKETS.TK_TICKET_ADJUNTOS.NOMBRE_ARCHIVO%TYPE,
        p_extension                      IN  TICKETS.TK_TICKET_ADJUNTOS.EXTENSION%TYPE,
        p_mime_type                      IN  TICKETS.TK_TICKET_ADJUNTOS.MIME_TYPE%TYPE,
        p_tamano_bytes                   IN  TICKETS.TK_TICKET_ADJUNTOS.TAMANO_BYTES%TYPE,
        p_archivo                        IN  TICKETS.TK_TICKET_ADJUNTOS.ARCHIVO%TYPE,
        p_hash_sha256                    IN  TICKETS.TK_TICKET_ADJUNTOS.HASH_SHA256%TYPE,
        p_id_usuario                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_USUARIO%TYPE,
        p_fecha_carga                    IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CARGA%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TICKET_ADJUNTOS.ACTIVO%TYPE,
        po_ID_ADJUNTO_generado         OUT TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKET_ADJUNTOS_ACTUALIZAR_P(
        p_id_adjunto                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKET_ADJUNTOS.ID_TICKET%TYPE,
        p_nombre_archivo                 IN  TICKETS.TK_TICKET_ADJUNTOS.NOMBRE_ARCHIVO%TYPE,
        p_extension                      IN  TICKETS.TK_TICKET_ADJUNTOS.EXTENSION%TYPE,
        p_mime_type                      IN  TICKETS.TK_TICKET_ADJUNTOS.MIME_TYPE%TYPE,
        p_tamano_bytes                   IN  TICKETS.TK_TICKET_ADJUNTOS.TAMANO_BYTES%TYPE,
        p_archivo                        IN  TICKETS.TK_TICKET_ADJUNTOS.ARCHIVO%TYPE,
        p_hash_sha256                    IN  TICKETS.TK_TICKET_ADJUNTOS.HASH_SHA256%TYPE,
        p_id_usuario                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_USUARIO%TYPE,
        p_fecha_carga                    IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CARGA%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TICKET_ADJUNTOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKET_ADJUNTOS_ELIMINAR_P(
        p_ID_ADJUNTO                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TICKET_ADJUNTOS_CONSULTAR_F(
        p_ID_ADJUNTO                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TICKET_ADJUNTOS_CRUD_PKG;
/

