-- Body CRUD para TICKETS.TK_CATEGORIAS_CRUD_PKG
CONNECT TICKETS/Tickets123
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_CATEGORIAS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_CATEGORIAS_CRUD_PKG';

    PROCEDURE TK_CATEGORIAS_CREAR_P(
        p_id_categoria                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        p_nombre_categoria               IN  TICKETS.TK_CATEGORIAS.NOMBRE_CATEGORIA%TYPE,
        p_descripcion                    IN  TICKETS.TK_CATEGORIAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CATEGORIAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CATEGORIAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CATEGORIAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CATEGORIAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CATEGORIAS.ACTIVA%TYPE,
        po_ID_CATEGORIA_generado              OUT TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CATEGORIAS_CREAR_P');
        po_ID_CATEGORIA_generado := NULL;
        INSERT INTO TICKETS.TK_CATEGORIAS (
            ID_CATEGORIA,
            NOMBRE_CATEGORIA,
            DESCRIPCION,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVA
        ) VALUES (
            p_id_categoria,
            p_nombre_categoria,
            p_descripcion,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activa
        ) RETURNING ID_CATEGORIA INTO po_ID_CATEGORIA_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_CATEGORIA_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_CATEGORIA_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_CATEGORIAS_CREAR_P + ': ' || SQLERRM;
    END TK_CATEGORIAS_CREAR_P;

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
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CATEGORIAS_ACTUALIZAR_P');
        UPDATE TICKETS.TK_CATEGORIAS SET
            NOMBRE_CATEGORIA = p_nombre_categoria,
            DESCRIPCION = p_descripcion,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVA = p_activa
         WHERE ID_CATEGORIA = p_id_categoria;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_CATEGORIAS_ACTUALIZAR_P + ': ' || SQLERRM;
    END TK_CATEGORIAS_ACTUALIZAR_P;

    PROCEDURE TK_CATEGORIAS_ELIMINAR_P(
        p_ID_CATEGORIA                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CATEGORIAS_ELIMINAR_P');
        DELETE FROM TICKETS.TK_CATEGORIAS WHERE ID_CATEGORIA = p_id_categoria;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' + TK_CATEGORIAS_ELIMINAR_P + ': ' || SQLERRM;
    END TK_CATEGORIAS_ELIMINAR_P;

    FUNCTION TK_CATEGORIAS_CONSULTAR_F(
        p_ID_CATEGORIA                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CATEGORIAS_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_CATEGORIA,
                   NOMBRE_CATEGORIA,
                   DESCRIPCION,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVA
              FROM TICKETS.TK_CATEGORIAS
             WHERE p_id_categoria IS NULL
                OR ID_CATEGORIA = p_id_categoria
             ORDER BY ID_CATEGORIA;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' + TK_CATEGORIAS_CONSULTAR_F + ': ' || SQLERRM);
    END TK_CATEGORIAS_CONSULTAR_F;

END TK_CATEGORIAS_CRUD_PKG;
/

