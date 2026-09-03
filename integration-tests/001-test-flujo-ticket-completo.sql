-- Prueba integral del ciclo de vida de un ticket.
-- Ejecutar con SQLcl contra la base de datos de desarrollo.
CONNECT TICKETS/Tickets123@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_ticket              TICKETS.TK_TICKETS.ID_TICKET%TYPE;
    v_usuario_reporta     TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_tecnico             TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_supervisor          TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_categoria           TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_prioridad           TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_area                TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_tipo_activo         TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE;
    v_activo              TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE;
    v_relacion            TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE;
    v_comentario          TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE;
    v_encuesta            TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE;
    v_exito               NUMBER;
    v_codigo              VARCHAR2(100);
    v_mensaje             VARCHAR2(4000);
    v_estado              VARCHAR2(100);
    v_count               PLS_INTEGER;
    v_marca               VARCHAR2(30) := TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE estado_actual(p_id IN NUMBER, p_estado OUT VARCHAR2) IS
    BEGIN
        SELECT e.NOMBRE_ESTADO
          INTO p_estado
          FROM TICKETS.TK_TICKETS t
          JOIN TICKETS.TK_CAT_ESTADOS e ON e.ID_ESTADO = t.ID_ESTADO
         WHERE t.ID_TICKET = p_id;
    END estado_actual;

    PROCEDURE limpiar IS
    BEGIN
        IF v_ticket IS NOT NULL THEN
            DELETE FROM TICKETS.TK_ACTIVOS_TICKETS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKET_ADJUNTOS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_ENCUESTAS WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = v_ticket;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = v_ticket;
        END IF;
        IF v_activo IS NOT NULL THEN
            DELETE FROM TICKETS.TK_ACTIVOS WHERE ID_ACTIVO = v_activo;
        END IF;
        COMMIT;
    END limpiar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBA INTEGRAL DE TICKET ===');

    SELECT ID_USUARIO INTO v_usuario_reporta FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'usuario.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_tecnico FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'tecnico.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_supervisor FROM TICKETS.TK_USUARIOS
     WHERE USERNAME = 'supervisor.tickets' AND ACTIVO = 'S';
    SELECT ID_CATEGORIA INTO v_categoria FROM TICKETS.TK_CATEGORIAS
     WHERE NOMBRE_CATEGORIA = 'Incidentes' AND ACTIVA = 'S';
    SELECT ID_PRIORIDAD INTO v_prioridad FROM TICKETS.TK_CAT_PRIORIDADES
     WHERE NOMBRE_PRIORIDAD = 'Media' AND ACTIVA = 'S';
    SELECT ID_AREA INTO v_area FROM TICKETS.TK_AREAS
     WHERE NOMBRE_AREA = 'Mesa de Ayuda' AND ACTIVA = 'S';
    SELECT MIN(ID_TIPO_ACTIVO) INTO v_tipo_activo FROM TICKETS.TK_TIPOS_ACTIVOS
     WHERE ACTIVO = 'S';

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        'TEST INTEGRAL ' || v_marca, TO_CLOB('Flujo integral de prueba.'),
        v_usuario_reporta, v_categoria, v_prioridad, v_area, 4,
        v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_ticket IS NOT NULL, 'crear ticket');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'Nuevo', 'estado inicial Nuevo');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(
        v_ticket, v_tecnico, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'asignar tecnico');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(
        v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'iniciar atencion');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'En Proceso', 'estado En Proceso');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.AGREGAR_COMENTARIO(
        v_ticket, v_usuario_reporta, TO_CLOB('Comentario del solicitante.'),
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_comentario IS NOT NULL, 'agregar comentario');

    INSERT INTO TICKETS.TK_ACTIVOS (
        NUMERO_SERIE, NUMERO_INVENTARIO, DESCRIPCION_ACTIVO, MARCA, MODELO,
        ID_TIPO_ACTIVO, UBICACION, ACTIVO)
    VALUES (
        'TEST-SERIE-' || v_marca, 'TEST-INV-' || v_marca,
        'Activo de prueba integral.', 'Marca Test', 'Modelo Test',
        v_tipo_activo, 'Mesa de Ayuda', 'S')
    RETURNING ID_ACTIVO INTO v_activo;

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASOCIAR_ACTIVO(
        v_ticket, v_activo, v_relacion, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_relacion IS NOT NULL, 'asociar activo');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        v_ticket, v_tecnico, TO_CLOB('Solucion integral de prueba.'),
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'resolver ticket');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'Resuelto', 'estado Resuelto');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CERRAR_TICKET(
        v_ticket, v_supervisor, 'Cierre integral de prueba.',
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'cerrar ticket');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'Cerrado', 'estado final Cerrado');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.REGISTRAR_ENCUESTA(
        v_ticket, 5, 'Servicio satisfactorio.', v_encuesta,
        v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_encuesta IS NOT NULL, 'registrar encuesta');

    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_TICKETS_HISTORIAL
     WHERE ID_TICKET = v_ticket;
    afirmar(v_count >= 4, 'registrar historial del flujo');
    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_ACTIVOS_TICKETS
     WHERE ID_TICKET = v_ticket AND ID_ACTIVO = v_activo;
    afirmar(v_count = 1, 'persistir relacion del activo');

    limpiar;
    DBMS_OUTPUT.PUT_LINE('=== PRUEBA INTEGRAL PASO ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA INTEGRAL FALLO ===');
        RAISE;
END;
/
