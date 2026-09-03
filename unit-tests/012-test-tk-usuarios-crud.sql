-- Pruebas unitarias para TICKETS.TK_USUARIOS_CRUD_PKG
CONNECT TICKETS/Tickets123@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_usuario            TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_generado           TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_nombre                TICKETS.TK_USUARIOS.NOMBRE%TYPE;
    v_apellido              TICKETS.TK_USUARIOS.APELLIDO%TYPE;
    v_username              TICKETS.TK_USUARIOS.USERNAME%TYPE;
    v_email                 TICKETS.TK_USUARIOS.EMAIL%TYPE;
    v_telefono              TICKETS.TK_USUARIOS.TELEFONO%TYPE;
    v_ubicacion             TICKETS.TK_USUARIOS.UBICACION%TYPE;
    v_fecha_creacion        TICKETS.TK_USUARIOS.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_USUARIOS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_USUARIOS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_USUARIOS.USUARIO_ACTUALIZACION%TYPE;
    v_activo                TICKETS.TK_USUARIOS.ACTIVO%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_username_prueba       VARCHAR2(100) :=
        'test.usuario.' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');
    v_email_prueba          VARCHAR2(254) :=
        'test.usuario.' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3') || '@example.test';

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_USUARIOS_CRUD_PKG ===');

    TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_CREAR_P(
        p_id_usuario            => NULL,
        p_nombre                => 'Usuario',
        p_apellido              => 'Prueba',
        p_username              => v_username_prueba,
        p_email                 => v_email_prueba,
        p_telefono              => '555-0100',
        p_ubicacion             => 'Laboratorio',
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activo                => 'S',
        po_ID_USUARIO_generado  => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear usuario valido');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_USUARIO');
    v_id_usuario := v_id_generado;

    v_cursor := TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_CONSULTAR_F(v_id_usuario);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_apellido, v_username,
                        v_email, v_telefono, v_ubicacion, v_fecha_creacion,
                        v_usuario_creacion, v_fecha_actualizacion,
                        v_usuario_actualizacion, v_activo;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_usuario, 'consultar usuario por ID');
    afirmar(v_username = v_username_prueba AND v_email = v_email_prueba,
            'devolver identificadores correctos');
    afirmar(v_activo = 'S', 'devolver estado activo');

    TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_ACTUALIZAR_P(
        p_id_usuario            => v_id_usuario,
        p_nombre                => 'Usuario Actualizado',
        p_apellido              => 'Prueba Actualizada',
        p_username              => v_username_prueba || '.actualizado',
        p_email                 => 'actualizado.' || v_email_prueba,
        p_telefono              => '555-0101',
        p_ubicacion             => 'Oficina',
        p_fecha_creacion        => v_fecha_creacion,
        p_usuario_creacion      => v_usuario_creacion,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activo                => 'N',
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar usuario valido');

    TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_CREAR_P(
        p_id_usuario            => NULL,
        p_nombre                => 'Duplicado',
        p_apellido              => 'Prueba',
        p_username              => v_username_prueba || '.actualizado',
        p_email                 => 'otro.' || v_email_prueba,
        p_telefono              => NULL,
        p_ubicacion             => NULL,
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activo                => 'S',
        po_ID_USUARIO_generado  => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar username duplicado');

    TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_CREAR_P(
        p_id_usuario            => NULL,
        p_nombre                => NULL,
        p_apellido              => NULL,
        p_username              => NULL,
        p_email                 => NULL,
        p_telefono              => NULL,
        p_ubicacion             => NULL,
        p_fecha_creacion        => NULL,
        p_usuario_creacion      => NULL,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activo                => 'S',
        po_ID_USUARIO_generado  => v_id_generado,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar datos obligatorios nulos');

    TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_ACTUALIZAR_P(
        p_id_usuario            => v_id_usuario,
        p_nombre                => 'Usuario Actualizado',
        p_apellido              => 'Prueba Actualizada',
        p_username              => v_username_prueba || '.actualizado',
        p_email                 => 'actualizado.' || v_email_prueba,
        p_telefono              => '555-0101',
        p_ubicacion             => 'Oficina',
        p_fecha_creacion        => v_fecha_creacion,
        p_usuario_creacion      => v_usuario_creacion,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        p_activo                => 'X',
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar ACTIVO fuera de S/N');

    TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_ELIMINAR_P(
        p_ID_USUARIO => v_id_usuario, pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar usuario');
    v_cursor := TICKETS.TK_USUARIOS_CRUD_PKG.TK_USUARIOS_CONSULTAR_F(v_id_usuario);
    FETCH v_cursor INTO v_id_generado, v_nombre, v_apellido, v_username,
                        v_email, v_telefono, v_ubicacion, v_fecha_creacion,
                        v_usuario_creacion, v_fecha_actualizacion,
                        v_usuario_actualizacion, v_activo;
    afirmar(v_cursor%NOTFOUND, 'no devolver usuario eliminado');
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_USUARIOS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
        IF v_id_usuario IS NOT NULL THEN
            DELETE FROM TICKETS.TK_USUARIOS_ROLES WHERE ID_USUARIO = v_id_usuario;
            DELETE FROM TICKETS.TK_USUARIOS WHERE ID_USUARIO = v_id_usuario;
            COMMIT;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_USUARIOS FALLO ===');
        RAISE;
END;
/
