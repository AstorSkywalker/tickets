CREATE OR REPLACE PACKAGE TK_AREAS_CRUD_PKG AS

   PROCEDURE TK_AREAS_CREAR_P(
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        pi_id_area_generado OUT INTEGER,
        PV_RESULTADO OUT VARCHAR2);

    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        PV_RESULTADO OUT VARCHAR2);

    PROCEDURE TK_AREAS_ELIMINAR_P(
        pi_id_area IN INTEGER,
        PV_RESULTADO OUT VARCHAR2);

    -- Consultar un solo registro o todos
    FUNCTION TK_AREAS_CONSULTAR_F(
        pi_id_area IN INTEGER) RETURN SYS_REFCURSOR;

END TK_AREAS_CRUD_PKG;
/
