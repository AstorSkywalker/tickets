-- Especificación del paquete de reglas de negocio de tickets
CONNECT TICKETS/Tickets123@192.168.80.178:1521/FREEpdb1
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKETS_NEGOCIO_PKG AS

    PROCEDURE CREAR_TICKET(
        p_nombre_ticket       IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion         IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_usuario_reporta  IN  TICKETS.TK_TICKETS.ID_USUARIO_REPORTA%TYPE,
        p_id_categoria        IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad        IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_area             IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_horas_estimadas     IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE DEFAULT NULL,
        po_id_ticket          OUT TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

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
    );

    PROCEDURE ASIGNAR_TICKET(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_tecnico          IN  TICKETS.TK_TICKETS.ID_TECNICO_ASIGNADO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE INICIAR_ATENCION(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE PONER_EN_ESPERA(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario          IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_motivo              IN  VARCHAR2,
        po_id_comentario      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE RESOLVER_TICKET(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario          IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_solucion            IN  TICKETS.TK_TICKETS.DESCRIPCION_SOLUCION%TYPE,
        po_id_comentario      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE CERRAR_TICKET(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario          IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario          IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE DEFAULT NULL,
        po_id_comentario      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE REABRIR_TICKET(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario          IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_justificacion       IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE CANCELAR_TICKET(
        p_id_ticket           IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_id_usuario          IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_motivo              IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE AGREGAR_COMENTARIO(
        p_id_ticket           IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario          IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario          IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        po_id_comentario      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE REGISTRAR_ENCUESTA(
        p_id_ticket           IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion        IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario          IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE DEFAULT NULL,
        po_id_encuesta        OUT TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

    PROCEDURE ASOCIAR_ACTIVO(
        p_id_ticket           IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        p_id_activo           IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        po_id_activo_ticket   OUT TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        po_exito              OUT NUMBER,
        pv_codigo             OUT VARCHAR2,
        pv_mensaje            OUT VARCHAR2
    );

END TK_TICKETS_NEGOCIO_PKG;
/
