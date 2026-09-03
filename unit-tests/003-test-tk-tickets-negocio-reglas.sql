-- Pruebas de reglas negativas para TICKETS.TK_TICKETS_NEGOCIO_PKG
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
    v_id_usuario      TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_categoria    TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_id_prioridad    TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_id_area         TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_exito           NUMBER;
    v_codigo          VARCHAR2(100);
    v_mensaje         VARCHAR2(4000);
    v_nombre_ticket   VARCHAR2(200) :=
        'TEST REGLAS ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLÃƒâ€œ: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE afirmar_error(p_mensaje IN VARCHAR2) IS
    BEGIN
        afirmar(v_exito = 0 AND v_codigo IS NOT NULL, p_mensaje);
    END afirmar_error;

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
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS DE REGLAS DE NEGOCIO ===');

    SELECT ID_USUARIO INTO v_id_reporta
      FROM TICKETS.TK_USUARIOS WHERE USERNAME = 'usuario.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_id_tecnico
      FROM TICKETS.TK_USUARIOS WHERE USERNAME = 'tecnico.tickets' AND ACTIVO = 'S';
    SELECT ID_USUARIO INTO v_id_usuario
      FROM TICKETS.TK_USUARIOS WHERE USERNAME = 'supervisor.tickets' AND ACTIVO = 'S';
    SELECT ID_CATEGORIA INTO v_id_categoria
      FROM TICKETS.TK_CATEGORIAS WHERE NOMBRE_CATEGORIA = 'Incidentes' AND ACTIVA = 'S';
    SELECT ID_PRIORIDAD INTO v_id_prioridad
      FROM TICKETS.TK_CAT_PRIORIDADES WHERE NOMBRE_PRIORIDAD = 'Media' AND ACTIVA = 'S';
    SELECT ID_AREA INTO v_id_area
      FROM TICKETS.TK_AREAS WHERE NOMBRE_AREA = 'Mesa de Ayuda' AND ACTIVA = 'S';

    -- Campos obligatorios y referencias inexistentes.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        v_nombre_ticket, NULL, v_id_reporta, v_id_categoria, v_id_prioridad, v_id_area,
        4, v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('rechazar descripciÃƒÂ³n nula');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        v_nombre_ticket, TO_CLOB('DescripciÃƒÂ³n vÃƒÂ¡lida.'), v_id_reporta, -999999, v_id_prioridad, v_id_area,
        4, v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('rechazar categorÃƒÂ­a inexistente');

    -- Crear ticket vÃƒÂ¡lido para las pruebas de transiciÃƒÂ³n.
    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        v_nombre_ticket, TO_CLOB('Ticket para probar reglas de negocio.'), v_id_reporta,
        v_id_categoria, v_id_prioridad, v_id_area, 4,
        v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_ticket IS NOT NULL, 'crear ticket de prueba');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(
        v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir iniciar ticket sin tÃƒÂ©cnico');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(
        v_id_ticket, v_id_usuario, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir asignar usuario sin rol TÃƒÂ©cnico');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        v_id_ticket, v_id_tecnico, TO_CLOB('No debe resolverse todavÃƒÂ­a.'),
        v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir resolver ticket no iniciado');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(
        v_id_ticket, v_id_tecnico, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'asignar tÃƒÂ©cnico vÃƒÂ¡lido');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CERRAR_TICKET(
        v_id_ticket, v_id_usuario, NULL, v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir cerrar ticket no resuelto');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(
        v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'iniciar atenciÃƒÂ³n despuÃƒÂ©s de asignar');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CANCELAR_TICKET(
        v_id_ticket, v_id_usuario, NULL, v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir cancelar sin motivo');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        v_id_ticket, v_id_tecnico, TO_CLOB('SoluciÃƒÂ³n de prueba.'),
        v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'resolver ticket');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CERRAR_TICKET(
        v_id_ticket, v_id_usuario, 'Cierre de prueba.', v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'cerrar ticket resuelto');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.REGISTRAR_ENCUESTA(
        v_id_ticket, 5, 'Encuesta de prueba.', v_id_encuesta, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_encuesta IS NOT NULL, 'registrar primera encuesta');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.REGISTRAR_ENCUESTA(
        v_id_ticket, 4, 'No debe duplicarse.', v_id_encuesta, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir encuesta duplicada');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.REABRIR_TICKET(
        v_id_ticket, v_id_usuario, 'Se requiere continuar la atenciÃƒÂ³n.',
        v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'reabrir ticket cerrado');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.REABRIR_TICKET(
        v_id_ticket, v_id_usuario, 'No debe reabrirse nuevamente.',
        v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar_error('impedir reapertura desde estado no cerrado');

    limpiar_prueba;
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS DE REGLAS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar_prueba;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA DE REGLAS FALLÃƒâ€œ ===');
        RAISE;
END;
/
