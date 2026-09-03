-- Body del paquete de reglas de negocio de tickets
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_TICKETS_NEGOCIO_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_TICKETS_NEGOCIO_PKG';

    PROCEDURE iniciar_accion(p_accion IN VARCHAR2) IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => p_accion
        );
    END iniciar_accion;

    PROCEDURE resultado_ok(
        po_exito   OUT NUMBER,
        pv_codigo  OUT VARCHAR2,
        pv_mensaje OUT VARCHAR2,
        p_codigo   IN VARCHAR2,
        p_mensaje  IN VARCHAR2
    ) IS
    BEGIN
        po_exito := 1;
        pv_codigo := p_codigo;
        pv_mensaje := p_mensaje;
    END resultado_ok;

    PROCEDURE resultado_error(
        po_exito   OUT NUMBER,
        pv_codigo  OUT VARCHAR2,
        pv_mensaje OUT VARCHAR2,
        p_accion   IN VARCHAR2
    ) IS
    BEGIN
        ROLLBACK TO TK_NEGOCIO;
        po_exito := 0;
        IF SQLCODE = -1 THEN
            pv_codigo := 'DUPLICADO';
        ELSIF SQLCODE BETWEEN -20999 AND -20000 THEN
            pv_codigo := 'REGLA_NEGOCIO';
        ELSE
            pv_codigo := 'ERROR_SQL';
        END IF;
        pv_mensaje := c_modulo || '.' || p_accion || ': ' || SQLERRM;
    END resultado_error;

    PROCEDURE validar_usuario_activo(p_id_usuario IN NUMBER) IS
        v_count PLS_INTEGER;
    BEGIN
        IF p_id_usuario IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'El usuario es obligatorio');
        END IF;
        SELECT COUNT(*) INTO v_count
          FROM TICKETS.TK_USUARIOS
         WHERE ID_USUARIO = p_id_usuario
           AND ACTIVO = 'S';
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El usuario no existe o está inactivo');
        END IF;
    END validar_usuario_activo;

    PROCEDURE validar_tecnico(p_id_tecnico IN NUMBER) IS
        v_count PLS_INTEGER;
    BEGIN
        IF p_id_tecnico IS NULL THEN
            RAISE_APPLICATION_ERROR(-20003, 'El técnico es obligatorio');
        END IF;
        SELECT COUNT(*) INTO v_count
          FROM TICKETS.TK_USUARIOS u
          JOIN TICKETS.TK_USUARIOS_ROLES ur ON ur.ID_USUARIO = u.ID_USUARIO
          JOIN TICKETS.TK_ROLES r ON r.ID_ROL = ur.ID_ROL
         WHERE u.ID_USUARIO = p_id_tecnico
           AND u.ACTIVO = 'S'
           AND r.ACTIVO = 'S'
           AND r.NOMBRE_ROL = 'Técnico';
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'El usuario no existe, está inactivo o no tiene rol Técnico');
        END IF;
    END validar_tecnico;

    PROCEDURE validar_catalogos(
        p_id_categoria IN NUMBER,
        p_id_prioridad IN NUMBER,
        p_id_area      IN NUMBER
    ) IS
        v_count PLS_INTEGER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM TICKETS.TK_CATEGORIAS
         WHERE ID_CATEGORIA = p_id_categoria AND ACTIVA = 'S';
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'La categoría no existe o está inactiva');
        END IF;

        SELECT COUNT(*) INTO v_count FROM TICKETS.TK_CAT_PRIORIDADES
         WHERE ID_PRIORIDAD = p_id_prioridad AND ACTIVA = 'S';
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'La prioridad no existe o está inactiva');
        END IF;

        SELECT COUNT(*) INTO v_count FROM TICKETS.TK_AREAS
         WHERE ID_AREA = p_id_area AND ACTIVA = 'S';
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'El área no existe o está inactiva');
        END IF;
    END validar_catalogos;

    FUNCTION obtener_estado(p_nombre IN VARCHAR2) RETURN NUMBER IS
        v_id TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE;
    BEGIN
        SELECT ID_ESTADO INTO v_id
          FROM TICKETS.TK_CAT_ESTADOS
         WHERE NOMBRE_ESTADO = p_nombre
           AND ACTIVO = 'S';
        RETURN v_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20008, 'El estado activo no existe: ' || p_nombre);
    END obtener_estado;

    PROCEDURE bloquear_ticket(
        p_id_ticket   IN  NUMBER,
        po_estado     OUT VARCHAR2,
        po_tecnico    OUT NUMBER
    ) IS
        v_dummy NUMBER;
    BEGIN
        IF p_id_ticket IS NULL OR p_id_ticket < 1 THEN
            RAISE_APPLICATION_ERROR(-20009, 'El ID del ticket es obligatorio y debe ser mayor que cero');
        END IF;
        SELECT e.NOMBRE_ESTADO, t.ID_TECNICO_ASIGNADO, t.ID_TICKET
          INTO po_estado, po_tecnico, v_dummy
          FROM TICKETS.TK_TICKETS t
          JOIN TICKETS.TK_CAT_ESTADOS e ON e.ID_ESTADO = t.ID_ESTADO
         WHERE t.ID_TICKET = p_id_ticket
         FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'El ticket no existe');
    END bloquear_ticket;

    PROCEDURE validar_no_terminal(p_estado IN VARCHAR2) IS
    BEGIN
        IF p_estado IN ('Cerrado', 'Cancelado') THEN
            RAISE_APPLICATION_ERROR(-20011, 'El ticket está en estado terminal: ' || p_estado);
        END IF;
    END validar_no_terminal;

    PROCEDURE registrar_comentario(
        p_id_ticket     IN  NUMBER,
        p_id_usuario    IN  NUMBER,
        p_comentario    IN  VARCHAR2,
        po_id           OUT NUMBER
    ) IS
    BEGIN
        validar_usuario_activo(p_id_usuario);
        IF p_comentario IS NULL OR LENGTH(TRIM(p_comentario)) = 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'El comentario es obligatorio');
        END IF;
        INSERT INTO TICKETS.TK_COMENTARIOS (
            ID_TICKET, ID_USUARIO, COMENTARIO, ACTIVO
        ) VALUES (
            p_id_ticket, p_id_usuario, p_comentario, 'S'
        ) RETURNING ID_COMENTARIO INTO po_id;
    END registrar_comentario;

    PROCEDURE CREAR_TICKET(
        p_nombre_ticket       IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion         IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_usuario_reporta  IN  TICKETS.TK_TICKETS.ID_USUARIO_REPORTA%TYPE,
        p_id_categoria        IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad        IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_area             IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_horas_estimadas     IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE,
        po_id_ticket          OUT TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    ) AS
        v_estado_nuevo TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE;
    BEGIN
        iniciar_accion('CREAR_TICKET');
        SAVEPOINT TK_NEGOCIO;
        po_id_ticket := NULL;
        IF p_nombre_ticket IS NULL OR LENGTH(TRIM(p_nombre_ticket)) = 0 THEN
            RAISE_APPLICATION_ERROR(-20013, 'El nombre del ticket es obligatorio');
        END IF;
        IF p_descripcion IS NULL OR DBMS_LOB.GETLENGTH(p_descripcion) = 0 THEN
            RAISE_APPLICATION_ERROR(-20014, 'La descripción del ticket es obligatoria');
        END IF;
        IF p_horas_estimadas IS NOT NULL AND p_horas_estimadas < 0 THEN
            RAISE_APPLICATION_ERROR(-20015, 'Las horas estimadas no pueden ser negativas');
        END IF;
        validar_usuario_activo(p_id_usuario_reporta);
        validar_catalogos(p_id_categoria, p_id_prioridad, p_id_area);
        v_estado_nuevo := obtener_estado('Nuevo');

        INSERT INTO TICKETS.TK_TICKETS (
            NOMBRE_TICKET, DESCRIPCION, ID_USUARIO_REPORTA,
            ID_CATEGORIA, ID_PRIORIDAD, ID_ESTADO, ID_AREA, HORAS_ESTIMADAS
        ) VALUES (
            TRIM(p_nombre_ticket), p_descripcion, p_id_usuario_reporta,
            p_id_categoria, p_id_prioridad, v_estado_nuevo, p_id_area, p_horas_estimadas
        ) RETURNING ID_TICKET INTO po_id_ticket;

        COMMIT;
        resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_CREADO', 'Ticket creado correctamente');
    EXCEPTION
        WHEN OTHERS THEN
            po_id_ticket := NULL;
            resultado_error(po_exito, pv_codigo, pv_mensaje, 'CREAR_TICKET');
    END CREAR_TICKET;

    PROCEDURE ACTUALIZAR_TICKET(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_nombre_ticket       IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion         IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_categoria        IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad        IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_area             IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_horas_estimadas     IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50);
        v_tecnico NUMBER;
    BEGIN
        iniciar_accion('ACTUALIZAR_TICKET');
        SAVEPOINT TK_NEGOCIO;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico);
        validar_no_terminal(v_estado);
        IF p_nombre_ticket IS NULL OR LENGTH(TRIM(p_nombre_ticket)) = 0 THEN
            RAISE_APPLICATION_ERROR(-20013, 'El nombre del ticket es obligatorio');
        END IF;
        IF p_descripcion IS NULL OR DBMS_LOB.GETLENGTH(p_descripcion) = 0 THEN
            RAISE_APPLICATION_ERROR(-20014, 'La descripción del ticket es obligatoria');
        END IF;
        IF p_horas_estimadas IS NOT NULL AND p_horas_estimadas < 0 THEN
            RAISE_APPLICATION_ERROR(-20015, 'Las horas estimadas no pueden ser negativas');
        END IF;
        validar_catalogos(p_id_categoria, p_id_prioridad, p_id_area);
        UPDATE TICKETS.TK_TICKETS
           SET NOMBRE_TICKET = TRIM(p_nombre_ticket), DESCRIPCION = p_descripcion,
               ID_CATEGORIA = p_id_categoria, ID_PRIORIDAD = p_id_prioridad,
               ID_AREA = p_id_area, HORAS_ESTIMADAS = p_horas_estimadas
         WHERE ID_TICKET = p_id_ticket;
        COMMIT;
        resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_ACTUALIZADO', 'Ticket actualizado correctamente');
    EXCEPTION
        WHEN OTHERS THEN
            resultado_error(po_exito, pv_codigo, pv_mensaje, 'ACTUALIZAR_TICKET');
    END ACTUALIZAR_TICKET;

    PROCEDURE ASIGNAR_TICKET(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_tecnico IN TICKETS.TK_TICKETS.ID_TECNICO_ASIGNADO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER;
    BEGIN
        iniciar_accion('ASIGNAR_TICKET'); SAVEPOINT TK_NEGOCIO;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        validar_tecnico(p_id_tecnico); v_estado_id := obtener_estado('Asignado');
        UPDATE TICKETS.TK_TICKETS SET ID_TECNICO_ASIGNADO = p_id_tecnico,
               ID_ESTADO = v_estado_id, FECHA_ASIGNACION = COALESCE(FECHA_ASIGNACION, SYSTIMESTAMP)
         WHERE ID_TICKET = p_id_ticket;
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_ASIGNADO', 'Ticket asignado correctamente');
    EXCEPTION WHEN OTHERS THEN resultado_error(po_exito, pv_codigo, pv_mensaje, 'ASIGNAR_TICKET');
    END ASIGNAR_TICKET;

    PROCEDURE INICIAR_ATENCION(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER;
    BEGIN
        iniciar_accion('INICIAR_ATENCION'); SAVEPOINT TK_NEGOCIO;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        IF v_tecnico IS NULL THEN RAISE_APPLICATION_ERROR(-20016, 'El ticket debe tener un técnico asignado'); END IF;
        IF v_estado NOT IN ('Asignado', 'Pendiente') THEN
            RAISE_APPLICATION_ERROR(-20017, 'El ticket no puede iniciar atención desde el estado ' || v_estado);
        END IF;
        v_estado_id := obtener_estado('En Proceso');
        UPDATE TICKETS.TK_TICKETS SET ID_ESTADO = v_estado_id,
               FECHA_INICIO = COALESCE(FECHA_INICIO, SYSTIMESTAMP)
         WHERE ID_TICKET = p_id_ticket;
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'ATENCION_INICIADA', 'Atención iniciada correctamente');
    EXCEPTION WHEN OTHERS THEN resultado_error(po_exito, pv_codigo, pv_mensaje, 'INICIAR_ATENCION');
    END INICIAR_ATENCION;

    PROCEDURE PONER_EN_ESPERA(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario IN TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_motivo IN VARCHAR2, po_id_comentario OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER;
    BEGIN
        iniciar_accion('PONER_EN_ESPERA'); SAVEPOINT TK_NEGOCIO; po_id_comentario := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        IF p_motivo IS NULL OR LENGTH(TRIM(p_motivo)) = 0 THEN RAISE_APPLICATION_ERROR(-20018, 'El motivo de espera es obligatorio'); END IF;
        IF v_estado NOT IN ('Asignado', 'En Proceso') THEN RAISE_APPLICATION_ERROR(-20019, 'El ticket no puede ponerse en espera desde ' || v_estado); END IF;
        v_estado_id := obtener_estado('Pendiente');
        UPDATE TICKETS.TK_TICKETS SET ID_ESTADO = v_estado_id WHERE ID_TICKET = p_id_ticket;
        registrar_comentario(p_id_ticket, p_id_usuario, 'Ticket puesto en espera: ' || TRIM(p_motivo), po_id_comentario);
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_EN_ESPERA', 'Ticket puesto en espera correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_comentario := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'PONER_EN_ESPERA');
    END PONER_EN_ESPERA;

    PROCEDURE RESOLVER_TICKET(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario IN TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_solucion IN TICKETS.TK_TICKETS.DESCRIPCION_SOLUCION%TYPE,
        po_id_comentario OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER;
    BEGIN
        iniciar_accion('RESOLVER_TICKET'); SAVEPOINT TK_NEGOCIO; po_id_comentario := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        IF p_solucion IS NULL OR DBMS_LOB.GETLENGTH(p_solucion) = 0 THEN RAISE_APPLICATION_ERROR(-20020, 'La solución es obligatoria'); END IF;
        IF v_estado NOT IN ('En Proceso', 'Pendiente') THEN RAISE_APPLICATION_ERROR(-20021, 'El ticket no puede resolverse desde ' || v_estado); END IF;
        v_estado_id := obtener_estado('Resuelto');
        UPDATE TICKETS.TK_TICKETS SET ID_ESTADO = v_estado_id, DESCRIPCION_SOLUCION = p_solucion,
               FECHA_RESOLUCION = SYSTIMESTAMP WHERE ID_TICKET = p_id_ticket;
        registrar_comentario(p_id_ticket, p_id_usuario, 'Ticket resuelto: ' || DBMS_LOB.SUBSTR(p_solucion, 3900, 1), po_id_comentario);
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_RESUELTO', 'Ticket resuelto correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_comentario := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'RESOLVER_TICKET');
    END RESOLVER_TICKET;

    PROCEDURE CERRAR_TICKET(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario IN TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario IN TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER; v_comentario VARCHAR2(4000);
    BEGIN
        iniciar_accion('CERRAR_TICKET'); SAVEPOINT TK_NEGOCIO; po_id_comentario := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico);
        IF v_estado <> 'Resuelto' THEN RAISE_APPLICATION_ERROR(-20022, 'Solo se pueden cerrar tickets en estado Resuelto'); END IF;
        v_estado_id := obtener_estado('Cerrado');
        UPDATE TICKETS.TK_TICKETS SET ID_ESTADO = v_estado_id, FECHA_CIERRE = SYSTIMESTAMP WHERE ID_TICKET = p_id_ticket;
        v_comentario := COALESCE(NULLIF(TRIM(p_comentario), ''), 'Ticket cerrado');
        registrar_comentario(p_id_ticket, p_id_usuario, v_comentario, po_id_comentario);
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_CERRADO', 'Ticket cerrado correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_comentario := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'CERRAR_TICKET');
    END CERRAR_TICKET;

    PROCEDURE REABRIR_TICKET(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario IN TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_justificacion IN TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER;
    BEGIN
        iniciar_accion('REABRIR_TICKET'); SAVEPOINT TK_NEGOCIO; po_id_comentario := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico);
        IF v_estado <> 'Cerrado' THEN RAISE_APPLICATION_ERROR(-20023, 'Solo se pueden reabrir tickets cerrados'); END IF;
        IF p_justificacion IS NULL OR LENGTH(TRIM(p_justificacion)) = 0 THEN RAISE_APPLICATION_ERROR(-20024, 'La justificación es obligatoria'); END IF;
        v_estado_id := obtener_estado('En Proceso');
        UPDATE TICKETS.TK_TICKETS SET ID_ESTADO = v_estado_id, FECHA_CIERRE = NULL, FECHA_RESOLUCION = NULL WHERE ID_TICKET = p_id_ticket;
        registrar_comentario(p_id_ticket, p_id_usuario, 'Ticket reabierto: ' || TRIM(p_justificacion), po_id_comentario);
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_REABIERTO', 'Ticket reabierto correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_comentario := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'REABRIR_TICKET');
    END REABRIR_TICKET;

    PROCEDURE CANCELAR_TICKET(
        p_id_ticket IN TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario IN TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_motivo IN TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_estado_id NUMBER;
    BEGIN
        iniciar_accion('CANCELAR_TICKET'); SAVEPOINT TK_NEGOCIO; po_id_comentario := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        IF p_motivo IS NULL OR LENGTH(TRIM(p_motivo)) = 0 THEN RAISE_APPLICATION_ERROR(-20025, 'El motivo de cancelación es obligatorio'); END IF;
        v_estado_id := obtener_estado('Cancelado');
        UPDATE TICKETS.TK_TICKETS SET ID_ESTADO = v_estado_id WHERE ID_TICKET = p_id_ticket;
        registrar_comentario(p_id_ticket, p_id_usuario, 'Ticket cancelado: ' || TRIM(p_motivo), po_id_comentario);
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'TICKET_CANCELADO', 'Ticket cancelado correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_comentario := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'CANCELAR_TICKET');
    END CANCELAR_TICKET;

    PROCEDURE AGREGAR_COMENTARIO(
        p_id_ticket IN TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario IN TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario IN TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER;
    BEGIN
        iniciar_accion('AGREGAR_COMENTARIO'); SAVEPOINT TK_NEGOCIO; po_id_comentario := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        registrar_comentario(p_id_ticket, p_id_usuario, p_comentario, po_id_comentario);
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'COMENTARIO_AGREGADO', 'Comentario agregado correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_comentario := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'AGREGAR_COMENTARIO');
    END AGREGAR_COMENTARIO;

    PROCEDURE REGISTRAR_ENCUESTA(
        p_id_ticket IN TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion IN TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario IN TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        po_id_encuesta OUT TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER;
    BEGIN
        iniciar_accion('REGISTRAR_ENCUESTA'); SAVEPOINT TK_NEGOCIO; po_id_encuesta := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico);
        IF v_estado <> 'Cerrado' THEN RAISE_APPLICATION_ERROR(-20026, 'La encuesta solo puede registrarse para tickets cerrados'); END IF;
        IF p_calificacion IS NULL OR p_calificacion < 1 OR p_calificacion > 5 THEN RAISE_APPLICATION_ERROR(-20027, 'La calificación debe estar entre 1 y 5'); END IF;
        INSERT INTO TICKETS.TK_ENCUESTAS (ID_TICKET, CALIFICACION, COMENTARIO)
        VALUES (p_id_ticket, p_calificacion, p_comentario)
        RETURNING ID_ENCUESTA INTO po_id_encuesta;
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'ENCUESTA_REGISTRADA', 'Encuesta registrada correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_encuesta := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'REGISTRAR_ENCUESTA');
    END REGISTRAR_ENCUESTA;

    PROCEDURE ASOCIAR_ACTIVO(
        p_id_ticket IN TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        p_id_activo IN TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        po_id_activo_ticket OUT TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        po_exito OUT NUMBER, pv_codigo OUT VARCHAR2, pv_mensaje OUT VARCHAR2
    ) AS
        v_estado VARCHAR2(50); v_tecnico NUMBER; v_count PLS_INTEGER;
    BEGIN
        iniciar_accion('ASOCIAR_ACTIVO'); SAVEPOINT TK_NEGOCIO; po_id_activo_ticket := NULL;
        bloquear_ticket(p_id_ticket, v_estado, v_tecnico); validar_no_terminal(v_estado);
        SELECT COUNT(*) INTO v_count FROM TICKETS.TK_ACTIVOS WHERE ID_ACTIVO = p_id_activo AND ACTIVO = 'S';
        IF v_count = 0 THEN RAISE_APPLICATION_ERROR(-20028, 'El activo no existe o está inactivo'); END IF;
        INSERT INTO TICKETS.TK_ACTIVOS_TICKETS (ID_ACTIVO, ID_TICKET)
        VALUES (p_id_activo, p_id_ticket)
        RETURNING ID_ACTIVO_TICKET INTO po_id_activo_ticket;
        COMMIT; resultado_ok(po_exito, pv_codigo, pv_mensaje, 'ACTIVO_ASOCIADO', 'Activo asociado correctamente');
    EXCEPTION WHEN OTHERS THEN po_id_activo_ticket := NULL; resultado_error(po_exito, pv_codigo, pv_mensaje, 'ASOCIAR_ACTIVO');
    END ASOCIAR_ACTIVO;

END TK_TICKETS_NEGOCIO_PKG;
/
