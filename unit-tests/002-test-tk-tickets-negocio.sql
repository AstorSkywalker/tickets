-- Pruebas unitarias para TICKETS.TK_TICKETS_NEGOCIO_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_ticket       TICKETS.TK_TICKETS.ID_TICKET%TYPE;
    v_id_comentario   TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE;
    v_id_encuesta     TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE;
    v_id_reporta      TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_tecnico      TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_supervisor   TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_categoria    TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_id_prioridad    TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_id_area         TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_estado          TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE;
    v_nombre_ticket   TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE :=
        'TEST TICKET ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');
    v_exito           NUMBER;
    v_codigo          VARCHAR2(100);
    v_mensaje         VARCHAR2(4000);
    v_count           PLS_INTEGER;

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLÃƒâ€œ: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE limpiar_prueba IS
    BEGIN
        IF v_id_ticket IS NOT NULL THEN
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_ENCUESTAS WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_ACTIVOS_TICKETS WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = v_id_ticket;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = v_id_ticket;
            COMMIT;
        END IF;
    END limpiar_prueba;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_TICKETS_NEGOCIO_PKG ===');

    -- Obtener datos semilla sin depender de valores identity.
    SELECT ID_USUARIO INTO v_id_reporta
      FROM TICKETS.TK_USUARIOS WHERE USERNAME = 'usuario.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_id_tecnico
      FROM TICKETS.TK_USUARIOS WHERE USERNAME = 'tecnico.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_id_supervisor
      FROM TICKETS.TK_USUARIOS WHERE USERNAME = 'supervisor.tickets' AND ACTIVO = 'S';
    SELECT ID_CATEGORIA INTO v_id_categoria
      FROM TICKETS.TK_CATEGORIAS WHERE NOMBRE_CATEGORIA = 'Incidentes' AND ACTIVA = 'S';
    SELECT ID_PRIORIDAD INTO v_id_prioridad
      FROM TICKETS.TK_CAT_PRIORIDADES WHERE NOMBRE_PRIORIDAD = 'Media' AND ACTIVA = 'S';
    SELECT ID_AREA INTO v_id_area
      FROM TICKETS.TK_AREAS WHERE NOMBRE_AREA = 'Mesa de Ayuda' AND ACTIVA = 'S';
    afirmar(v_id_reporta IS NOT NULL AND v_id_tecnico IS NOT NULL AND v_id_supervisor IS NOT NULL,
            'existencia de usuarios semilla');
    afirmar(v_id_categoria IS NOT NULL AND v_id_prioridad IS NOT NULL AND v_id_area IS NOT NULL,
            'existencia de catÃƒÂ¡logos semilla');

    -- Crear ticket en estado Nuevo y validar el identity generado.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        p_nombre_ticket      => v_nombre_ticket,
        p_descripcion        => TO_CLOB('Ticket creado por prueba unitaria.'),
        p_id_usuario_reporta => v_id_reporta,
        p_id_categoria       => v_id_categoria,
        p_id_prioridad       => v_id_prioridad,
        p_id_area            => v_id_area,
        p_horas_estimadas    => 4,
        po_id_ticket         => v_id_ticket,
        po_exito             => v_exito,
        pv_codigo            => v_codigo,
        pv_mensaje           => v_mensaje
    );
    afirmar(v_exito = 1 AND v_codigo = 'TICKET_CREADO', 'crear ticket');
    afirmar(v_id_ticket IS NOT NULL AND v_id_ticket > 0, 'generar ID_TICKET');

    SELECT e.NOMBRE_ESTADO INTO v_estado
      FROM TICKETS.TK_TICKETS t
      JOIN TICKETS.TK_CAT_ESTADOS e ON e.ID_ESTADO = t.ID_ESTADO
     WHERE t.ID_TICKET = v_id_ticket;
    afirmar(v_estado = 'Nuevo', 'asignar estado inicial Nuevo');

    -- Asignar tÃƒÂ©cnico y validar transiciÃƒÂ³n a Asignado.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(
        p_id_ticket  => v_id_ticket,
        p_id_tecnico => v_id_tecnico,
        po_exito     => v_exito,
        pv_codigo    => v_codigo,
        pv_mensaje   => v_mensaje
    );
    afirmar(v_exito = 1 AND v_codigo = 'TICKET_ASIGNADO', 'asignar ticket a tÃƒÂ©cnico');

    -- Iniciar atenciÃƒÂ³n.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(
        p_id_ticket => v_id_ticket,
        po_exito    => v_exito,
        pv_codigo   => v_codigo,
        pv_mensaje  => v_mensaje
    );
    afirmar(v_exito = 1 AND v_codigo = 'ATENCION_INICIADA', 'iniciar atenciÃƒÂ³n');

    -- Agregar comentario operativo.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.AGREGAR_COMENTARIO(
        p_id_ticket      => v_id_ticket,
        p_id_usuario     => v_id_tecnico,
        p_comentario     => 'Comentario de prueba durante la atenciÃƒÂ³n.',
        po_id_comentario => v_id_comentario,
        po_exito         => v_exito,
        pv_codigo        => v_codigo,
        pv_mensaje       => v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_comentario IS NOT NULL, 'agregar comentario');

    -- Resolver y cerrar el ticket.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        p_id_ticket      => v_id_ticket,
        p_id_usuario     => v_id_tecnico,
        p_solucion       => TO_CLOB('Se aplicÃƒÂ³ la soluciÃƒÂ³n registrada en la prueba.'),
        po_id_comentario => v_id_comentario,
        po_exito         => v_exito,
        pv_codigo        => v_codigo,
        pv_mensaje       => v_mensaje
    );
    afirmar(v_exito = 1 AND v_codigo = 'TICKET_RESUELTO', 'resolver ticket');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CERRAR_TICKET(
        p_id_ticket      => v_id_ticket,
        p_id_usuario     => v_id_supervisor,
        p_comentario     => 'Cierre validado por prueba unitaria.',
        po_id_comentario => v_id_comentario,
        po_exito         => v_exito,
        pv_codigo        => v_codigo,
        pv_mensaje       => v_mensaje
    );
    afirmar(v_exito = 1 AND v_codigo = 'TICKET_CERRADO', 'cerrar ticket');

    SELECT e.NOMBRE_ESTADO INTO v_estado
      FROM TICKETS.TK_TICKETS t
      JOIN TICKETS.TK_CAT_ESTADOS e ON e.ID_ESTADO = t.ID_ESTADO
     WHERE t.ID_TICKET = v_id_ticket;
    afirmar(v_estado = 'Cerrado', 'validar estado final Cerrado');

    -- Registrar encuesta de satisfacciÃƒÂ³n.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.REGISTRAR_ENCUESTA(
        p_id_ticket    => v_id_ticket,
        p_calificacion => 5,
        p_comentario   => 'Prueba de satisfacciÃƒÂ³n exitosa.',
        po_id_encuesta => v_id_encuesta,
        po_exito       => v_exito,
        pv_codigo      => v_codigo,
        pv_mensaje     => v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_encuesta IS NOT NULL, 'registrar encuesta');

    SELECT COUNT(*) INTO v_count FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = v_id_ticket;
    afirmar(v_count >= 3, 'registrar comentarios de las acciones');

    limpiar_prueba;
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS DE NEGOCIO PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar_prueba;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA DE NEGOCIO FALLÃƒâ€œ ===');
        RAISE;
END;
/
