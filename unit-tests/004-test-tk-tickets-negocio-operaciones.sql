-- Pruebas de espera, cancelaciÃ³n y asociaciÃ³n de activos
CONNECT TICKETS/Tickets123@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_ticket       TICKETS.TK_TICKETS.ID_TICKET%TYPE;
    v_id_ticket_2     TICKETS.TK_TICKETS.ID_TICKET%TYPE;
    v_id_comentario   TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE;
    v_id_activo       TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE;
    v_id_relacion     TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE;
    v_id_reporta      TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_tecnico      TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_supervisor   TICKETS.TK_USUARIOS.ID_USUARIO%TYPE;
    v_id_categoria    TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE;
    v_id_prioridad    TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE;
    v_id_area         TICKETS.TK_AREAS.ID_AREA%TYPE;
    v_id_tipo_activo  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE;
    v_estado          TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE;
    v_exito           NUMBER;
    v_codigo          VARCHAR2(100);
    v_mensaje         VARCHAR2(4000);
    v_count           PLS_INTEGER;
    v_marca_tiempo    VARCHAR2(30) := TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLÃ“: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE afirmar_error(p_mensaje IN VARCHAR2) IS
    BEGIN
        afirmar(v_exito = 0 AND v_codigo IS NOT NULL, p_mensaje);
    END afirmar_error;

    PROCEDURE limpiar_ticket(p_id IN NUMBER) IS
    BEGIN
        IF p_id IS NOT NULL THEN
            DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET = p_id;
            DELETE FROM TICKETS.TK_ENCUESTAS WHERE ID_TICKET = p_id;
            DELETE FROM TICKETS.TK_ACTIVOS_TICKETS WHERE ID_TICKET = p_id;
            DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET = p_id;
            DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET = p_id;
        END IF;
    END limpiar_ticket;

    PROCEDURE obtener_estado(p_id IN NUMBER, p_estado OUT VARCHAR2) IS
    BEGIN
        SELECT e.NOMBRE_ESTADO INTO p_estado
          FROM TICKETS.TK_TICKETS t
          JOIN TICKETS.TK_CAT_ESTADOS e ON e.ID_ESTADO = t.ID_ESTADO
         WHERE t.ID_TICKET = p_id;
    END obtener_estado;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS DE OPERACIONES DE NEGOCIO ===');

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
    SELECT MIN(ID_TIPO_ACTIVO) INTO v_id_tipo_activo
      FROM TICKETS.TK_TIPOS_ACTIVOS WHERE ACTIVO = 'S';
    afirmar(v_id_tipo_activo IS NOT NULL, 'existencia de tipo de activo semilla');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        'TEST ESPERA ' || v_marca_tiempo, TO_CLOB('Prueba de espera y cancelaciÃ³n.'),
        v_id_reporta, v_id_categoria, v_id_prioridad, v_id_area, 4,
        v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'crear ticket para espera');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(
        v_id_ticket, v_id_tecnico, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'asignar ticket para espera');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(
        v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'iniciar ticket para espera');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.PONER_EN_ESPERA(
        v_id_ticket, v_id_supervisor, 'Esperando informaciÃ³n del solicitante.',
        v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_comentario IS NOT NULL, 'poner ticket en espera');
    obtener_estado(v_id_ticket, v_estado);
    afirmar(v_estado = 'Pendiente', 'validar estado Pendiente');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(
        v_id_ticket, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'retomar ticket pendiente');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CANCELAR_TICKET(
        v_id_ticket, v_id_supervisor, 'CancelaciÃ³n solicitada para la prueba.',
        v_id_comentario, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'cancelar ticket con motivo');
    obtener_estado(v_id_ticket, v_estado);
    afirmar(v_estado = 'Cancelado', 'validar estado Cancelado');

    -- Crear un activo temporal para probar la relaciÃ³n activo-ticket.
    INSERT INTO TICKETS.TK_ACTIVOS (
        NUMERO_SERIE, NUMERO_INVENTARIO, DESCRIPCION_ACTIVO,
        MARCA, MODELO, ID_TIPO_ACTIVO, UBICACION, ACTIVO
    ) VALUES (
        'TEST-SERIE-' || v_marca_tiempo, 'TEST-INV-' || v_marca_tiempo,
        'Activo creado por prueba unitaria.', 'Marca Test', 'Modelo Test',
        v_id_tipo_activo, 'Mesa de Ayuda', 'S'
    ) RETURNING ID_ACTIVO INTO v_id_activo;

    TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
        'TEST ACTIVO ' || v_marca_tiempo, TO_CLOB('Prueba de asociaciÃ³n de activo.'),
        v_id_reporta, v_id_categoria, v_id_prioridad, v_id_area, 2,
        v_id_ticket_2, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1, 'crear ticket para activo');

    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASOCIAR_ACTIVO(
        v_id_ticket_2, v_id_activo, v_id_relacion, v_exito, v_codigo, v_mensaje
    );
    afirmar(v_exito = 1 AND v_id_relacion IS NOT NULL, 'asociar activo al ticket');

    SELECT COUNT(*) INTO v_count
      FROM TICKETS.TK_ACTIVOS_TICKETS
     WHERE ID_TICKET = v_id_ticket_2 AND ID_ACTIVO = v_id_activo;
    afirmar(v_count = 1, 'validar relaciÃ³n activo-ticket');

    limpiar_ticket(v_id_ticket);
    limpiar_ticket(v_id_ticket_2);
    DELETE FROM TICKETS.TK_ACTIVOS WHERE ID_ACTIVO = v_id_activo;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS DE OPERACIONES PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar_ticket(v_id_ticket);
        limpiar_ticket(v_id_ticket_2);
        IF v_id_activo IS NOT NULL THEN
            DELETE FROM TICKETS.TK_ACTIVOS WHERE ID_ACTIVO = v_id_activo;
        END IF;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA DE OPERACIONES FALLÃ“ ===');
        RAISE;
END;
/
