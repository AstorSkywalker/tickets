-- Pruebas unitarias para TICKETS.TK_CAT_ESTADOS_CRUD_PKG
CONNECT TICKETS/Tickets123@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_estado             TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE;
    v_id_generado           TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE;
    v_nombre                TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE;
    v_descripcion           TICKETS.TK_CAT_ESTADOS.DESCRIPCION_ESTADO%TYPE;
    v_cerrado               TICKETS.TK_CAT_ESTADOS.CERRADO%TYPE;
    v_orden                 TICKETS.TK_CAT_ESTADOS.ORDEN_VISUALIZACION%TYPE;
    v_fecha_creacion        TICKETS.TK_CAT_ESTADOS.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_CAT_ESTADOS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_CAT_ESTADOS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_CAT_ESTADOS.USUARIO_ACTUALIZACION%TYPE;
    v_activo                TICKETS.TK_CAT_ESTADOS.ACTIVO%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_nombre_prueba         VARCHAR2(50) :=
        'TEST ESTADO ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_CAT_ESTADOS_CRUD_PKG ===');

    -- Crear y validar el ID generado por la columna identity.
    TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_CREAR_P(
        p_id_estado               => NULL,
        p_nombre_estado           => v_nombre_prueba,
        p_descripcion_estado      => 'Estado creado por prueba unitaria.',
        p_cerrado                 => 'N',
        p_orden_visualizacion     => 99,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activo                  => 'S',
        po_ID_ESTADO_generado     => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear estado valido');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_ESTADO');
    v_id_estado := v_id_generado;

    -- Consultar mediante SYS_REFCURSOR.
    v_cursor := TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_CONSULTAR_F(v_id_estado);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion, v_cerrado,
                        v_orden, v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activo;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_estado, 'consultar estado por ID');
    afirmar(v_nombre = v_nombre_prueba, 'devolver nombre correcto');
    afirmar(v_cerrado = 'N', 'devolver estado no cerrado');
    afirmar(v_orden = 99, 'devolver orden correcto');
    afirmar(v_activo = 'S', 'devolver estado activo');

    -- Actualizar todos los campos expuestos por el spec.
    TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_ACTUALIZAR_P(
        p_id_estado               => v_id_estado,
        p_nombre_estado           => v_nombre_prueba || ' ACTUALIZADO',
        p_descripcion_estado      => 'Descripcion actualizada por prueba unitaria.',
        p_cerrado                 => 'S',
        p_orden_visualizacion     => 100,
        p_fecha_creacion          => v_fecha_creacion,
        p_usuario_creacion        => v_usuario_creacion,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activo                  => 'N',
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar estado valido');

    -- Validar nombre duplicado.
    TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_CREAR_P(
        p_id_estado               => NULL,
        p_nombre_estado           => v_nombre_prueba || ' ACTUALIZADO',
        p_descripcion_estado      => 'No debe insertarse.',
        p_cerrado                 => 'N',
        p_orden_visualizacion     => 101,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activo                  => 'S',
        po_ID_ESTADO_generado     => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre duplicado');

    -- Validar nombre obligatorio.
    TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_CREAR_P(
        p_id_estado               => NULL,
        p_nombre_estado           => NULL,
        p_descripcion_estado      => NULL,
        p_cerrado                 => 'N',
        p_orden_visualizacion     => 102,
        p_fecha_creacion          => NULL,
        p_usuario_creacion        => NULL,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activo                  => 'S',
        po_ID_ESTADO_generado     => v_id_generado,
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre nulo');

    -- Validar dominios y orden de visualizacion.
    TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_ACTUALIZAR_P(
        p_id_estado               => v_id_estado,
        p_nombre_estado           => v_nombre_prueba || ' ACTUALIZADO',
        p_descripcion_estado      => 'No debe actualizarse.',
        p_cerrado                 => 'X',
        p_orden_visualizacion     => 0,
        p_fecha_creacion          => v_fecha_creacion,
        p_usuario_creacion        => v_usuario_creacion,
        p_fecha_actualizacion     => NULL,
        p_usuario_actualizacion   => NULL,
        p_activo                  => 'X',
        pv_resultado              => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar dominios y orden invalidos');

    -- Eliminar y validar que el registro ya no exista.
    TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_ELIMINAR_P(
        p_ID_ESTADO => v_id_estado,
        pv_resultado => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar estado');

    v_cursor := TICKETS.TK_CAT_ESTADOS_CRUD_PKG.TK_CAT_ESTADOS_CONSULTAR_F(v_id_estado);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion, v_cerrado,
                        v_orden, v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activo;
    afirmar(v_cursor%NOTFOUND, 'no devolver estado eliminado');
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_CAT_ESTADOS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_CAT_ESTADOS FALLO ===');
        RAISE;
END;
/
