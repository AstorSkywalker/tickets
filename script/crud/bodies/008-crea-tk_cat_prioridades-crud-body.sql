-- Body CRUD para TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_CAT_PRIORIDADES_CRUD_PKG';

    PROCEDURE TK_CAT_PRIORIDADES_CREAR_P(
        p_id_prioridad                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        p_nombre_prioridad               IN  TICKETS.TK_CAT_PRIORIDADES.NOMBRE_PRIORIDAD%TYPE,
        p_nivel                          IN  TICKETS.TK_CAT_PRIORIDADES.NIVEL%TYPE,
        p_tiempo_sla_horas               IN  TICKETS.TK_CAT_PRIORIDADES.TIEMPO_SLA_HORAS%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CAT_PRIORIDADES.ACTIVA%TYPE,
        po_ID_PRIORIDAD_generado              OUT TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_PRIORIDADES_CREAR_P');
        po_ID_PRIORIDAD_generado := NULL;
        INSERT INTO TICKETS.TK_CAT_PRIORIDADES (
            ID_PRIORIDAD,
            NOMBRE_PRIORIDAD,
            NIVEL,
            TIEMPO_SLA_HORAS,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVA
        ) VALUES (
            p_id_prioridad,
            p_nombre_prioridad,
            p_nivel,
            p_tiempo_sla_horas,
            p_fecha_creacion,
            p_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            p_activa
        ) RETURNING ID_PRIORIDAD INTO po_ID_PRIORIDAD_generado;
        pv_resultado := 'OK: REGISTRO CREADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_PRIORIDAD_generado := NULL;
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            po_ID_PRIORIDAD_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_CAT_PRIORIDADES_CREAR_P' || ': ' || SQLERRM;
    END TK_CAT_PRIORIDADES_CREAR_P;

    PROCEDURE TK_CAT_PRIORIDADES_ACTUALIZAR_P(
        p_id_prioridad                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        p_nombre_prioridad               IN  TICKETS.TK_CAT_PRIORIDADES.NOMBRE_PRIORIDAD%TYPE,
        p_nivel                          IN  TICKETS.TK_CAT_PRIORIDADES.NIVEL%TYPE,
        p_tiempo_sla_horas               IN  TICKETS.TK_CAT_PRIORIDADES.TIEMPO_SLA_HORAS%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CAT_PRIORIDADES.ACTIVA%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_PRIORIDADES_ACTUALIZAR_P');
        UPDATE TICKETS.TK_CAT_PRIORIDADES SET
            NOMBRE_PRIORIDAD = p_nombre_prioridad,
            NIVEL = p_nivel,
            TIEMPO_SLA_HORAS = p_tiempo_sla_horas,
            FECHA_CREACION = p_fecha_creacion,
            USUARIO_CREACION = p_usuario_creacion,
            FECHA_ACTUALIZACION = p_fecha_actualizacion,
            USUARIO_ACTUALIZACION = p_usuario_actualizacion,
            ACTIVA = p_activa
         WHERE ID_PRIORIDAD = p_id_prioridad;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ACTUALIZADO';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: REGISTRO DUPLICADO. ' || SQLERRM;
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_CAT_PRIORIDADES_ACTUALIZAR_P' || ': ' || SQLERRM;
    END TK_CAT_PRIORIDADES_ACTUALIZAR_P;

    PROCEDURE TK_CAT_PRIORIDADES_ELIMINAR_P(
        p_ID_PRIORIDAD                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        pv_resultado                 OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_PRIORIDADES_ELIMINAR_P');
        DELETE FROM TICKETS.TK_CAT_PRIORIDADES WHERE ID_PRIORIDAD = p_id_prioridad;
        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: REGISTRO NO EXISTE';
            RETURN;
        END IF;
        pv_resultado := 'OK: REGISTRO ELIMINADO';
    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.' || 'TK_CAT_PRIORIDADES_ELIMINAR_P' || ': ' || SQLERRM;
    END TK_CAT_PRIORIDADES_ELIMINAR_P;

    FUNCTION TK_CAT_PRIORIDADES_CONSULTAR_F(
        p_ID_PRIORIDAD                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(c_modulo, 'TK_CAT_PRIORIDADES_CONSULTAR_F');
        OPEN v_cursor FOR
            SELECT ID_PRIORIDAD,
                   NOMBRE_PRIORIDAD,
                   NIVEL,
                   TIEMPO_SLA_HORAS,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVA
              FROM TICKETS.TK_CAT_PRIORIDADES
             WHERE p_id_prioridad IS NULL
                OR ID_PRIORIDAD = p_id_prioridad
             ORDER BY ID_PRIORIDAD;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.' || 'TK_CAT_PRIORIDADES_CONSULTAR_F' || ': ' || SQLERRM);
    END TK_CAT_PRIORIDADES_CONSULTAR_F;

END TK_CAT_PRIORIDADES_CRUD_PKG;
/

