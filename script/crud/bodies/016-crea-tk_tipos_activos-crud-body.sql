-- Body CRUD para TICKETS.TK_TIPOS_ACTIVOS_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_TIPOS_ACTIVOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_TIPOS_ACTIVOS_CRUD_PKG';

    PROCEDURE TK_TIPOS_ACTIVOS_CREAR_P(
        p_id_tipo_activo                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_nombre_tipo_activo             IN  TICKETS.TK_TIPOS_ACTIVOS.NOMBRE_TIPO_ACTIVO%TYPE,
        p_descripcion_tipo_activo        IN  TICKETS.TK_TIPOS_ACTIVOS.DESCRIPCION_TIPO_ACTIVO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TIPOS_ACTIVOS.ACTIVO%TYPE,
        po_ID_TIPO_ACTIVO_generado              OUT TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TIPOS_ACTIVOS_CREAR_P');
        po_ID_TIPO_ACTIVO_generado := NULL;
        INSERT INTO TICKETS.TK_TIPOS_ACTIVOS (
            ID_TIPO_ACTIVO,
            NOMBRE_TIPO_ACTIVO,
            DESCRIPCION_TIPO_ACTIVO,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVO
        ) VALUES (
            p_id_tipo_activo,
            p_nombre_tipo_activo,
            p_descripcion_tipo_activo,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activo
        ) RETURNING ID_TIPO_ACTIVO INTO po_ID_TIPO_ACTIVO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_TIPO_ACTIVO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_TIPO_ACTIVO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TIPOS_ACTIVOS_CREAR_P' || ': ' || SQLERRM;
    END TK_TIPOS_ACTIVOS_CREAR_P;

    PROCEDURE TK_TIPOS_ACTIVOS_ACTUALIZAR_P(
        p_id_tipo_activo                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_nombre_tipo_activo             IN  TICKETS.TK_TIPOS_ACTIVOS.NOMBRE_TIPO_ACTIVO%TYPE,
        p_descripcion_tipo_activo        IN  TICKETS.TK_TIPOS_ACTIVOS.DESCRIPCION_TIPO_ACTIVO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TIPOS_ACTIVOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TIPOS_ACTIVOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_TIPOS_ACTIVOS SET
            NOMBRE_TIPO_ACTIVO = p_nombre_tipo_activo,
            DESCRIPCION_TIPO_ACTIVO = p_descripcion_tipo_activo,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVO = p_activo
         WHERE ID_TIPO_ACTIVO = p_id_tipo_activo;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TIPOS_ACTIVOS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_TIPOS_ACTIVOS_ACTUALIZAR_P;

    PROCEDURE TK_TIPOS_ACTIVOS_ELIMINAR_P(
        p_ID_TIPO_ACTIVO                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TIPOS_ACTIVOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_TIPOS_ACTIVOS WHERE ID_TIPO_ACTIVO = p_id_tipo_activo;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_TIPOS_ACTIVOS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_TIPOS_ACTIVOS_ELIMINAR_P;

    FUNCTION TK_TIPOS_ACTIVOS_CONSULTAR_F(
        p_ID_TIPO_ACTIVO                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_TIPOS_ACTIVOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_TIPO_ACTIVO,
                   NOMBRE_TIPO_ACTIVO,
                   DESCRIPCION_TIPO_ACTIVO,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_TIPOS_ACTIVOS
             WHERE p_id_tipo_activo IS NULL
                OR ID_TIPO_ACTIVO = p_id_tipo_activo
             ORDER BY ID_TIPO_ACTIVO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_TIPOS_ACTIVOS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_TIPOS_ACTIVOS_CONSULTAR_F;

END TK_TIPOS_ACTIVOS_CRUD_PKG;
/

