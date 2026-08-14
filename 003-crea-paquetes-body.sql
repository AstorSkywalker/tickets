CREATE OR REPLACE PACKAGE BODY TK_AREAS_CRUD_PKG AS

   PROCEDURE TK_AREAS_CREAR_P(
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        pi_id_area_generado OUT INTEGER,
        PV_RESULTADO OUT VARCHAR2) AS
        BEGIN
            if (pv_nombre_area is null ) then 
            PV_RESULTADO:='Nombre no puede ser vacio';
            return;
            end if; 

        insert into TK_AREAS(ID_AREA,NOMBRE_AREA,DESCRIPCION) 
         values (pi_id_area, upper (pv_nombre_area), pv_descripcion) 
         returning id_area into pi_id_area_generado ;

          PV_RESULTADO:= 'OK';

          exception 
          when dup_val_index  then
            PV_RESULTADO:= 'ERROR NOMBRE DE AREA DUPLICADO ' || sqlerrm  ;
           when others then 
           PV_RESULTADO:= 'ERROR ' || sqlerrm  ;


        END;


    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        PV_RESULTADO OUT VARCHAR2) AS
    BEGIN
    NULL;
    END;

    PROCEDURE TK_AREAS_ELIMINAR_P(
        pi_id_area IN INTEGER,
        PV_RESULTADO OUT VARCHAR2) AS
    BEGIN
        null;
    END;

    -- Consultar un solo registro o todos
    FUNCTION TK_AREAS_CONSULTAR_F(
        pi_id_area IN INTEGER) RETURN SYS_REFCURSOR AS
    BEGIN
    NULL;
    END;

END TK_AREAS_CRUD_PKG;
/
