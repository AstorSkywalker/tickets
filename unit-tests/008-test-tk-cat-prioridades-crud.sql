-- Pruebas unitarias para TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_prioridad          TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_id_generado           TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_nombre                TICKETS.TK_CAT_PRIORIDADES.NOMBRE_PRIORIDAD%TYPE;
    v_nivel                 TICKETS.TK_CAT_PRIORIDADES.NIVEL%TYPE;
    v_sla                   TICKETS.TK_CAT_PRIORIDADES.TIEMPO_SLA_HORAS%TYPE;
    v_fecha_creacion        TICKETS.TK_CAT_PRIORIDADES.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_CAT_PRIORIDADES.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_CAT_PRIORIDADES.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_CAT_PRIORIDADES.USUARIO_ACTUALIZACION%TYPE;
    v_activa                TICKETS.TK_CAT_PRIORIDADES.ACTIVA%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_nombre_prueba         VARCHAR2(50) :=
        'TEST PRIORIDAD ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_CAT_PRIORIDADES_CRUD_PKG ===');

    -- Crear y validar el ID generado por la columna identity.
    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_CREAR_P(
        p_id_prioridad            => NULL,
        p_nombre_prioridad        => v_nombre_prueba,
        p_nivel                   => 99,
        p_tiempo_sla_horas        => 99.50,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activa                  => 'S',
        po_ID_PRIORIDAD_generado  => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear prioridad valida');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_PRIORIDAD');
    v_id_prioridad := v_id_generado;

    -- Consultar mediante SYS_REFCURSOR.
    v_cursor := TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_CONSULTAR_F(v_id_prioridad);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_nivel, v_sla,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activa;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_prioridad, 'consultar prioridad por ID');
    afirmar(v_nombre = v_nombre_prueba, 'devolver nombre correcto');
    afirmar(v_nivel = 99, 'devolver nivel correcto');
    afirmar(v_sla = 99.50, 'devolver SLA correcto');
    afirmar(v_activa = 'S', 'devolver estado activo');

    -- Actualizar todos los campos expuestos por el spec.
    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_ACTUALIZAR_P(
        p_id_prioridad            => v_id_prioridad,
        p_nombre_prioridad        => v_nombre_prueba || ' ACTUALIZADA',
        p_nivel                   => 100,
        p_tiempo_sla_horas        => 120.25,
        p_fecha_creacion          => v_fecha_creacion,
        p_usuario_creacion        => v_usuario_creacion,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activa                  => 'N',
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar prioridad valida');

    -- Validar nombre y nivel duplicados.
    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_CREAR_P(
        p_id_prioridad            => NULL,
        p_nombre_prioridad        => v_nombre_prueba || ' ACTUALIZADA',
        p_nivel                   => 101,
        p_tiempo_sla_horas        => 1,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activa                  => 'S',
        po_ID_PRIORIDAD_generado  => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre duplicado');

    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_CREAR_P(
        p_id_prioridad            => NULL,
        p_nombre_prioridad        => v_nombre_prueba || ' NIVEL DUPLICADO',
        p_nivel                   => 100,
        p_tiempo_sla_horas        => 1,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activa                  => 'S',
        po_ID_PRIORIDAD_generado  => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nivel duplicado');

    -- Validar nombre obligatorio.
    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_CREAR_P(
        p_id_prioridad            => NULL,
        p_nombre_prioridad        => NULL,
        p_nivel                   => 102,
        p_tiempo_sla_horas        => 1,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activa                  => 'S',
        po_ID_PRIORIDAD_generado  => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre nulo');

    -- Validar dominios y rangos numericos.
    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_ACTUALIZAR_P(
        p_id_prioridad            => v_id_prioridad,
        p_nombre_prioridad        => v_nombre_prueba || ' ACTUALIZADA',
        p_nivel                   => 0,
        p_tiempo_sla_horas        => -1,
        p_fecha_creacion          => v_fecha_creacion,
        p_usuario_creacion        => v_usuario_creacion,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activa                  => 'X',
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar dominios y rangos invalidos');

    -- Eliminar y validar que el registro ya no exista.
    TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_ELIMINAR_P(
        p_ID_PRIORIDAD => v_id_prioridad,
        pv_resultado   => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar prioridad');

    v_cursor := TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG.TK_CAT_PRIORIDADES_CONSULTAR_F(v_id_prioridad);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_nivel, v_sla,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activa;
    afirmar(v_cursor%NOTFOUND, 'no devolver prioridad eliminada');
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_CAT_PRIORIDADES PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_CAT_PRIORIDADES FALLO ===');
        RAISE;
END;
/
