CREATE OR REPLACE PACKAGE TK_AREAS_CRUD_PKG AS
    PROCEDURE TK_CREA_AREA_P(  
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        pi_id_area_generado OUT INTEGER);
    PROCEDURE TK_ACTUALIZA_AREA_P(   
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2
    );
    PROCEDURE TK_ELIMINA_AREA_P(
        pi_id_area IN INTEGER,
        pv_resultado OUT VARCHAR2        
    );
    FUNCTION  TK_CONSULTA_AREA_P(
        pi_id_area IN INTEGER
    ) RETURN SYS_REFCURSOR;
END TK_AREAS_CRUD_PKG;