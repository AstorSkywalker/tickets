-- Pruebas unitarias para TICKETS.TK_USUARIOS_ROLES_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_usuario_rol        TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE;
    v_id_generado           TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE;
    v_id_rol                TICKETS.TK_USUARIOS_ROLES.ID_ROL%TYPE;
    v_id_rol_nuevo          TICKETS.TK_USUARIOS_ROLES.ID_ROL%TYPE;
    v_id_usuario            TICKETS.TK_USUARIOS_ROLES.ID_USUARIO%TYPE;
    v_fecha_creacion        TICKETS.TK_USUARIOS_ROLES.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_USUARIOS_ROLES.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_USUARIOS_ROLES.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_USUARIOS_ROLES.USUARIO_ACTUALIZACION%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_USUARIOS_ROLES_CRUD_PKG ===');

    -- Seleccionar una combinacion usuario/rol libre para la prueba.
    SELECT u.ID_USUARIO, r.ID_ROL
      INTO v_id_usuario, v_id_rol
      FROM TICKETS.TK_USUARIOS u
      CROSS JOIN TICKETS.TK_ROLES r
     WHERE u.ACTIVO = 'S'
       AND r.ACTIVO = 'S'
       AND NOT EXISTS (
           SELECT 1
             FROM TICKETS.TK_USUARIOS_ROLES ur
            WHERE ur.ID_USUARIO = u.ID_USUARIO
              AND ur.ID_ROL = r.ID_ROL
       )
       AND ROWNUM = 1;
    SELECT MIN(r.ID_ROL) INTO v_id_rol_nuevo
      FROM TICKETS.TK_ROLES r
     WHERE r.ID_ROL <> v_id_rol
       AND r.ACTIVO = 'S'
       AND NOT EXISTS (
           SELECT 1
             FROM TICKETS.TK_USUARIOS_ROLES ur
            WHERE ur.ID_USUARIO = v_id_usuario
              AND ur.ID_ROL = r.ID_ROL
       );
    afirmar(v_id_usuario IS NOT NULL AND v_id_rol IS NOT NULL,
            'encontrar combinacion usuario/rol libre');
    afirmar(v_id_rol_nuevo IS NOT NULL, 'encontrar segundo rol activo');

    TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_CREAR_P(
        p_id_usuario_rol       => NULL,
        p_id_rol               => v_id_rol,
        p_id_usuario           => v_id_usuario,
        p_fecha_creacion       => NULL,
        p_usuario_creacion     => NULL,
        p_fecha_actualizacion  => NULL,
        p_usuario_actualizacion => NULL,
        po_ID_USUARIO_ROL_generado => v_id_generado,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear relacion valida');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0,
            'generar ID_USUARIO_ROL');
    v_id_usuario_rol := v_id_generado;

    v_cursor := TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_CONSULTAR_F(v_id_usuario_rol);
    FETCH v_cursor INTO v_id_generado, v_id_rol, v_id_usuario,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_usuario_rol, 'consultar relacion por ID');
    afirmar(v_id_rol IS NOT NULL AND v_id_usuario IS NOT NULL,
            'devolver referencias correctas');

    TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_ACTUALIZAR_P(
        p_id_usuario_rol       => v_id_usuario_rol,
        p_id_rol               => v_id_rol_nuevo,
        p_id_usuario           => v_id_usuario,
        p_fecha_creacion       => v_fecha_creacion,
        p_usuario_creacion     => v_usuario_creacion,
        p_fecha_actualizacion  => NULL,
        p_usuario_actualizacion => NULL,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar relacion valida');

    -- La combinacion actual no puede repetirse.
    TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_CREAR_P(
        p_id_usuario_rol       => NULL,
        p_id_rol               => v_id_rol_nuevo,
        p_id_usuario           => v_id_usuario,
        p_fecha_creacion       => NULL,
        p_usuario_creacion     => NULL,
        p_fecha_actualizacion  => NULL,
        p_usuario_actualizacion => NULL,
        po_ID_USUARIO_ROL_generado => v_id_generado,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar relacion duplicada');

    TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_CREAR_P(
        p_id_usuario_rol       => NULL,
        p_id_rol               => NULL,
        p_id_usuario           => NULL,
        p_fecha_creacion       => NULL,
        p_usuario_creacion     => NULL,
        p_fecha_actualizacion  => NULL,
        p_usuario_actualizacion => NULL,
        po_ID_USUARIO_ROL_generado => v_id_generado,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar referencias nulas');

    TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_ELIMINAR_P(
        p_ID_USUARIO_ROL => v_id_usuario_rol, pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar relacion');
    v_cursor := TICKETS.TK_USUARIOS_ROLES_CRUD_PKG.TK_USUARIOS_ROLES_CONSULTAR_F(v_id_usuario_rol);
    FETCH v_cursor INTO v_id_generado, v_id_rol, v_id_usuario,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion;
    afirmar(v_cursor%NOTFOUND, 'no devolver relacion eliminada');
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_USUARIOS_ROLES PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
        IF v_id_usuario_rol IS NOT NULL THEN
            DELETE FROM TICKETS.TK_USUARIOS_ROLES WHERE ID_USUARIO_ROL = v_id_usuario_rol;
            COMMIT;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_USUARIOS_ROLES FALLO ===');
        RAISE;
END;
/
