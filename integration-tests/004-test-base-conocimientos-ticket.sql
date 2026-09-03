-- Prueba integral de un articulo de conocimiento usado durante la resolucion.
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_articulo NUMBER; v_generado NUMBER; v_ticket NUMBER; v_usuario NUMBER;
    v_tecnico NUMBER; v_categoria NUMBER; v_prioridad NUMBER; v_area NUMBER;
    v_exito NUMBER; v_codigo VARCHAR2(100); v_mensaje VARCHAR2(4000);
    v_resultado VARCHAR2(4000); v_titulo VARCHAR2(300);
    v_fecha_creacion TIMESTAMP; v_usuario_creacion VARCHAR2(128);
    v_comentario NUMBER; v_count PLS_INTEGER;
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
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = v_ticket;
        END IF;
        IF v_articulo IS NOT NULL THEN
            DELETE FROM TICKETS.TK_BASE_CONOCIMIENTOS WHERE ID_BASE_CONOCIMIENTO = v_articulo;
        END IF;
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

    v_titulo := 'Solucion KB ' || v_marca;
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_CREAR_P(
        p_id_base_conocimiento => NULL, p_titulo => v_titulo,
        p_descripcion => TO_CLOB('Pasos para resolver el incidente de prueba.'),
        p_palabras_clave => 'incidente,prueba,solucion', p_publicado => 'N',
        p_id_usuario_autor => v_tecnico, p_fecha_creacion => SYSTIMESTAMP,
        p_usuario_creacion => USER, p_fecha_actualizacion => NULL,
        p_usuario_actualizacion => NULL,
        po_ID_BASE_CONOCIMIENTO_generado => v_generado,
        pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO CREADO' AND v_generado IS NOT NULL, 'crear articulo borrador');
    v_articulo := v_generado;
    SELECT FECHA_CREACION, USUARIO_CREACION INTO v_fecha_creacion, v_usuario_creacion
      FROM TICKETS.TK_BASE_CONOCIMIENTOS WHERE ID_BASE_CONOCIMIENTO = v_articulo;
    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_BASE_CONOCIMIENTOS
     WHERE ID_BASE_CONOCIMIENTO = v_articulo AND PUBLICADO = 'N';
    afirmar(v_count = 1, 'validar articulo como borrador');

    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P(
        p_id_base_conocimiento => v_articulo, p_titulo => v_titulo,
        p_descripcion => TO_CLOB('Pasos actualizados para resolver el incidente.'),
        p_palabras_clave => 'incidente,prueba,solucion,actualizado', p_publicado => 'S',
        p_id_usuario_autor => v_tecnico, p_fecha_creacion => v_fecha_creacion,
        p_usuario_creacion => v_usuario_creacion, p_fecha_actualizacion => SYSTIMESTAMP,
        p_usuario_actualizacion => USER, pv_resultado => v_resultado);
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'publicar articulo');
    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_BASE_CONOCIMIENTOS
     WHERE ID_BASE_CONOCIMIENTO = v_articulo AND PUBLICADO = 'S';
    afirmar(v_count = 1, 'validar articulo publicado');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        'TEST KB INTEGRAL ' || v_marca, TO_CLOB('Ticket resuelto con articulo KB.'),
        v_usuario, v_categoria, v_prioridad, v_area, 2,
        v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_ticket IS NOT NULL, 'crear ticket para usar articulo');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(v_ticket, v_tecnico, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'asignar ticket con apoyo KB');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'iniciar atencion con apoyo KB');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        v_ticket, v_tecnico,
        TO_CLOB('Solucion aplicada segun articulo ' || v_titulo || '.'),
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'resolver ticket usando articulo KB');
    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_TICKETS
     WHERE ID_TICKET = v_ticket
       AND DBMS_LOB.INSTR(DESCRIPCION_SOLUCION, v_titulo) > 0;
    afirmar(v_count = 1, 'persistir referencia del articulo en solucion');
    limpiar;
    DBMS_OUTPUT.PUT_LINE('=== PRUEBA INTEGRAL DE BASE DE CONOCIMIENTOS PASO ===');
EXCEPTION
    WHEN OTHERS THEN limpiar; DBMS_OUTPUT.PUT_LINE('=== PRUEBA INTEGRAL DE BASE DE CONOCIMIENTOS FALLO ==='); RAISE;
END;
/
