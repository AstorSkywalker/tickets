-- Pruebas unitarias para TICKETS.TK_COMENTARIOS_CRUD_PKG
CONNECT TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_comentario         TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE;
    v_id_generado           TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE;
    v_id_ticket             TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE;
    v_id_usuario            TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE;
    v_id_categoria          TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_id_prioridad          TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_id_area               TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_comentario            TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE;
    v_fecha_creacion        TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE;
    v_activo                TICKETS.TK_COMENTARIOS.ACTIVO%TYPE;
    v_resultado             VARCHAR2(4000);
    v_exito                 NUMBER;
    v_codigo                VARCHAR2(100);
    v_mensaje               VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_comentario_prueba     VARCHAR2(4000) :=
        'Comentario creado por prueba unitaria ' ||
        TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE limpiar_prueba IS
    BEGIN
        IF v_id_ticket IS NOT NULL THEN
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = v_id_ticket;
            COMMIT;
        END IF;
    END limpiar_prueba;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_COMENTARIOS_CRUD_PKG ===');

    -- Crear un ticket temporal para satisfacer la FK de comentarios.
    SELECT ID_USUARIO INTO v_id_usuario
      FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'usuario.tickets' AND ACTIVO = 'S';
    SELECT ID_CATEGORIA INTO v_id_categoria
      FROM TICKETS.TK_CATEGORIAS
     WHERE NOMBRE_CATEGORIA = 'Incidentes' AND ACTIVA = 'S';
    SELECT ID_PRIORIDAD INTO v_id_prioridad
      FROM TICKETS.TK_CAT_PRIORIDADES
     WHERE NOMBRE_PRIORIDAD = 'Media' AND ACTIVA = 'S';
    SELECT ID_AREA INTO v_id_area
      FROM TICKETS.TK_AREAS
     WHERE NOMBRE_AREA = 'Mesa de Ayuda' AND ACTIVA = 'S';
    afirmar(v_id_usuario IS NOT NULL AND v_id_categoria IS NOT NULL
            AND v_id_prioridad IS NOT NULL AND v_id_area IS NOT NULL,
            'existencia de referencias semilla');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        p_nombre_ticket      => 'TEST COMENTARIO ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3'),
        p_descripcion        => TO_CLOB('Ticket temporal para prueba de comentarios.'),
        p_id_usuario_reporta => v_id_usuario,
        p_id_categoria       => v_id_categoria,
        p_id_prioridad       => v_id_prioridad,
        p_id_area            => v_id_area,
        p_horas_estimadas    => 1,
        po_id_ticket         => v_id_ticket,
        po_exito             => v_exito,
        pv_codigo            => v_codigo,
        pv_mensaje           => v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_ticket IS NOT NULL, 'crear ticket temporal');

    -- Crear y validar el ID generado por la columna identity.
    TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_CREAR_P(
        p_id_comentario          => NULL,
        p_id_ticket              => v_id_ticket,
        p_id_usuario             => v_id_usuario,
        p_comentario             => v_comentario_prueba,
        p_fecha_creacion         => NULL,
        p_usuario_creacion       => NULL,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'S',
        po_ID_COMENTARIO_generado => v_id_generado,
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear comentario valido');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_COMENTARIO');
    v_id_comentario := v_id_generado;

    -- Consultar mediante SYS_REFCURSOR.
    v_cursor := TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_CONSULTAR_F(v_id_comentario);
    FETCH v_cursor INTO v_id_generado, v_id_ticket, v_id_usuario, v_comentario,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activo;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_comentario, 'consultar comentario por ID');
    afirmar(v_id_ticket IS NOT NULL AND v_id_usuario IS NOT NULL,
            'devolver referencias correctas');
    afirmar(v_comentario = v_comentario_prueba, 'devolver comentario correcto');
    afirmar(v_activo = 'S', 'devolver estado activo');

    -- Actualizar todos los campos expuestos por el spec.
    TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_ACTUALIZAR_P(
        p_id_comentario          => v_id_comentario,
        p_id_ticket              => v_id_ticket,
        p_id_usuario             => v_id_usuario,
        p_comentario             => v_comentario_prueba || ' ACTUALIZADO',
        p_fecha_creacion         => v_fecha_creacion,
        p_usuario_creacion       => v_usuario_creacion,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'N',
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar comentario valido');

    -- Validar comentario obligatorio.
    TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_CREAR_P(
        p_id_comentario          => NULL,
        p_id_ticket              => v_id_ticket,
        p_id_usuario             => v_id_usuario,
        p_comentario             => NULL,
        p_fecha_creacion         => NULL,
        p_usuario_creacion       => NULL,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'S',
        po_ID_COMENTARIO_generado => v_id_generado,
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar comentario nulo');

    -- Validar referencias inexistentes y dominio de ACTIVO.
    TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_CREAR_P(
        p_id_comentario          => NULL,
        p_id_ticket              => -1,
        p_id_usuario             => -1,
        p_comentario             => 'No debe insertarse.',
        p_fecha_creacion         => NULL,
        p_usuario_creacion       => NULL,
        p_fecha_actualizacion    => NULL,
        p_usuario_actualizacion  => NULL,
        p_activo                 => 'X',
        po_ID_COMENTARIO_generado => v_id_generado,
        pv_resultado             => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar referencias o ACTIVO invalidos');

    -- Eliminar y validar que el registro ya no exista.
    TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_ELIMINAR_P(
        p_ID_COMENTARIO => v_id_comentario,
        pv_resultado    => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar comentario');

    v_cursor := TICKETS.TK_COMENTARIOS_CRUD_PKG.TK_COMENTARIOS_CONSULTAR_F(v_id_comentario);
    FETCH v_cursor INTO v_id_generado, v_id_ticket, v_id_usuario, v_comentario,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion, v_activo;
    afirmar(v_cursor%NOTFOUND, 'no devolver comentario eliminado');
    CLOSE v_cursor;

    limpiar_prueba;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_COMENTARIOS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar_prueba;
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_COMENTARIOS FALLO ===');
        RAISE;
END;
/
