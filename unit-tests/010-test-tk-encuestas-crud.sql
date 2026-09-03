-- Pruebas unitarias para TICKETS.TK_ENCUESTAS_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_encuesta           TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE;
    v_id_generado           TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE;
    v_id_ticket             TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE;
    v_id_usuario            TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_categoria          TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_id_prioridad          TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_id_area               TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_calificacion          TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE;
    v_comentario            TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE;
    v_fecha_creacion        TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE;
    v_resultado             VARCHAR2(4000);
    v_exito                 NUMBER;
    v_codigo                VARCHAR2(100);
    v_mensaje               VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;

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
            DELETE FROM TICKETS.TK_ENCUESTAS WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = v_id_ticket;
            COMMIT;
        END IF;
    END limpiar_prueba;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_ENCUESTAS_CRUD_PKG ===');

    SELECT ID_USUARIO INTO v_id_usuario FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'usuario.tickets' AND ACTIVO = 'S';
    SELECT ID_CATEGORIA INTO v_id_categoria FROM TICKETS.TK_CATEGORIAS
     WHERE NOMBRE_CATEGORIA = 'Incidentes' AND ACTIVA = 'S';
    SELECT ID_PRIORIDAD INTO v_id_prioridad FROM TICKETS.TK_CAT_PRIORIDADES
     WHERE NOMBRE_PRIORIDAD = 'Media' AND ACTIVA = 'S';
    SELECT ID_AREA INTO v_id_area FROM TICKETS.TK_AREAS
     WHERE NOMBRE_AREA = 'Mesa de Ayuda' AND ACTIVA = 'S';

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        p_nombre_ticket      => 'TEST ENCUESTA ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3'),
        p_descripcion        => TO_CLOB('Ticket temporal para prueba de encuestas.'),
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

    TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_CREAR_P(
        p_id_encuesta          => NULL,
        p_id_ticket            => v_id_ticket,
        p_calificacion         => 5,
        p_comentario           => 'Excelente servicio.',
        p_fecha_creacion       => NULL,
        p_usuario_creacion     => NULL,
        p_fecha_actualizacion  => NULL,
        p_usuario_actualizacion => NULL,
        po_ID_ENCUESTA_generado => v_id_generado,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear encuesta valida');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0, 'generar ID_ENCUESTA');
    v_id_encuesta := v_id_generado;

    v_cursor := TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_CONSULTAR_F(v_id_encuesta);
    FETCH v_cursor INTO v_id_generado, v_id_ticket, v_calificacion, v_comentario,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_encuesta, 'consultar encuesta por ID');
    afirmar(v_calificacion = 5 AND v_comentario = 'Excelente servicio.',
            'devolver datos correctos');

    TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_ACTUALIZAR_P(
        p_id_encuesta           => v_id_encuesta,
        p_id_ticket             => v_id_ticket,
        p_calificacion          => 4,
        p_comentario            => 'Servicio actualizado.',
        p_fecha_creacion        => v_fecha_creacion,
        p_usuario_creacion      => v_usuario_creacion,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar encuesta valida');

    TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_CREAR_P(
        p_id_encuesta          => NULL,
        p_id_ticket            => v_id_ticket,
        p_calificacion         => 3,
        p_comentario           => 'No debe insertarse.',
        p_fecha_creacion       => NULL,
        p_usuario_creacion     => NULL,
        p_fecha_actualizacion  => NULL,
        p_usuario_actualizacion => NULL,
        po_ID_ENCUESTA_generado => v_id_generado,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar encuesta duplicada para ticket');

    TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_ACTUALIZAR_P(
        p_id_encuesta           => v_id_encuesta,
        p_id_ticket             => v_id_ticket,
        p_calificacion          => 6,
        p_comentario            => 'No debe actualizarse.',
        p_fecha_creacion        => v_fecha_creacion,
        p_usuario_creacion      => v_usuario_creacion,
        p_fecha_actualizacion   => NULL,
        p_usuario_actualizacion => NULL,
        pv_resultado            => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar calificacion fuera de rango');

    TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_ELIMINAR_P(
        p_ID_ENCUESTA => v_id_encuesta, pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar encuesta');
    v_cursor := TICKETS.TK_ENCUESTAS_CRUD_PKG.TK_ENCUESTAS_CONSULTAR_F(v_id_encuesta);
    FETCH v_cursor INTO v_id_generado, v_id_ticket, v_calificacion, v_comentario,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion;
    afirmar(v_cursor%NOTFOUND, 'no devolver encuesta eliminada');
    CLOSE v_cursor;
    limpiar_prueba;
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_ENCUESTAS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar_prueba;
        IF v_cursor%ISOPEN THEN CLOSE v_cursor; END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_ENCUESTAS FALLO ===');
        RAISE;
END;
/
