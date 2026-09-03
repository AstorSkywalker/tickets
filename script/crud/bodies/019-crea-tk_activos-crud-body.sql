-- Body CRUD para TICKETS.TK_ACTIVOS_CRUD_PKG
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_ACTIVOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_ACTIVOS_CRUD_PKG';

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
        po_ID_ACTIVO_generado              OUT TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_CREAR_P');
        po_ID_ACTIVO_generado := NULL;
        INSERT INTO TICKETS.TK_ACTIVOS (
            ID_ACTIVO,
            NUMERO_SERIE,
            NUMERO_INVENTARIO,
            DESCRIPCION_ACTIVO,
            MARCA,
            MODELO,
            ID_TIPO_ACTIVO,
            ID_USUARIO_ASIGNADO,
            UBICACION,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVO
        ) VALUES (
            p_id_activo,
            p_numero_serie,
            p_numero_inventario,
            p_descripcion_activo,
            p_marca,
            p_modelo,
            p_id_tipo_activo,
            p_id_usuario_asignado,
            p_ubicacion,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activo
        ) RETURNING ID_ACTIVO INTO po_ID_ACTIVO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_ACTIVO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_ACTIVO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ACTIVOS_CREAR_P' || ': ' || SQLERRM;
    END TK_ACTIVOS_CREAR_P;

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
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_ACTIVOS SET
            NUMERO_SERIE = p_numero_serie,
            NUMERO_INVENTARIO = p_numero_inventario,
            DESCRIPCION_ACTIVO = p_descripcion_activo,
            MARCA = p_marca,
            MODELO = p_modelo,
            ID_TIPO_ACTIVO = p_id_tipo_activo,
            ID_USUARIO_ASIGNADO = p_id_usuario_asignado,
            UBICACION = p_ubicacion,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVO = p_activo
         WHERE ID_ACTIVO = p_id_activo;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ACTIVOS_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_ACTIVOS_ACTUALIZAR_P;

    PROCEDURE TK_ACTIVOS_ELIMINAR_P(
        p_ID_ACTIVO                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_ACTIVOS WHERE ID_ACTIVO = p_id_activo;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_ACTIVOS_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_ACTIVOS_ELIMINAR_P;

    FUNCTION TK_ACTIVOS_CONSULTAR_F(
        p_ID_ACTIVO                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_ACTIVOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_ACTIVO,
                   NUMERO_SERIE,
                   NUMERO_INVENTARIO,
                   DESCRIPCION_ACTIVO,
                   MARCA,
                   MODELO,
                   ID_TIPO_ACTIVO,
                   ID_USUARIO_ASIGNADO,
                   UBICACION,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_ACTIVOS
             WHERE p_id_activo IS NULL
                OR ID_ACTIVO = p_id_activo
             ORDER BY ID_ACTIVO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_ACTIVOS_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_ACTIVOS_CONSULTAR_F;

END TK_ACTIVOS_CRUD_PKG;
/

