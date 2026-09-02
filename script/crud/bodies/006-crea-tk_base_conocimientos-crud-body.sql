-- Body CRUD para TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_BASE_CONOCIMIENTOS_CRUD_PKG';

    PROCEDURE TK_BASE_CONOCIMIENTOS_CREAR_P(
        p_id_base_conocimiento           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        p_titulo                         IN  TICKETS.TK_BASE_CONOCIMIENTOS.TITULO%TYPE,
        p_descripcion                    IN  TICKETS.TK_BASE_CONOCIMIENTOS.DESCRIPCION%TYPE,
        p_palabras_clave                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.PALABRAS_CLAVE%TYPE,
        p_publicado                      IN  TICKETS.TK_BASE_CONOCIMIENTOS.PUBLICADO%TYPE,
        p_id_usuario_autor               IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_USUARIO_AUTOR%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_BASE_CONOCIMIENTO_generado              OUT TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_BASE_CONOCIMIENTOS_CREAR_P');
        po_ID_BASE_CONOCIMIENTO_generado := NULL;
        INSERT INTO TICKETS.TK_BASE_CONOCIMIENTOS (
            ID_BASE_CONOCIMIENTO,
            TITULO,
            DESCRIPCION,
            PALABRAS_CLAVE,
            PUBLICADO,
            ID_USUARIO_AUTOR,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION
        ) VALUES (
            p_id_base_conocimiento,
            p_titulo,
            p_descripcion,
            p_palabras_clave,
            p_publicado,
            p_id_usuario_autor,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion
        ) RETURNING ID_BASE_CONOCIMIENTO INTO po_ID_BASE_CONOCIMIENTO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_BASE_CONOCIMIENTO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_BASE_CONOCIMIENTO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_BASE_CONOCIMIENTOS_CREAR_P' || ': ' || SQLERRM;
    END TK_BASE_CONOCIMIENTOS_CREAR_P;

    PROCEDURE TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P(
        p_id_base_conocimiento           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        p_titulo                         IN  TICKETS.TK_BASE_CONOCIMIENTOS.TITULO%TYPE,
        p_descripcion                    IN  TICKETS.TK_BASE_CONOCIMIENTOS.DESCRIPCION%TYPE,
        p_palabras_clave                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.PALABRAS_CLAVE%TYPE,
        p_publicado                      IN  TICKETS.TK_BASE_CONOCIMIENTOS.PUBLICADO%TYPE,
        p_id_usuario_autor               IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_USUARIO_AUTOR%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_BASE_CONOCIMIENTOS SET
            TITULO = p_titulo,
            DESCRIPCION = p_descripcion,
            PALABRAS_CLAVE = p_palabras_clave,
            PUBLICADO = p_publicado,
            ID_USUARIO_AUTOR = p_id_usuario_autor,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion
         WHERE ID_BASE_CONOCIMIENTO = p_id_base_conocimiento;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P;

    PROCEDURE TK_BASE_CONOCIMIENTOS_ELIMINAR_P(
        p_ID_BASE_CONOCIMIENTO           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_BASE_CONOCIMIENTOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_BASE_CONOCIMIENTOS WHERE ID_BASE_CONOCIMIENTO = p_id_base_conocimiento;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_BASE_CONOCIMIENTOS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_BASE_CONOCIMIENTOS_ELIMINAR_P;

    FUNCTION TK_BASE_CONOCIMIENTOS_CONSULTAR_F(
        p_ID_BASE_CONOCIMIENTO           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_BASE_CONOCIMIENTOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_BASE_CONOCIMIENTO,
                   TITULO,
                   DESCRIPCION,
                   PALABRAS_CLAVE,
                   PUBLICADO,
                   ID_USUARIO_AUTOR,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION
              FROM TICKETS.TK_BASE_CONOCIMIENTOS
             WHERE p_id_base_conocimiento IS NULL
                OR ID_BASE_CONOCIMIENTO = p_id_base_conocimiento
             ORDER BY ID_BASE_CONOCIMIENTO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_BASE_CONOCIMIENTOS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_BASE_CONOCIMIENTOS_CONSULTAR_F;

END TK_BASE_CONOCIMIENTOS_CRUD_PKG;
/

