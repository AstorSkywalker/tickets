-- Pruebas unitarias para TICKETS.TK_ROLES_CRUD_PKG
CONNECT TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_rol                TICKETS.TK_ROLES.ID_ROL%TYPE;
    v_id_generado           TICKETS.TK_ROLES.ID_ROL%TYPE;
    v_nombre                TICKETS.TK_ROLES.NOMBRE_ROL%TYPE;
    v_descripcion           TICKETS.TK_ROLES.DESCRIPCION%TYPE;
    v_fecha_creacion        TICKETS.TK_ROLES.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_ROLES.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_ROLES.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_ROLES.USUARIO_ACTUALIZACION%TYPE;
    v_activo                TICKETS.TK_ROLES.ACTIVO%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_nombre_prueba         VARCHAR2(100) :=
        'TEST ROL ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_ROLES_CRUD_PKG ===');

    TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_CREAR_P(
        p_id_rol                 => NULL,
        p_nombre_rol             => v_nombre_prueba,
        p_descripcion            => 'Rol creado por prueba unitaria.',
        p_fecha_creacion         => NULL,
        p_usuario_creacion       => NULL,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'S',
        po_ID_ROL_generado       => v_id_generado,
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear rol valido');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_ROL');
    v_id_rol := v_id_generado;

    v_cursor := TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_CONSULTAR_F(v_id_rol);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activo;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_rol, 'consultar rol por ID');
    afirmar(v_nombre = v_nombre_prueba, 'devolver nombre correcto');
    afirmar(v_activo = 'S', 'devolver estado activo');

    TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_ACTUALIZAR_P(
        p_id_rol                 => v_id_rol,
        p_nombre_rol             => v_nombre_prueba || ' ACTUALIZADO',
        p_descripcion            => 'Descripcion actualizada por prueba unitaria.',
        p_fecha_creacion         => v_fecha_creacion,
        p_usuario_creacion       => v_usuario_creacion,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'N',
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar rol valido');

    TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_CREAR_P(
        p_id_rol                 => NULL,
        p_nombre_rol             => v_nombre_prueba || ' ACTUALIZADO',
        p_descripcion            => 'No debe insertarse.',
        p_fecha_creacion         => NULL,
        p_usuario_creacion       => NULL,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'S',
        po_ID_ROL_generado       => v_id_generado,
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre duplicado');

    TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_CREAR_P(
        p_id_rol                 => NULL,
        p_nombre_rol             => NULL,
        p_descripcion            => NULL,
        p_fecha_creacion         => NULL,
        p_usuario_creacion       => NULL,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'S',
        po_ID_ROL_generado       => v_id_generado,
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar nombre nulo');

    TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_ACTUALIZAR_P(
        p_id_rol                 => v_id_rol,
        p_nombre_rol             => v_nombre_prueba || ' ACTUALIZADO',
        p_descripcion            => 'No debe actualizarse.',
        p_fecha_creacion         => v_fecha_creacion,
        p_usuario_creacion       => v_usuario_creacion,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'X',
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar ACTIVO fuera de S/N');

    TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_ELIMINAR_P(
        p_ID_ROL => v_id_rol, pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar rol');
    v_cursor := TICKETS.TK_ROLES_CRUD_PKG.TK_ROLES_CONSULTAR_F(v_id_rol);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_descripcion,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activo;
    afirmar(v_cursor%NOTFOUND, 'no devolver rol eliminado');
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_ROLES PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_ROLES FALLO ===');
        RAISE;
END;
/
