CREATE OR REPLACE PACKAGE BODY TK_AREAS_CRUD_PKG AS
--CRUD DE AREAS
    PROCEDURE TK_CREA_AREA_P(  
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        pi_id_area_generado OUT INTEGER) IS
    BEGIN
        --VALIDACIONES
        IF pv_nombre_area IS NULL OR TRIM(pv_nombre_area) = '' THEN
            RAISE_APPLICATION_ERROR(-20001, 'El nombre del área no puede estar vacío.');
        END IF;

        INSERT INTO TK_AREAS (ID_AREA, NOMBRE_AREA, DESCRIPCION)
        VALUES (pi_id_area,UPPER(pv_nombre_area), pv_descripcion)
        RETURNING ID_AREA INTO pi_id_area_generado;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002, 'Error al crear el área: ' || SQLERRM);
    END TK_CREA_AREA_P;

    PROCEDURE TK_ACTUALIZA_AREA_P(   
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2
    ) IS
    BEGIN
        IF pv_nombre_area IS NULL OR TRIM(pv_nombre_area) = '' THEN
            RAISE_APPLICATION_ERROR(-20003, 'El nombre del área no puede estar vacío.');
        END IF;

        UPDATE TK_AREAS
        SET NOMBRE_AREA = UPPER(pv_nombre_area),
            DESCRIPCION = pv_descripcion
        WHERE ID_AREA = pi_id_area;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20004, 'Error al actualizar el área: ' || SQLERRM);
    END TK_ACTUALIZA_AREA_P;

    PROCEDURE TK_ELIMINA_AREA_P(
        pi_id_area IN INTEGER,
        pv_resultado OUT VARCHAR2        
    ) IS
    BEGIN
        IF pi_id_area IS NULL THEN
            RAISE_APPLICATION_ERROR(-20004, 'El ID del área no puede ser nulo.');
        END IF;
        DELETE FROM TK_AREAS WHERE ID_AREA = pi_id_area;
        IF SQL%ROWCOUNT > 0 THEN
            pv_resultado := 'Área eliminada exitosamente.';
        ELSE
            pv_resultado := 'No se encontró el área con el ID proporcionado.';
        END IF;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar el área: ' || SQLERRM);
    END TK_ELIMINA_AREA_P;

    FUNCTION  TK_CONSULTA_AREA_P(
        pi_id_area IN INTEGER
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        OPEN rc FOR 
        SELECT * 
        FROM TK_AREAS 
        WHERE ID_AREA = NVL(pi_id_area, ID_AREA);
        RETURN rc;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'El área no fue encontrada.');
    END TK_CONSULTA_AREA_P;

END TK_AREAS_CRUD_PKG;

