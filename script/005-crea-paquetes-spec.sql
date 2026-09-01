-- Especificaciones de paquetes CRUD del proyecto de tickets
CONNECT TICKETS/Tickets123

-- Cada paquete expone crear, actualizar, eliminar y consultar.

CREATE OR REPLACE PACKAGE TICKETS.TK_AREAS_CRUD_PKG AS

    PROCEDURE TK_AREAS_CREAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        p_nombre_area                    IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        p_descripcion                    IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_AREAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_AREAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_AREAS.ACTIVA%TYPE,
        po_ID_AREA_generado            OUT TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        p_nombre_area                    IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        p_descripcion                    IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_AREAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_AREAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_AREAS.ACTIVA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_AREAS_ELIMINAR_P(
        p_ID_AREA                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_AREAS_CONSULTAR_F(
        p_ID_AREA                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_AREAS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG AS

    PROCEDURE TK_BASE_CONOCIMIENTOS_CREAR_P(
        p_id_base_conocimiento           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        p_titulo                         IN  TICKETS.TK_BASE_CONOCIMIENTOS.TITULO%TYPE,
        p_descripcion                    IN  TICKETS.TK_BASE_CONOCIMIENTOS.DESCRIPCION%TYPE,
        p_palabras_clave                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.PALABRAS_CLAVE%TYPE,
        p_publicado                      IN  TICKETS.TK_BASE_CONOCIMIENTOS.PUBLICADO%TYPE,
        p_id_usuario_autor               IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_USUARIO_AUTOR%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_BASE_CONOCIMIENTO_generado  OUT TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P(
        p_id_base_conocimiento           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        p_titulo                         IN  TICKETS.TK_BASE_CONOCIMIENTOS.TITULO%TYPE,
        p_descripcion                    IN  TICKETS.TK_BASE_CONOCIMIENTOS.DESCRIPCION%TYPE,
        p_palabras_clave                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.PALABRAS_CLAVE%TYPE,
        p_publicado                      IN  TICKETS.TK_BASE_CONOCIMIENTOS.PUBLICADO%TYPE,
        p_id_usuario_autor               IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_USUARIO_AUTOR%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_BASE_CONOCIMIENTOS_ELIMINAR_P(
        p_ID_BASE_CONOCIMIENTO           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_BASE_CONOCIMIENTOS_CONSULTAR_F(
        p_ID_BASE_CONOCIMIENTO           IN  TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_BASE_CONOCIMIENTOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_CAT_ESTADOS_CRUD_PKG AS

    PROCEDURE TK_CAT_ESTADOS_CREAR_P(
        p_id_estado                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        p_nombre_estado                  IN  TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE,
        p_descripcion_estado             IN  TICKETS.TK_CAT_ESTADOS.DESCRIPCION_ESTADO%TYPE,
        p_cerrado                        IN  TICKETS.TK_CAT_ESTADOS.CERRADO%TYPE,
        p_orden_visualizacion            IN  TICKETS.TK_CAT_ESTADOS.ORDEN_VISUALIZACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_ESTADOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_ESTADOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_ESTADOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_ESTADOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_CAT_ESTADOS.ACTIVO%TYPE,
        po_ID_ESTADO_generado          OUT TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CAT_ESTADOS_ACTUALIZAR_P(
        p_id_estado                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        p_nombre_estado                  IN  TICKETS.TK_CAT_ESTADOS.NOMBRE_ESTADO%TYPE,
        p_descripcion_estado             IN  TICKETS.TK_CAT_ESTADOS.DESCRIPCION_ESTADO%TYPE,
        p_cerrado                        IN  TICKETS.TK_CAT_ESTADOS.CERRADO%TYPE,
        p_orden_visualizacion            IN  TICKETS.TK_CAT_ESTADOS.ORDEN_VISUALIZACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_ESTADOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_ESTADOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_ESTADOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_ESTADOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_CAT_ESTADOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CAT_ESTADOS_ELIMINAR_P(
        p_ID_ESTADO                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_CAT_ESTADOS_CONSULTAR_F(
        p_ID_ESTADO                      IN  TICKETS.TK_CAT_ESTADOS.ID_ESTADO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_CAT_ESTADOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_CAT_PRIORIDADES_CRUD_PKG AS

    PROCEDURE TK_CAT_PRIORIDADES_CREAR_P(
        p_id_prioridad                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        p_nombre_prioridad               IN  TICKETS.TK_CAT_PRIORIDADES.NOMBRE_PRIORIDAD%TYPE,
        p_nivel                          IN  TICKETS.TK_CAT_PRIORIDADES.NIVEL%TYPE,
        p_tiempo_sla_horas               IN  TICKETS.TK_CAT_PRIORIDADES.TIEMPO_SLA_HORAS%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CAT_PRIORIDADES.ACTIVA%TYPE,
        po_ID_PRIORIDAD_generado       OUT TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CAT_PRIORIDADES_ACTUALIZAR_P(
        p_id_prioridad                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        p_nombre_prioridad               IN  TICKETS.TK_CAT_PRIORIDADES.NOMBRE_PRIORIDAD%TYPE,
        p_nivel                          IN  TICKETS.TK_CAT_PRIORIDADES.NIVEL%TYPE,
        p_tiempo_sla_horas               IN  TICKETS.TK_CAT_PRIORIDADES.TIEMPO_SLA_HORAS%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CAT_PRIORIDADES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CAT_PRIORIDADES.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CAT_PRIORIDADES.ACTIVA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CAT_PRIORIDADES_ELIMINAR_P(
        p_ID_PRIORIDAD                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_CAT_PRIORIDADES_CONSULTAR_F(
        p_ID_PRIORIDAD                   IN  TICKETS.TK_CAT_PRIORIDADES.ID_PRIORIDAD%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_CAT_PRIORIDADES_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_CATEGORIAS_CRUD_PKG AS

    PROCEDURE TK_CATEGORIAS_CREAR_P(
        p_id_categoria                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        p_nombre_categoria               IN  TICKETS.TK_CATEGORIAS.NOMBRE_CATEGORIA%TYPE,
        p_descripcion                    IN  TICKETS.TK_CATEGORIAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CATEGORIAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CATEGORIAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CATEGORIAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CATEGORIAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CATEGORIAS.ACTIVA%TYPE,
        po_ID_CATEGORIA_generado       OUT TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CATEGORIAS_ACTUALIZAR_P(
        p_id_categoria                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        p_nombre_categoria               IN  TICKETS.TK_CATEGORIAS.NOMBRE_CATEGORIA%TYPE,
        p_descripcion                    IN  TICKETS.TK_CATEGORIAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_CATEGORIAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_CATEGORIAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_CATEGORIAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_CATEGORIAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_CATEGORIAS.ACTIVA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_CATEGORIAS_ELIMINAR_P(
        p_ID_CATEGORIA                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_CATEGORIAS_CONSULTAR_F(
        p_ID_CATEGORIA                   IN  TICKETS.TK_CATEGORIAS.ID_CATEGORIA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_CATEGORIAS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_COMENTARIOS_CRUD_PKG AS

    PROCEDURE TK_COMENTARIOS_CREAR_P(
        p_id_comentario                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario                     IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario                     IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_COMENTARIOS.ACTIVO%TYPE,
        po_ID_COMENTARIO_generado      OUT TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_COMENTARIOS_ACTUALIZAR_P(
        p_id_comentario                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_COMENTARIOS.ID_TICKET%TYPE,
        p_id_usuario                     IN  TICKETS.TK_COMENTARIOS.ID_USUARIO%TYPE,
        p_comentario                     IN  TICKETS.TK_COMENTARIOS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_COMENTARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_COMENTARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_COMENTARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_COMENTARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_COMENTARIOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_COMENTARIOS_ELIMINAR_P(
        p_ID_COMENTARIO                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_COMENTARIOS_CONSULTAR_F(
        p_ID_COMENTARIO                  IN  TICKETS.TK_COMENTARIOS.ID_COMENTARIO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_COMENTARIOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_ENCUESTAS_CRUD_PKG AS

    PROCEDURE TK_ENCUESTAS_CREAR_P(
        p_id_encuesta                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion                   IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario                     IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_ENCUESTA_generado        OUT TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ENCUESTAS_ACTUALIZAR_P(
        p_id_encuesta                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ENCUESTAS.ID_TICKET%TYPE,
        p_calificacion                   IN  TICKETS.TK_ENCUESTAS.CALIFICACION%TYPE,
        p_comentario                     IN  TICKETS.TK_ENCUESTAS.COMENTARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ENCUESTAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ENCUESTAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ENCUESTAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ENCUESTAS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ENCUESTAS_ELIMINAR_P(
        p_ID_ENCUESTA                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ENCUESTAS_CONSULTAR_F(
        p_ID_ENCUESTA                    IN  TICKETS.TK_ENCUESTAS.ID_ENCUESTA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ENCUESTAS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_ROLES_CRUD_PKG AS

    PROCEDURE TK_ROLES_CREAR_P(
        p_id_rol                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE,
        p_nombre_rol                     IN  TICKETS.TK_ROLES.NOMBRE_ROL%TYPE,
        p_descripcion                    IN  TICKETS.TK_ROLES.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ROLES.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ROLES.ACTIVO%TYPE,
        po_ID_ROL_generado             OUT TICKETS.TK_ROLES.ID_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ROLES_ACTUALIZAR_P(
        p_id_rol                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE,
        p_nombre_rol                     IN  TICKETS.TK_ROLES.NOMBRE_ROL%TYPE,
        p_descripcion                    IN  TICKETS.TK_ROLES.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ROLES.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ROLES.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ROLES_ELIMINAR_P(
        p_ID_ROL                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ROLES_CONSULTAR_F(
        p_ID_ROL                         IN  TICKETS.TK_ROLES.ID_ROL%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ROLES_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKET_ADJUNTOS_CRUD_PKG AS

    PROCEDURE TK_TICKET_ADJUNTOS_CREAR_P(
        p_id_adjunto                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKET_ADJUNTOS.ID_TICKET%TYPE,
        p_nombre_archivo                 IN  TICKETS.TK_TICKET_ADJUNTOS.NOMBRE_ARCHIVO%TYPE,
        p_extension                      IN  TICKETS.TK_TICKET_ADJUNTOS.EXTENSION%TYPE,
        p_mime_type                      IN  TICKETS.TK_TICKET_ADJUNTOS.MIME_TYPE%TYPE,
        p_tamano_bytes                   IN  TICKETS.TK_TICKET_ADJUNTOS.TAMANO_BYTES%TYPE,
        p_archivo                        IN  TICKETS.TK_TICKET_ADJUNTOS.ARCHIVO%TYPE,
        p_hash_sha256                    IN  TICKETS.TK_TICKET_ADJUNTOS.HASH_SHA256%TYPE,
        p_id_usuario                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_USUARIO%TYPE,
        p_fecha_carga                    IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CARGA%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TICKET_ADJUNTOS.ACTIVO%TYPE,
        po_ID_ADJUNTO_generado         OUT TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKET_ADJUNTOS_ACTUALIZAR_P(
        p_id_adjunto                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKET_ADJUNTOS.ID_TICKET%TYPE,
        p_nombre_archivo                 IN  TICKETS.TK_TICKET_ADJUNTOS.NOMBRE_ARCHIVO%TYPE,
        p_extension                      IN  TICKETS.TK_TICKET_ADJUNTOS.EXTENSION%TYPE,
        p_mime_type                      IN  TICKETS.TK_TICKET_ADJUNTOS.MIME_TYPE%TYPE,
        p_tamano_bytes                   IN  TICKETS.TK_TICKET_ADJUNTOS.TAMANO_BYTES%TYPE,
        p_archivo                        IN  TICKETS.TK_TICKET_ADJUNTOS.ARCHIVO%TYPE,
        p_hash_sha256                    IN  TICKETS.TK_TICKET_ADJUNTOS.HASH_SHA256%TYPE,
        p_id_usuario                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_USUARIO%TYPE,
        p_fecha_carga                    IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CARGA%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKET_ADJUNTOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKET_ADJUNTOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TICKET_ADJUNTOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKET_ADJUNTOS_ELIMINAR_P(
        p_ID_ADJUNTO                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TICKET_ADJUNTOS_CONSULTAR_F(
        p_ID_ADJUNTO                     IN  TICKETS.TK_TICKET_ADJUNTOS.ID_ADJUNTO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TICKET_ADJUNTOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKETS_CRUD_PKG AS

    PROCEDURE TK_TICKETS_CREAR_P(
        p_id_ticket                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_nombre_ticket                  IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion                    IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_usuario_reporta             IN  TICKETS.TK_TICKETS.ID_USUARIO_REPORTA%TYPE,
        p_id_tecnico_asignado            IN  TICKETS.TK_TICKETS.ID_TECNICO_ASIGNADO%TYPE,
        p_id_categoria                   IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad                   IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_estado                      IN  TICKETS.TK_TICKETS.ID_ESTADO%TYPE,
        p_id_area                        IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_fecha_solicitud                IN  TICKETS.TK_TICKETS.FECHA_SOLICITUD%TYPE,
        p_fecha_asignacion               IN  TICKETS.TK_TICKETS.FECHA_ASIGNACION%TYPE,
        p_fecha_inicio                   IN  TICKETS.TK_TICKETS.FECHA_INICIO%TYPE,
        p_fecha_resolucion               IN  TICKETS.TK_TICKETS.FECHA_RESOLUCION%TYPE,
        p_fecha_cierre                   IN  TICKETS.TK_TICKETS.FECHA_CIERRE%TYPE,
        p_horas_estimadas                IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE,
        p_horas_reales                   IN  TICKETS.TK_TICKETS.HORAS_REALES%TYPE,
        p_porcentaje_avance              IN  TICKETS.TK_TICKETS.PORCENTAJE_AVANCE%TYPE,
        p_descripcion_solucion           IN  TICKETS.TK_TICKETS.DESCRIPCION_SOLUCION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKETS.FECHA_ACTUALIZACION%TYPE,
        po_ID_TICKET_generado          OUT TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_ACTUALIZAR_P(
        p_id_ticket                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        p_nombre_ticket                  IN  TICKETS.TK_TICKETS.NOMBRE_TICKET%TYPE,
        p_descripcion                    IN  TICKETS.TK_TICKETS.DESCRIPCION%TYPE,
        p_id_usuario_reporta             IN  TICKETS.TK_TICKETS.ID_USUARIO_REPORTA%TYPE,
        p_id_tecnico_asignado            IN  TICKETS.TK_TICKETS.ID_TECNICO_ASIGNADO%TYPE,
        p_id_categoria                   IN  TICKETS.TK_TICKETS.ID_CATEGORIA%TYPE,
        p_id_prioridad                   IN  TICKETS.TK_TICKETS.ID_PRIORIDAD%TYPE,
        p_id_estado                      IN  TICKETS.TK_TICKETS.ID_ESTADO%TYPE,
        p_id_area                        IN  TICKETS.TK_TICKETS.ID_AREA%TYPE,
        p_fecha_solicitud                IN  TICKETS.TK_TICKETS.FECHA_SOLICITUD%TYPE,
        p_fecha_asignacion               IN  TICKETS.TK_TICKETS.FECHA_ASIGNACION%TYPE,
        p_fecha_inicio                   IN  TICKETS.TK_TICKETS.FECHA_INICIO%TYPE,
        p_fecha_resolucion               IN  TICKETS.TK_TICKETS.FECHA_RESOLUCION%TYPE,
        p_fecha_cierre                   IN  TICKETS.TK_TICKETS.FECHA_CIERRE%TYPE,
        p_horas_estimadas                IN  TICKETS.TK_TICKETS.HORAS_ESTIMADAS%TYPE,
        p_horas_reales                   IN  TICKETS.TK_TICKETS.HORAS_REALES%TYPE,
        p_porcentaje_avance              IN  TICKETS.TK_TICKETS.PORCENTAJE_AVANCE%TYPE,
        p_descripcion_solucion           IN  TICKETS.TK_TICKETS.DESCRIPCION_SOLUCION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TICKETS.FECHA_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_ELIMINAR_P(
        p_ID_TICKET                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TICKETS_CONSULTAR_F(
        p_ID_TICKET                      IN  TICKETS.TK_TICKETS.ID_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TICKETS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG AS

    PROCEDURE TK_TICKETS_HISTORIAL_CREAR_P(
        p_id_historial_ticket            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TICKET%TYPE,
        p_operacion                      IN  TICKETS.TK_TICKETS_HISTORIAL.OPERACION%TYPE,
        p_id_estado_anterior             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_ANTERIOR%TYPE,
        p_id_estado_nuevo                IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_NUEVO%TYPE,
        p_id_usuario_reporta_viejo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_VIEJO%TYPE,
        p_id_usuario_reporta_nuevo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_NUEVO%TYPE,
        p_id_tecnico_asignado_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_VIEJO%TYPE,
        p_id_tecnico_asignado_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_NUEVO%TYPE,
        p_id_categoria_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_VIEJO%TYPE,
        p_id_categoria_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_NUEVO%TYPE,
        p_id_prioridad_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_VIEJO%TYPE,
        p_id_prioridad_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_NUEVO%TYPE,
        p_id_area_viejo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_VIEJO%TYPE,
        p_id_area_nuevo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_NUEVO%TYPE,
        p_horas_estimadas_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_VIEJO%TYPE,
        p_horas_estimadas_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_NUEVO%TYPE,
        p_horas_reales_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_VIEJO%TYPE,
        p_horas_reales_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_NUEVO%TYPE,
        p_porcentaje_avance_viejo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_VIEJO%TYPE,
        p_porcentaje_avance_nuevo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_NUEVO%TYPE,
        p_nombre_ticket_viejo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_VIEJO%TYPE,
        p_nombre_ticket_nuevo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_NUEVO%TYPE,
        p_descripcion_viejo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_VIEJO%TYPE,
        p_descripcion_nuevo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_NUEVO%TYPE,
        p_descripcion_solucion_viejo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_VIEJO%TYPE,
        p_descripcion_solucion_nuevo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_NUEVO%TYPE,
        p_fecha_solicitud_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_VIEJO%TYPE,
        p_fecha_solicitud_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_NUEVO%TYPE,
        p_fecha_asignacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_VIEJO%TYPE,
        p_fecha_asignacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_NUEVO%TYPE,
        p_fecha_inicio_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_VIEJO%TYPE,
        p_fecha_inicio_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_NUEVO%TYPE,
        p_fecha_resolucion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_VIEJO%TYPE,
        p_fecha_resolucion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_NUEVO%TYPE,
        p_fecha_cierre_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_VIEJO%TYPE,
        p_fecha_cierre_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_NUEVO%TYPE,
        p_usuario_creacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_VIEJO%TYPE,
        p_usuario_creacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_NUEVO%TYPE,
        p_fecha_creacion_viejo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_VIEJO%TYPE,
        p_fecha_creacion_nuevo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_NUEVO%TYPE,
        p_usuario_actualizacion_viejo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_VIEJO%TYPE,
        p_usuario_actualizacion_nuevo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_NUEVO%TYPE,
        p_fecha_actualizacion_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_VIEJO%TYPE,
        p_fecha_actualizacion_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_NUEVO%TYPE,
        p_usuario_cambio                 IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CAMBIO%TYPE,
        p_fecha_cambio                   IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CAMBIO%TYPE,
        po_ID_HISTORIAL_TICKET_generado  OUT TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_HISTORIAL_ACTUALIZAR_P(
        p_id_historial_ticket            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        p_id_ticket                      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TICKET%TYPE,
        p_operacion                      IN  TICKETS.TK_TICKETS_HISTORIAL.OPERACION%TYPE,
        p_id_estado_anterior             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_ANTERIOR%TYPE,
        p_id_estado_nuevo                IN  TICKETS.TK_TICKETS_HISTORIAL.ID_ESTADO_NUEVO%TYPE,
        p_id_usuario_reporta_viejo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_VIEJO%TYPE,
        p_id_usuario_reporta_nuevo       IN  TICKETS.TK_TICKETS_HISTORIAL.ID_USUARIO_REPORTA_NUEVO%TYPE,
        p_id_tecnico_asignado_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_VIEJO%TYPE,
        p_id_tecnico_asignado_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.ID_TECNICO_ASIGNADO_NUEVO%TYPE,
        p_id_categoria_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_VIEJO%TYPE,
        p_id_categoria_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_CATEGORIA_NUEVO%TYPE,
        p_id_prioridad_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_VIEJO%TYPE,
        p_id_prioridad_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.ID_PRIORIDAD_NUEVO%TYPE,
        p_id_area_viejo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_VIEJO%TYPE,
        p_id_area_nuevo                  IN  TICKETS.TK_TICKETS_HISTORIAL.ID_AREA_NUEVO%TYPE,
        p_horas_estimadas_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_VIEJO%TYPE,
        p_horas_estimadas_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_ESTIMADAS_NUEVO%TYPE,
        p_horas_reales_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_VIEJO%TYPE,
        p_horas_reales_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.HORAS_REALES_NUEVO%TYPE,
        p_porcentaje_avance_viejo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_VIEJO%TYPE,
        p_porcentaje_avance_nuevo        IN  TICKETS.TK_TICKETS_HISTORIAL.PORCENTAJE_AVANCE_NUEVO%TYPE,
        p_nombre_ticket_viejo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_VIEJO%TYPE,
        p_nombre_ticket_nuevo            IN  TICKETS.TK_TICKETS_HISTORIAL.NOMBRE_TICKET_NUEVO%TYPE,
        p_descripcion_viejo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_VIEJO%TYPE,
        p_descripcion_nuevo              IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_NUEVO%TYPE,
        p_descripcion_solucion_viejo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_VIEJO%TYPE,
        p_descripcion_solucion_nuevo     IN  TICKETS.TK_TICKETS_HISTORIAL.DESCRIPCION_SOLUCION_NUEVO%TYPE,
        p_fecha_solicitud_viejo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_VIEJO%TYPE,
        p_fecha_solicitud_nuevo          IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_SOLICITUD_NUEVO%TYPE,
        p_fecha_asignacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_VIEJO%TYPE,
        p_fecha_asignacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ASIGNACION_NUEVO%TYPE,
        p_fecha_inicio_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_VIEJO%TYPE,
        p_fecha_inicio_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_INICIO_NUEVO%TYPE,
        p_fecha_resolucion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_VIEJO%TYPE,
        p_fecha_resolucion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_RESOLUCION_NUEVO%TYPE,
        p_fecha_cierre_viejo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_VIEJO%TYPE,
        p_fecha_cierre_nuevo             IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CIERRE_NUEVO%TYPE,
        p_usuario_creacion_viejo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_VIEJO%TYPE,
        p_usuario_creacion_nuevo         IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CREACION_NUEVO%TYPE,
        p_fecha_creacion_viejo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_VIEJO%TYPE,
        p_fecha_creacion_nuevo           IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CREACION_NUEVO%TYPE,
        p_usuario_actualizacion_viejo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_VIEJO%TYPE,
        p_usuario_actualizacion_nuevo    IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_ACTUALIZACION_NUEVO%TYPE,
        p_fecha_actualizacion_viejo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_VIEJO%TYPE,
        p_fecha_actualizacion_nuevo      IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_ACTUALIZACION_NUEVO%TYPE,
        p_usuario_cambio                 IN  TICKETS.TK_TICKETS_HISTORIAL.USUARIO_CAMBIO%TYPE,
        p_fecha_cambio                   IN  TICKETS.TK_TICKETS_HISTORIAL.FECHA_CAMBIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TICKETS_HISTORIAL_ELIMINAR_P(
        p_ID_HISTORIAL_TICKET            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TICKETS_HISTORIAL_CONSULTAR_F(
        p_ID_HISTORIAL_TICKET            IN  TICKETS.TK_TICKETS_HISTORIAL.ID_HISTORIAL_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TICKETS_HISTORIAL_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_TIPOS_ACTIVOS_CRUD_PKG AS

    PROCEDURE TK_TIPOS_ACTIVOS_CREAR_P(
        p_id_tipo_activo                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_nombre_tipo_activo             IN  TICKETS.TK_TIPOS_ACTIVOS.NOMBRE_TIPO_ACTIVO%TYPE,
        p_descripcion_tipo_activo        IN  TICKETS.TK_TIPOS_ACTIVOS.DESCRIPCION_TIPO_ACTIVO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TIPOS_ACTIVOS.ACTIVO%TYPE,
        po_ID_TIPO_ACTIVO_generado     OUT TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TIPOS_ACTIVOS_ACTUALIZAR_P(
        p_id_tipo_activo                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_nombre_tipo_activo             IN  TICKETS.TK_TIPOS_ACTIVOS.NOMBRE_TIPO_ACTIVO%TYPE,
        p_descripcion_tipo_activo        IN  TICKETS.TK_TIPOS_ACTIVOS.DESCRIPCION_TIPO_ACTIVO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_TIPOS_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_TIPOS_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_TIPOS_ACTIVOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_TIPOS_ACTIVOS_ELIMINAR_P(
        p_ID_TIPO_ACTIVO                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_TIPOS_ACTIVOS_CONSULTAR_F(
        p_ID_TIPO_ACTIVO                 IN  TICKETS.TK_TIPOS_ACTIVOS.ID_TIPO_ACTIVO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_TIPOS_ACTIVOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_USUARIOS_CRUD_PKG AS

    PROCEDURE TK_USUARIOS_CREAR_P(
        p_id_usuario                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        p_nombre                         IN  TICKETS.TK_USUARIOS.NOMBRE%TYPE,
        p_apellido                       IN  TICKETS.TK_USUARIOS.APELLIDO%TYPE,
        p_username                       IN  TICKETS.TK_USUARIOS.USERNAME%TYPE,
        p_email                          IN  TICKETS.TK_USUARIOS.EMAIL%TYPE,
        p_telefono                       IN  TICKETS.TK_USUARIOS.TELEFONO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_USUARIOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_USUARIOS.ACTIVO%TYPE,
        po_ID_USUARIO_generado         OUT TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_USUARIOS_ACTUALIZAR_P(
        p_id_usuario                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        p_nombre                         IN  TICKETS.TK_USUARIOS.NOMBRE%TYPE,
        p_apellido                       IN  TICKETS.TK_USUARIOS.APELLIDO%TYPE,
        p_username                       IN  TICKETS.TK_USUARIOS.USERNAME%TYPE,
        p_email                          IN  TICKETS.TK_USUARIOS.EMAIL%TYPE,
        p_telefono                       IN  TICKETS.TK_USUARIOS.TELEFONO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_USUARIOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_USUARIOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_USUARIOS_ELIMINAR_P(
        p_ID_USUARIO                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_USUARIOS_CONSULTAR_F(
        p_ID_USUARIO                     IN  TICKETS.TK_USUARIOS.ID_USUARIO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_USUARIOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_USUARIOS_ROLES_CRUD_PKG AS

    PROCEDURE TK_USUARIOS_ROLES_CREAR_P(
        p_id_usuario_rol                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        p_id_rol                         IN  TICKETS.TK_USUARIOS_ROLES.ID_ROL%TYPE,
        p_id_usuario                     IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_ACTUALIZACION%TYPE,
        po_ID_USUARIO_ROL_generado     OUT TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_USUARIOS_ROLES_ACTUALIZAR_P(
        p_id_usuario_rol                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        p_id_rol                         IN  TICKETS.TK_USUARIOS_ROLES.ID_ROL%TYPE,
        p_id_usuario                     IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_USUARIOS_ROLES.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_USUARIOS_ROLES.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_USUARIOS_ROLES.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_USUARIOS_ROLES_ELIMINAR_P(
        p_ID_USUARIO_ROL                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_USUARIOS_ROLES_CONSULTAR_F(
        p_ID_USUARIO_ROL                 IN  TICKETS.TK_USUARIOS_ROLES.ID_USUARIO_ROL%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_USUARIOS_ROLES_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_ACTIVOS_CRUD_PKG AS

    PROCEDURE TK_ACTIVOS_CREAR_P(
        p_id_activo                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        p_numero_serie                   IN  TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE,
        p_numero_inventario              IN  TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE,
        p_descripcion_activo             IN  TICKETS.TK_ACTIVOS.DESCRIPCION_ACTIVO%TYPE,
        p_marca                          IN  TICKETS.TK_ACTIVOS.MARCA%TYPE,
        p_modelo                         IN  TICKETS.TK_ACTIVOS.MODELO%TYPE,
        p_id_tipo_activo                 IN  TICKETS.TK_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_id_usuario_asignado            IN  TICKETS.TK_ACTIVOS.ID_USUARIO_ASIGNADO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_ACTIVOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ACTIVOS.ACTIVO%TYPE,
        po_ID_ACTIVO_generado          OUT TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_ACTUALIZAR_P(
        p_id_activo                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        p_numero_serie                   IN  TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE,
        p_numero_inventario              IN  TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE,
        p_descripcion_activo             IN  TICKETS.TK_ACTIVOS.DESCRIPCION_ACTIVO%TYPE,
        p_marca                          IN  TICKETS.TK_ACTIVOS.MARCA%TYPE,
        p_modelo                         IN  TICKETS.TK_ACTIVOS.MODELO%TYPE,
        p_id_tipo_activo                 IN  TICKETS.TK_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        p_id_usuario_asignado            IN  TICKETS.TK_ACTIVOS.ID_USUARIO_ASIGNADO%TYPE,
        p_ubicacion                      IN  TICKETS.TK_ACTIVOS.UBICACION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS.USUARIO_ACTUALIZACION%TYPE,
        p_activo                         IN  TICKETS.TK_ACTIVOS.ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_ELIMINAR_P(
        p_ID_ACTIVO                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ACTIVOS_CONSULTAR_F(
        p_ID_ACTIVO                      IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ACTIVOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_ACTIVOS_TICKETS_CRUD_PKG AS

    PROCEDURE TK_ACTIVOS_TICKETS_CREAR_P(
        p_id_activo_ticket               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        p_id_activo                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        po_ID_ACTIVO_TICKET_generado   OUT TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_TICKETS_ACTUALIZAR_P(
        p_id_activo_ticket               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        p_id_activo                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        p_id_ticket                      IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_ACTIVOS_TICKETS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_ACTIVOS_TICKETS.USUARIO_ACTUALIZACION%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_TICKETS_ELIMINAR_P(
        p_ID_ACTIVO_TICKET               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    FUNCTION TK_ACTIVOS_TICKETS_CONSULTAR_F(
        p_ID_ACTIVO_TICKET               IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END TK_ACTIVOS_TICKETS_CRUD_PKG;
/
