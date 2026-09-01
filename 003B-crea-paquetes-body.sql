CREATE OR REPLACE PACKAGE BODY TICKETS.TK_AREAS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_AREAS_CRUD_PKG';


    PROCEDURE TK_AREAS_CREAR_P(
        pi_id_area          IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_nombre_area      IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        pv_descripcion      IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        pi_id_area_generado OUT TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado        OUT VARCHAR2
    ) AS
        v_nombre_area TICKETS.TK_AREAS.NOMBRE_AREA%TYPE;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_CREAR_P'
        );

        pi_id_area_generado := NULL;
        v_nombre_area := UPPER(TRIM(pv_nombre_area));

        IF v_nombre_area IS NULL THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA NO PUEDE SER VACÍO';
            RETURN;
        END IF;

        INSERT INTO TICKETS.TK_AREAS (
            ID_AREA,
            NOMBRE_AREA,
            DESCRIPCION
        )
        VALUES (
            pi_id_area,
            v_nombre_area,
            pv_descripcion
        )
        RETURNING ID_AREA INTO pi_id_area_generado;

        pv_resultado := 'OK';

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pi_id_area_generado := NULL;
            pv_resultado :=
                'ERROR: EL NOMBRE DEL ÁREA YA EXISTE. ' || SQLERRM;

        WHEN OTHERS THEN
            pi_id_area_generado := NULL;
            pv_resultado := 'ERROR: ' || SQLERRM;
    END TK_AREAS_CREAR_P;


    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        pi_id_area      IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_nombre_area  IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        pv_descripcion  IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        pv_resultado    OUT VARCHAR2
    ) AS
        v_nombre_area TICKETS.TK_AREAS.NOMBRE_AREA%TYPE;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_ACTUALIZAR_P'
        );

        v_nombre_area := UPPER(TRIM(pv_nombre_area));

        IF pi_id_area IS NULL THEN
            pv_resultado := 'ERROR: EL ID DEL ÁREA ES OBLIGATORIO';
            RETURN;
        END IF;

        IF v_nombre_area IS NULL THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA NO PUEDE SER VACÍO';
            RETURN;
        END IF;

        UPDATE TICKETS.TK_AREAS
           SET NOMBRE_AREA           = v_nombre_area,
               DESCRIPCION           = pv_descripcion,
               FECHA_ACTUALIZACION   = SYSTIMESTAMP,
               USUARIO_ACTUALIZACION = USER
         WHERE ID_AREA = pi_id_area;

        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: EL ÁREA NO EXISTE';
            RETURN;
        END IF;

        pv_resultado := 'OK';

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado :=
                'ERROR: EL NOMBRE DEL ÁREA YA EXISTE. ' || SQLERRM;

        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || SQLERRM;
    END TK_AREAS_ACTUALIZAR_P;


    PROCEDURE TK_AREAS_ELIMINAR_P(
        pi_id_area    IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado  OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_ELIMINAR_P'
        );

        IF pi_id_area IS NULL THEN
            pv_resultado := 'ERROR: EL ID DEL ÁREA ES OBLIGATORIO';
            RETURN;
        END IF;

        DELETE FROM TICKETS.TK_AREAS
         WHERE ID_AREA = pi_id_area;

        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: EL ÁREA NO EXISTE';
            RETURN;
        END IF;

        pv_resultado := 'OK';

    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || SQLERRM;
    END TK_AREAS_ELIMINAR_P;


    FUNCTION TK_AREAS_CONSULTAR_F(
        pi_id_area IN TICKETS.TK_AREAS.ID_AREA%TYPE
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_CONSULTAR_F'
        );

        OPEN v_cursor FOR
            SELECT ID_AREA,
                   NOMBRE_AREA,
                   DESCRIPCION,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVA
              FROM TICKETS.TK_AREAS
             WHERE pi_id_area IS NULL
                OR ID_AREA = pi_id_area
             ORDER BY ID_AREA;

        RETURN v_cursor;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                c_modulo || '.TK_AREAS_CONSULTAR_F: ' || SQLERRM
            );
    END TK_AREAS_CONSULTAR_F;

