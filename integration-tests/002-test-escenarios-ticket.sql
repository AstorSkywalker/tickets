-- Escenarios integrales adicionales: espera, cancelacion y reapertura.
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_ticket        NUMBER;
    v_usuario       NUMBER;
    v_tecnico       NUMBER;
    v_supervisor    NUMBER;
    v_categoria     NUMBER;
    v_prioridad     NUMBER;
    v_area          NUMBER;
    v_comentario    NUMBER;
    v_exito         NUMBER;
    v_codigo        VARCHAR2(100);
    v_mensaje       VARCHAR2(4000);
    v_estado        VARCHAR2(100);
    v_marca         VARCHAR2(30) := TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;

    PROCEDURE estado_actual(p_id IN NUMBER, p_estado OUT VARCHAR2) IS
    BEGIN
        SELECT e.NOMBRE_ESTADO INTO p_estado
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
            COMMIT;
        END IF;
    END limpiar;

    PROCEDURE crear_ticket IS
    BEGIN
        TICKETS.TK_TICKETS_NEGOCIO_PKG.CREAR_TICKET(
            'TEST ESCENARIO ' || v_marca, TO_CLOB('Prueba integral de escenario.'),
            v_usuario, v_categoria, v_prioridad, v_area, 2,
            v_ticket, v_exito, v_codigo, v_mensaje);
        afirmar(v_exito = 1 AND v_ticket IS NOT NULL, 'crear ticket de escenario');
    END crear_ticket;
BEGIN
    SELECT ID_USUARIO INTO v_usuario FROM TICKETS.TK_USUARIOS
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

    crear_ticket;
    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(v_ticket, v_tecnico, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'asignar ticket para espera');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'iniciar ticket para espera');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.PONER_EN_ESPERA(
        v_ticket, v_supervisor, 'Esperando informacion del solicitante.',
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1 AND v_comentario IS NOT NULL, 'poner ticket en espera');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'Pendiente', 'validar estado Pendiente');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'retomar ticket pendiente');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.CANCELAR_TICKET(
        v_ticket, v_supervisor, 'Cancelacion solicitada para la prueba.',
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'cancelar ticket con motivo');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'Cancelado', 'validar estado Cancelado');
    limpiar;

    crear_ticket;
    TICKETS.TK_TICKETS_NEGOCIO_PKG.ASIGNAR_TICKET(v_ticket, v_tecnico, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'asignar ticket para reapertura');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.INICIAR_ATENCION(v_ticket, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'iniciar ticket para reapertura');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.RESOLVER_TICKET(
        v_ticket, v_tecnico, TO_CLOB('Solucion previa al cierre.'),
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'resolver ticket para reapertura');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.CERRAR_TICKET(
        v_ticket, v_supervisor, 'Cierre inicial.',
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'cerrar ticket para reapertura');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'Cerrado', 'validar estado Cerrado');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.REABRIR_TICKET(
        v_ticket, v_supervisor, 'Se requiere continuar la atencion.',
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 1, 'reabrir ticket cerrado');
    estado_actual(v_ticket, v_estado);
    afirmar(v_estado = 'En Proceso', 'validar estado En Proceso despues de reabrir');
    TICKETS.TK_TICKETS_NEGOCIO_PKG.REABRIR_TICKET(
        v_ticket, v_supervisor, 'No debe reabrirse nuevamente.',
        v_comentario, v_exito, v_codigo, v_mensaje);
    afirmar(v_exito = 0 AND v_codigo IS NOT NULL, 'impedir reapertura desde estado no cerrado');

    limpiar;
    DBMS_OUTPUT.PUT_LINE('=== ESCENARIOS INTEGRALES PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        limpiar;
        DBMS_OUTPUT.PUT_LINE('=== ESCENARIOS INTEGRALES FALLARON ===');
        RAISE;
END;
/
