-- Pruebas unitarias para TICKETS.TK_CATEGORIAS_CRUD_PKG
CONNECT TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_categoria          TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_id_generado           TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_nombre                TICKETS.TK_CATEGORIAS.NOMBRE_CATEGORIA%TYPE;
    v_descripcion           TICKETS.TK_CATEGORIAS.DESCRIPCION%TYPE;
    v_fecha_creacion        TICKETS.TK_CATEGORIAS.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_CATEGORIAS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_CATEGORIAS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_CATEGORIAS.USUARIO_ACTUALIZACION%TYPE;
    v_activa                TICKETS.TK_CATEGORIAS.ACTIVA%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_nombre_prueba         VARCHAR2(100) :=
        'TEST CATEGORIA ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_CATEGORIAS_CRUD_PKG ===');

    -- Crear y validar el ID generado por la columna identity.
    TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_CREAR_P(
        p_id_categoria          => NULL,
        p_nombre_categoria      => v_nombre_prueba,
        p_descripcion           => 'Categoria creada por prueba unitaria.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        po_ID_CATEGORIA_generado => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear categoria valida');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_CATEGORIA');
    v_id_categoria := v_id_generado;

    -- Consultar mediante SYS_REFCURSOR.
    v_cursor := TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_CONSULTAR_F(v_id_categoria);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activa;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_categoria, 'consultar categoria por ID');
    afirmar(v_nombre = v_nombre_prueba, 'devolver nombre correcto');
    afirmar(v_activa = 'S', 'devolver estado activo');

    -- Actualizar todos los campos expuestos por el spec.
    TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_ACTUALIZAR_P(
        p_id_categoria          => v_id_categoria,
        p_nombre_categoria      => v_nombre_prueba || ' ACTUALIZADA',
        p_descripcion           => 'Descripcion actualizada por prueba unitaria.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar categoria valida');

    -- Validar nombre duplicado.
    TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_CREAR_P(
        p_id_categoria          => NULL,
        p_nombre_categoria      => v_nombre_prueba || ' ACTUALIZADA',
        p_descripcion           => 'No debe insertarse.',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        po_ID_CATEGORIA_generado => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre duplicado');

    -- Validar nombre obligatorio.
    TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_CREAR_P(
        p_id_categoria          => NULL,
        p_nombre_categoria      => NULL,
        p_descripcion           => NULL,
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activa                => 'S',
        po_ID_CATEGORIA_generado => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre nulo');

    -- Validar dominio de ACTIVA.
    TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_ACTUALIZAR_P(
        p_id_categoria          => v_id_categoria,
        p_nombre_categoria      => v_nombre_prueba || ' ACTUALIZADA',
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
    TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_ELIMINAR_P(
        p_ID_CATEGORIA => v_id_categoria,
        pv_resultado   => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar categoria');

    v_cursor := TICKETS.TK_CATEGORIAS_CRUD_PKG.TK_CATEGORIAS_CONSULTAR_F(v_id_categoria);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activa;
    afirmar(v_cursor%NOTFOUND, 'no devolver categoria eliminada');
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_CATEGORIAS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_CATEGORIAS FALLO ===');
        RAISE;
END;
/