END TK_AREAS_CRUD_PKG;
/

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_ACTIVOS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_ACTIVOS_CRUD_PKG';


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
    ) AS
        v_numero_serie      TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE;
        v_numero_inventario TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_ACTIVOS_CREAR_P'
        );

        pi_id_activo_generado := NULL;

        v_numero_serie :=
            UPPER(TRIM(pv_numero_serie));

        v_numero_inventario :=
            UPPER(TRIM(pv_numero_inventario));

        IF v_numero_serie IS NULL THEN
            pv_resultado :=
                'ERROR: EL NÚMERO DE SERIE NO PUEDE SER VACÍO';
            RETURN;
        END IF;

        IF pi_id_tipo_activo IS NULL THEN
            pv_resultado :=
                'ERROR: EL TIPO DE ACTIVO ES OBLIGATORIO';
            RETURN;
        END IF;

        INSERT INTO TICKETS.TK_ACTIVOS (
            ID_ACTIVO,
            NUMERO_SERIE,
            NUMERO_INVENTARIO,
            DESCRIPCION_ACTIVO,
            MARCA,
            MODELO,
            ID_TIPO_ACTIVO,
            ID_USUARIO_ASIGNADO,
            UBICACION
        )
        VALUES (
            pi_id_activo,
            v_numero_serie,
            v_numero_inventario,
            pv_descripcion_activo,
            pv_marca,
            pv_modelo,
            pi_id_tipo_activo,
            pi_id_usuario_asignado,
            pv_ubicacion
        )
        RETURNING ID_ACTIVO INTO pi_id_activo_generado;

        pv_resultado := 'OK';

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pi_id_activo_generado := NULL;
            pv_resultado :=
                'ERROR: EL NÚMERO DE SERIE O INVENTARIO YA EXISTE. ' || SQLERRM;

        WHEN OTHERS THEN
            pi_id_activo_generado := NULL;
            pv_resultado := 'ERROR: ' || SQLERRM;
    END TK_ACTIVOS_CREAR_P;


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
    ) AS
        v_numero_serie      TICKETS.TK_ACTIVOS.NUMERO_SERIE%TYPE;
        v_numero_inventario TICKETS.TK_ACTIVOS.NUMERO_INVENTARIO%TYPE;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_ACTIVOS_ACTUALIZAR_P'
        );

        v_numero_serie :=
            UPPER(TRIM(pv_numero_serie));

        v_numero_inventario :=
            UPPER(TRIM(pv_numero_inventario));

        IF pi_id_activo IS NULL THEN
            pv_resultado :=
                'ERROR: EL ID DEL ACTIVO ES OBLIGATORIO';
            RETURN;
        END IF;

        IF v_numero_serie IS NULL THEN
            pv_resultado :=
                'ERROR: EL NÚMERO DE SERIE NO PUEDE SER VACÍO';
            RETURN;
        END IF;

        IF pi_id_tipo_activo IS NULL THEN
            pv_resultado :=
                'ERROR: EL TIPO DE ACTIVO ES OBLIGATORIO';
            RETURN;
        END IF;

        UPDATE TICKETS.TK_ACTIVOS
           SET NUMERO_SERIE        = v_numero_serie,
               NUMERO_INVENTARIO   = v_numero_inventario,
               DESCRIPCION_ACTIVO  = pv_descripcion_activo,
               MARCA               = pv_marca,
               MODELO              = pv_modelo,
               ID_TIPO_ACTIVO      = pi_id_tipo_activo,
               ID_USUARIO_ASIGNADO = pi_id_usuario_asignado,
               UBICACION           = pv_ubicacion
         WHERE ID_ACTIVO = pi_id_activo;

        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado :=
                'ERROR: EL ACTIVO NO EXISTE';
            RETURN;
        END IF;

        pv_resultado := 'OK';

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado :=
                'ERROR: EL NÚMERO DE SERIE O INVENTARIO YA EXISTE. ' || SQLERRM;

        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || SQLERRM;
    END TK_ACTIVOS_ACTUALIZAR_P;


    PROCEDURE TK_ACTIVOS_ELIMINAR_P(
        pi_id_activo  IN  TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE,
        pv_resultado  OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_ACTIVOS_ELIMINAR_P'
        );

        IF pi_id_activo IS NULL THEN
            pv_resultado :=
                'ERROR: EL ID DEL ACTIVO ES OBLIGATORIO';
            RETURN;
        END IF;

        DELETE FROM TICKETS.TK_ACTIVOS
         WHERE ID_ACTIVO = pi_id_activo;

        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado :=
                'ERROR: EL ACTIVO NO EXISTE';
            RETURN;
        END IF;

        pv_resultado := 'OK';

    EXCEPTION
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || SQLERRM;
    END TK_ACTIVOS_ELIMINAR_P;


    FUNCTION TK_ACTIVOS_CONSULTAR_F(
        pi_id_activo IN TICKETS.TK_ACTIVOS.ID_ACTIVO%TYPE
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_ACTIVOS_CONSULTAR_F'
        );

        OPEN v_cursor FOR
            SELECT ID_ACTIVO,
                   NUMERO_SERIE,
                   NUMERO_INVENTARIO,
                   DESCRIPCION_ACTIVO,
                   MARCA,
                   MODELO,
                   ID_TIPO_ACTIVO,
                   ID_USUARIO_ASIGNADO,
                   UBICACION,
                   FECHA_CREACION,
                   USUARIO_CREACION,
                   FECHA_ACTUALIZACION,
                   USUARIO_ACTUALIZACION,
                   ACTIVO
              FROM TICKETS.TK_ACTIVOS
             WHERE pi_id_activo IS NULL
                OR ID_ACTIVO = pi_id_activo
             ORDER BY ID_ACTIVO;

        RETURN v_cursor;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                c_modulo || '.TK_ACTIVOS_CONSULTAR_F: ' || SQLERRM
            );
    END TK_ACTIVOS_CONSULTAR_F;

END TK_ACTIVOS_CRUD_PKG;
/
