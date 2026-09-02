-- Body CRUD para TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_TICKET_ADJUNTOS_CRUD_PKG';

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
        po_ID_ADJUNTO_generado              OUT TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKET_ADJUNTOS_CREAR_P');
        po_ID_ADJUNTO_generado := NULL;
        INSERT INTO TICKETS.TK_TICKET_ADJUNTOS (
            ID_ADJUNTO,
            ID_TICKET,
            NOMBRE_ARCHIVO,
            EXTENSION,
            MIME_TYPE,
            TAMANO_BYTES,
            ARCHIVO,
            HASH_SHA256,
            ID_USUARIO,
            FECHA_CARGA,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVO
        ) VALUES (
            p_id_adjunto,
            p_id_ticket,
            p_nombre_archivo,
            p_extension,
            p_mime_type,
            p_tamano_bytes,
            p_archivo,
            p_hash_sha256,
            p_id_usuario,
            p_fecha_carga,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activo
        ) RETURNING ID_ADJUNTO INTO po_ID_ADJUNTO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_ADJUNTO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_ADJUNTO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_TICKET_ADJUNTOS_CREAR_P + ': ' || SQLERRM;
    END TK_TICKET_ADJUNTOS_CREAR_P;

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
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKET_ADJUNTOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_TICKET_ADJUNTOS SET
            ID_TICKET = p_id_ticket,
            NOMBRE_ARCHIVO = p_nombre_archivo,
            EXTENSION = p_extension,
            MIME_TYPE = p_mime_type,
            TAMANO_BYTES = p_tamano_bytes,
            ARCHIVO = p_archivo,
            HASH_SHA256 = p_hash_sha256,
            ID_USUARIO = p_id_usuario,
            FECHA_CARGA = p_fecha_carga,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVO = p_activo
         WHERE ID_ADJUNTO = p_id_adjunto;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_TICKET_ADJUNTOS_ACTUALIZAR_P + ': ' || SQLERRM;
    END TK_TICKET_ADJUNTOS_ACTUALIZAR_P;

    PROCEDURE TK_TICKET_ADJUNTOS_ELIMINAR_P(
        p_ID_ADJUNTO                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKET_ADJUNTOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_TICKET_ADJUNTOS WHERE ID_ADJUNTO = p_id_adjunto;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_TICKET_ADJUNTOS_ELIMINAR_P + ': ' || SQLERRM;
    END TK_TICKET_ADJUNTOS_ELIMINAR_P;

    FUNCTION TK_TICKET_ADJUNTOS_CONSULTAR_F(
        p_ID_ADJUNTO                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TICKET_ADJUNTOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_ADJUNTO,
                   ID_TICKET,
                   NOMBRE_ARCHIVO,
                   EXTENSION,
                   MIME_TYPE,
                   TAMANO_BYTES,
                   ARCHIVO,
                   HASH_SHA256,
                   ID_USUARIO,
                   FECHA_CARGA,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_TICKET_ADJUNTOS
             WHERE p_id_adjunto IS NULL
                OR ID_ADJUNTO = p_id_adjunto
             ORDER BY ID_ADJUNTO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' + TK_TICKET_ADJUNTOS_CONSULTAR_F + ': ' || SQLERRM);
    END TK_TICKET_ADJUNTOS_CONSULTAR_F;

END TK_TICKET_ADJUNTOS_CRUD_PKG;
/

