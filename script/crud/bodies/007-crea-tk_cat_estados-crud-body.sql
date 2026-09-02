-- Body CRUD para TICKETS.TK_CAT_ESTADOS_CRUD_PKG
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_CAT_ESTADOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_CAT_ESTADOS_CRUD_PKG';

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
        po_ID_ESTADO_generado              OUT TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_ESTADOS_CREAR_P');
        po_ID_ESTADO_generado := NULL;
        INSERT INTO TICKETS.TK_CAT_ESTADOS (
            ID_ESTADO,
            NOMBRE_ESTADO,
            DESCRIPCION_ESTADO,
            CERRADO,
            ORDEN_VISUALIZACION,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVO
        ) VALUES (
            p_id_estado,
            p_nombre_estado,
            p_descripcion_estado,
            p_cerrado,
            p_orden_visualizacion,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activo
        ) RETURNING ID_ESTADO INTO po_ID_ESTADO_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_ESTADO_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_ESTADO_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_CAT_ESTADOS_CREAR_P + ': ' || SQLERRM;
    END TK_CAT_ESTADOS_CREAR_P;

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
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_ESTADOS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_CAT_ESTADOS SET
            NOMBRE_ESTADO = p_nombre_estado,
            DESCRIPCION_ESTADO = p_descripcion_estado,
            CERRADO = p_cerrado,
            ORDEN_VISUALIZACION = p_orden_visualizacion,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVO = p_activo
         WHERE ID_ESTADO = p_id_estado;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_CAT_ESTADOS_ACTUALIZAR_P + ': ' || SQLERRM;
    END TK_CAT_ESTADOS_ACTUALIZAR_P;

    PROCEDURE TK_CAT_ESTADOS_ELIMINAR_P(
        p_ID_ESTADO                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_ESTADOS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_CAT_ESTADOS WHERE ID_ESTADO = p_id_estado;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_CAT_ESTADOS_ELIMINAR_P + ': ' || SQLERRM;
    END TK_CAT_ESTADOS_ELIMINAR_P;

    FUNCTION TK_CAT_ESTADOS_CONSULTAR_F(
        p_ID_ESTADO                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_ESTADOS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_ESTADO,
                   NOMBRE_ESTADO,
                   DESCRIPCION_ESTADO,
                   CERRADO,
                   ORDEN_VISUALIZACION,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_CAT_ESTADOS
             WHERE p_id_estado IS NULL
                OR ID_ESTADO = p_id_estado
             ORDER BY ID_ESTADO;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' + TK_CAT_ESTADOS_CONSULTAR_F + ': ' || SQLERRM);
    END TK_CAT_ESTADOS_CONSULTAR_F;

END TK_CAT_ESTADOS_CRUD_PKG;
/

