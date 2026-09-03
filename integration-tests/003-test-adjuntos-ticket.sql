-- Prueba integral de adjuntos dentro del ciclo de vida de un ticket.
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_ticket NUMBER; v_adjunto NUMBER; v_generado NUMBER; v_usuario NUMBER;
    v_categoria NUMBER; v_prioridad NUMBER; v_area NUMBER; v_tecnico NUMBER;
    v_exito NUMBER; v_codigo VARCHAR2(100); v_mensaje VARCHAR2(4000);
    v_resultado VARCHAR2(4000); v_blob BLOB; v_count PLS_INTEGER;
    v_marca VARCHAR2(30) := TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE limpiar IS
    BEGIN
        IF v_ticket IS NOT NULL THEN
            DELETE FROM TICKETS.TK_TICKET_ADJUNTOS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = v_ticket;
        END IF;
        IF DBMS_LOB.ISTEMPORARY(v_blob) = 1 THEN DBMS_LOB.FREETEMPORARY(v_blob); END IF;
        COMMIT;
    END limpiar;
BEGIN
    SELECT ID_USUARIO INTO v_usuario FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'usuario.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_tecnico FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'tecnico.tickets' AND ACTIVO = 'S';
    SELECT ID_CATEGORIA INTO v_categoria FROM TICKETS.TK_CATEGORIAS
     WHERE NOMBRE_CATEGORIA = 'Incidentes' AND ACTIVA = 'S';
    SELECT ID_PRIORIDAD INTO v_prioridad FROM TICKETS.TK_CAT_PRIORIDADES
     WHERE NOMBRE_PRIORIDAD = 'Media' AND ACTIVA = 'S';
    SELECT ID_AREA INTO v_area FROM TICKETS.TK_AREAS
     WHERE NOMBRE_AREA = 'Mesa de Ayuda' AND ACTIVA = 'S';

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        'TEST ADJUNTO INTEGRAL ' || v_marca, TO_CLOB('Ticket con adjunto.'),
        v_usuario, v_categoria, v_prioridad, v_area, 2,
        v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_ticket IS NOT NULL, 'crear ticket con adjunto');

    DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);
    DBMS_LOB.WRITEAPPEND(v_blob, 11, UTL_RAW.CAST_TO_RAW('hola adjunto'));
    TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG.TK_TICKET_ADJUNTOS_CREAR_P(
        p_id_adjunto => NULL, p_id_ticket => v_ticket,
        p_nombre_archivo => 'evidencia.txt', p_extension => 'txt',
        p_mime_type => 'text/plain', p_tamano_bytes => 11, p_archivo => v_blob,
        p_hash_sha256 => NULL, p_id_usuario => v_usuario,
        p_fecha_carga => SYSTIMESTAMP, p_fecha_creacion => SYSTIMESTAMP,
        p_usuario_creacion => USER, p_fecha_actualizacion => NULL,
        p_usuario_actualizacion => NULL, p_activo => 'S',
        po_ID_ADJUNTO_generado => v_generado, pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO CREADO' AND v_generado IS NOT NULL, 'crear adjunto');
    v_adjunto := v_generado;

    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_TICKET_ADJUNTOS
     WHERE ID_ADJUNTO = v_adjunto AND ID_TICKET = v_ticket
       AND NOMBRE_ARCHIVO = 'evidencia.txt' AND ACTIVO = 'S';
    afirmar(v_count = 1, 'validar adjunto asociado');

    TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG.TK_TICKET_ADJUNTOS_ACTUALIZAR_P(
        p_id_adjunto => v_adjunto, p_id_ticket => v_ticket,
        p_nombre_archivo => 'evidencia-actualizada.txt', p_extension => 'txt',
        p_mime_type => 'text/plain', p_tamano_bytes => 11, p_archivo => v_blob,
        p_hash_sha256 => NULL, p_id_usuario => v_usuario,
        p_fecha_carga => SYSTIMESTAMP, p_fecha_creacion => SYSTIMESTAMP,
        p_usuario_creacion => USER, p_fecha_actualizacion => NULL,
        p_usuario_actualizacion => NULL, p_activo => 'S',
        pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar adjunto');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(v_ticket, v_tecnico, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'asignar ticket con adjunto');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'iniciar ticket con adjunto');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        v_ticket, v_tecnico, TO_CLOB('Solucion basada en la evidencia adjunta.'),
        v_generado, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'resolver ticket con adjunto');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.CERRAR_TICKET(
        v_ticket, v_tecnico, 'Cierre con evidencia adjunta.',
        v_generado, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'cerrar ticket con adjunto');

    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_TICKET_ADJUNTOS
     WHERE ID_ADJUNTO = v_adjunto AND ID_TICKET = v_ticket
       AND NOMBRE_ARCHIVO = 'evidencia-actualizada.txt' AND ACTIVO = 'S';
    afirmar(v_count = 1, 'conservar adjunto despues del cierre');
    TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG.TK_TICKET_ADJUNTOS_ELIMINAR_P(v_adjunto, v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar adjunto');
    limpiar;
    DBMS_OUTPUT.PUT_LINE('=== PRUEBA INTEGRAL DE ADJUNTOS PASO ===');
EXCEPTION
    WHEN OTHERS THEN limpiar; DBMS_OUTPUT.PUT_LINE('=== PRUEBA INTEGRAL DE ADJUNTOS FALLO ==='); RAISE;
END;
/
