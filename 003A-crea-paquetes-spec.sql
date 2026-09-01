CREATE OR REPLACE PACKAGE TICKETS.TK_AREAS_CRUD_PKG AS

    PROCEDURE TK_AREAS_CREAR_P(
        pi_id_area          IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_nombre_area      IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        pv_descripcion      IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        pi_id_area_generado OUT TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado        OUT VARCHAR2
    );

    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        pi_id_area      IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_nombre_area  IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        pv_descripcion  IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        pv_resultado    OUT VARCHAR2
    );

    PROCEDURE TK_AREAS_ELIMINAR_P(
        pi_id_area    IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado  OUT VARCHAR2
    );

    FUNCTION TK_AREAS_CONSULTAR_F(
        pi_id_area IN TICKETS.TK_AREAS.ID_AREA%TYPE
    ) RETURN SYS_REFCURSOR;

END TK_AREAS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_ACTIVOS_CRUD_PKG AS

    PROCEDURE TK_ACTIVOS_CREAR_P(
        pi_id_activo              IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_numero_serie           IN  TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE,
        pv_numero_inventario      IN  TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE,
        pv_descripcion_activo     IN  TICKETS.TK_ACTIVOS.DESCRIPCION_ACTIVO%TYPE,
        pv_marca                  IN  TICKETS.TK_ACTIVOS.MARCA%TYPE,
        pv_modelo                 IN  TICKETS.TK_ACTIVOS.MODELO%TYPE,
        pi_id_tipo_activo         IN  TICKETS.TK_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        pi_id_usuario_asignado    IN  TICKETS.TK_ACTIVOS.ID_USUARIO_ASIGNADO%TYPE,
        pv_ubicacion              IN  TICKETS.TK_ACTIVOS.UBICACION%TYPE,
        pi_id_activo_generado     OUT TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado              OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_ACTUALIZAR_P(
        pi_id_activo              IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_numero_serie           IN  TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE,
        pv_numero_inventario      IN  TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE,
        pv_descripcion_activo     IN  TICKETS.TK_ACTIVOS.DESCRIPCION_ACTIVO%TYPE,
        pv_marca                  IN  TICKETS.TK_ACTIVOS.MARCA%TYPE,
        pv_modelo                 IN  TICKETS.TK_ACTIVOS.MODELO%TYPE,
        pi_id_tipo_activo         IN  TICKETS.TK_ACTIVOS.ID_TIPO_ACTIVO%TYPE,
        pi_id_usuario_asignado    IN  TICKETS.TK_ACTIVOS.ID_USUARIO_ASIGNADO%TYPE,
        pv_ubicacion              IN  TICKETS.TK_ACTIVOS.UBICACION%TYPE,
        pv_resultado              OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_ELIMINAR_P(
        pi_id_activo  IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado  OUT VARCHAR2
    );

    FUNCTION TK_ACTIVOS_CONSULTAR_F(
        pi_id_activo IN TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE
    ) RETURN SYS_REFCURSOR;

END TK_ACTIVOS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE TICKETS.TK_ACTIVOS_TICKETS_CRUD_PKG AS

    PROCEDURE TK_ACTIVOS_TICKETS_CREAR_P(
        pi_id_activo_ticket          IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pi_id_activo                 IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        pi_id_ticket                 IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        pi_id_activo_ticket_generado OUT TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pv_resultado                 OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_TICKETS_ACTUALIZAR_P(
        pi_id_activo_ticket  IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pi_id_activo         IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO%TYPE,
        pi_id_ticket         IN  TICKETS.TK_ACTIVOS_TICKETS.ID_TICKET%TYPE,
        pv_resultado         OUT VARCHAR2
    );

    PROCEDURE TK_ACTIVOS_TICKETS_ELIMINAR_P(
        pi_id_activo_ticket IN  TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE,
        pv_resultado        OUT VARCHAR2
    );

    FUNCTION TK_ACTIVOS_TICKETS_CONSULTAR_F(
        pi_id_activo_ticket IN TICKETS.TK_ACTIVOS_TICKETS.ID_ACTIVO_TICKET%TYPE
    ) RETURN SYS_REFCURSOR;

END TK_ACTIVOS_TICKETS_CRUD_PKG;
/
