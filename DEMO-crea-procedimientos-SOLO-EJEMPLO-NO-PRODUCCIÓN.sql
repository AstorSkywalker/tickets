CREATE OR REPLACE PROCEDURE TK_CREA_AREAS_P (
    pi_id_area IN INTEGER,
    pv_nombre_area IN VARCHAR2,
    pv_descripcion_area IN VARCHAR2,
    pi_id_area_generado OUT INTEGER) AS 
BEGIN 

    DBMS_OUTPUT.PUT_LINE('Hola, mundo!');    

    -- Validación de parámetros
    IF pv_nombre_area IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'El nombre del área no puede ser nulo.');
    END IF;

    -- Guardar los datos
    INSERT INTO TK_AREAS (ID_AREA, NOMBRE_AREA, DESCRIPCION) 
    VALUES (pi_id_area, UPPER(pv_nombre_area), pv_descripcion_area)
    RETURNING ID_AREA INTO pi_id_area_generado;

    -- Manejo de errores
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX  THEN
            RAISE_APPLICATION_ERROR(-20006, 'El nombre del área ya existe: ' || pv_nombre_area);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error al crear el área: ' || pv_nombre_area || '. Detalles del error: ' || SQLERRM);

END;
/

CREATE OR REPLACE PROCEDURE TK_ACTUALIZA_AREAS_P (
    pi_id_area IN INTEGER,
    pv_nombre_area IN VARCHAR2,
    pv_descripcion_area IN VARCHAR2) AS
BEGIN

    -- Validación de parámetros
    IF pi_id_area IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'El ID del área no puede ser nulo.');
    END IF;

    IF pv_nombre_area IS NULL THEN
        RAISE_APPLICATION_ERROR(-20004, 'El nombre del área no puede ser nulo.');
    END IF;

    -- Actualizar los datos
    UPDATE TK_AREAS
    SET NOMBRE_AREA = UPPER(pv_nombre_area),
        DESCRIPCION = pv_descripcion_area
    WHERE ID_AREA = pi_id_area;

    -- Manejo de errores
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX  THEN
            RAISE_APPLICATION_ERROR(-20006, 'El nombre del área ya existe: ' || pv_nombre_area);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error al actualizar el área: ' || pv_nombre_area || '. Detalles del error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE TK_ELIMINA_AREAS_P (
    pi_id_area IN INTEGER,
    pv_resultado OUT VARCHAR2
)
AS
BEGIN
    
    -- Validación de parámetros
    IF pi_id_area IS NULL THEN
        RAISE_APPLICATION_ERROR(-20007, 'El ID del área no puede ser nulo.');
    END IF;

    -- Eliminar el área
    DELETE FROM TK_AREAS
    WHERE ID_AREA = pi_id_area;

    -- Verificar si se eliminó algún registro
    IF SQL%ROWCOUNT = 0 THEN
        --RAISE_APPLICATION_ERROR(-20009, 'No se encontró el área con ID: ' || pi_id_area);
        pv_resultado := 'No se encontró el área con ID: ' || pi_id_area;
        --return;
    END IF;

    -- Manejo de errores
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20008, 'Error al eliminar el área con ID: ' || pi_id_area || '. Detalles del error: ' || SQLERRM);
END;
/

create or replace function tk_consulta_areas_f (
    pi_id_area IN INTEGER
) RETURN SYS_REFCURSOR AS
  v_cursor     SYS_REFCURSOR;
begin

    open v_cursor for
    select *
    from tk_areas
    where id_area = pi_id_area;

    return v_cursor;

end;

create or replace function suma_dos_numeros (p_num1 in number, p_num2 in number) return number is
begin
    return p_num1 + p_num2;
end suma_dos_numeros;
/
