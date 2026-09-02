-- Pruebas unitarias para TICKETS.TK_AREAS_CRUD_PKG
CONNECT TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_area       TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_id_generado   TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_nombre        TICKETS.TK_AREAS.NOMBRE_AREA%TYPE;
    v_descripcion   TICKETS.TK_AREAS.DESCRIPCION%TYPE;
    v_fecha_creacion TICKETS.TK_AREAS.FECHA_CREACION%TYPE;
    v_usuario_creacion TICKETS.TK_AREAS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE;
    v_activa        TICKETS.TK_AREAS.ACTIVA%TYPE;
    v_resultado     VARCHAR2(4000);
    v_cursor        SYS_REFCURSOR;
    v_nombre_prueba VARCHAR2(100) := 'TEST AREA ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLÓ: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_AREAS_CRUD_PKG ===');

    -- Crear y validar el ID generado por la columna identity.
    TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_CREAR_P(
        p_id_area               => NULL,
        p_nombre_area           => v_nombre_prueba,
        p_descripcion           => 'Área creada por prueba unitaria.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        po_ID_AREA_generado     => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: ÁREA CREADA', 'crear área válida');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_AREA');
    v_id_area := v_id_generado;

    -- Consultar mediante SYS_REFCURSOR.
    v_cursor := TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_CONSULTAR_F(v_id_area);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activa;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_area, 'consultar área por ID');
    afirmar(v_nombre = v_nombre_prueba, 'devolver nombre correcto');
    afirmar(v_activa = 'S', 'devolver estado activo');

    -- Actualizar todos los campos expuestos por el spec.
    TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_ACTUALIZAR_P(
        p_id_area               => v_id_area,
        p_nombre_area           => v_nombre_prueba || ' ACTUALIZADA',
        p_descripcion           => 'Descripción actualizada por prueba unitaria.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: ÁREA ACTUALIZADA', 'actualizar área válida');

    -- Validar nombre duplicado.
    TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_CREAR_P(
        p_id_area               => NULL,
        p_nombre_area           => v_nombre_prueba || ' ACTUALIZADA',
        p_descripcion           => 'No debe insertarse.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        po_ID_AREA_generado     => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL, 'rechazar nombre duplicado');

    -- Validar nombre obligatorio.
    TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_CREAR_P(
        p_id_area               => NULL,
        p_nombre_area           => NULL,
        p_descripcion           => NULL,
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        po_ID_AREA_generado     => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL, 'rechazar nombre nulo');

    -- Validar dominio de ACTIVA.
    TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_ACTUALIZAR_P(
        p_id_area               => v_id_area,
        p_nombre_area           => v_nombre_prueba || ' ACTUALIZADA',
        p_descripcion           => 'No debe actualizarse.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'X',
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar ACTIVA fuera de S/N');

    -- Eliminar y validar que el registro ya no exista.
    TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_ELIMINAR_P(
        p_id_area    => v_id_area,
        pv_resultado => v_resultado
    );
    afirmar(v_resultado = 'OK: ÁREA ELIMINADA', 'eliminar área');

    v_cursor := TICKETS.TK_AREAS_CRUD_PKG.TK_AREAS_CONSULTAR_F(v_id_area);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activa;
    afirmar(v_cursor%NOTFOUND, 'no devolver área eliminada');
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_AREAS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_AREAS FALLÓ ===');
        RAISE;
END;
/
