SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT

CREATE OR REPLACE PACKAGE BODY TICKETS.TK_AREAS_CRUD_PKG AS

    c_modulo CONSTANT VARCHAR2(100) := 'TK_AREAS_CRUD_PKG';

    PROCEDURE TK_AREAS_CREAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        p_nombre_area                    IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        p_descripcion                    IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_AREAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_AREAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_AREAS.ACTIVA%TYPE,
        po_ID_AREA_generado              OUT TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado                     OUT VARCHAR2
    ) AS
        v_nombre_area       TICKETS.TK_AREAS.NOMBRE_AREA%TYPE;
        v_usuario_creacion   TICKETS.TK_AREAS.USUARIO_CREACION%TYPE;
        v_activa             TICKETS.TK_AREAS.ACTIVA%TYPE;
        v_existentes         PLS_INTEGER;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_CREAR_P'
        );

        po_ID_AREA_generado := NULL;
        pv_resultado := NULL;
        v_nombre_area := UPPER(TRIM(p_nombre_area));
        v_usuario_creacion := COALESCE(
            TRIM(p_usuario_creacion),
            SYS_CONTEXT('APEX$SESSION', 'APP_USER'),
            SYS_CONTEXT('USERENV', 'SESSION_USER')
        );
        v_activa := COALESCE(UPPER(TRIM(p_activa)), 'S');

        IF p_id_area IS NOT NULL AND p_id_area < 1 THEN
            pv_resultado := 'ERROR: EL ID DEL ÁREA DEBE SER MAYOR QUE CERO';
            RETURN;
        END IF;

        IF v_nombre_area IS NULL THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA ES OBLIGATORIO';
            RETURN;
        END IF;

        IF v_usuario_creacion IS NULL THEN
            pv_resultado := 'ERROR: EL USUARIO DE CREACIÓN ES OBLIGATORIO';
            RETURN;
        END IF;

        IF v_activa NOT IN ('S', 'N') THEN
            pv_resultado := 'ERROR: ACTIVA SOLO PUEDE SER S O N';
            RETURN;
        END IF;

        SELECT COUNT(*)
          INTO v_existentes
          FROM TICKETS.TK_AREAS
         WHERE NOMBRE_AREA = v_nombre_area;

        IF v_existentes > 0 THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA YA EXISTE';
            RETURN;
        END IF;

        INSERT INTO TICKETS.TK_AREAS (
            ID_AREA,
            NOMBRE_AREA,
            DESCRIPCION,
            FECHA_CREACION,
            USUARIO_CREACION,
            FECHA_ACTUALIZACION,
            USUARIO_ACTUALIZACION,
            ACTIVA
        )
        VALUES (
            p_id_area,
            v_nombre_area,
            p_descripcion,
            COALESCE(p_fecha_creacion, SYSTIMESTAMP),
            v_usuario_creacion,
            p_fecha_actualizacion,
            p_usuario_actualizacion,
            v_activa
        )
        RETURNING ID_AREA INTO po_ID_AREA_generado;

        pv_resultado := 'OK: ÁREA CREADA';

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            po_ID_AREA_generado := NULL;
            pv_resultado := 'ERROR: EL ID O NOMBRE DEL ÁREA YA EXISTE';
        WHEN OTHERS THEN
            po_ID_AREA_generado := NULL;
            pv_resultado := 'ERROR: ' || c_modulo || '.TK_AREAS_CREAR_P: ' || SQLERRM;
    END TK_AREAS_CREAR_P;


    PROCEDURE TK_AREAS_ACTUALIZAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        p_nombre_area                    IN  TICKETS.TK_AREAS.NOMBRE_AREA%TYPE,
        p_descripcion                    IN  TICKETS.TK_AREAS.DESCRIPCION%TYPE,
        p_fecha_creacion                 IN  TICKETS.TK_AREAS.FECHA_CREACION%TYPE,
        p_usuario_creacion               IN  TICKETS.TK_AREAS.USUARIO_CREACION%TYPE,
        p_fecha_actualizacion            IN  TICKETS.TK_AREAS.FECHA_ACTUALIZACION%TYPE,
        p_usuario_actualizacion          IN  TICKETS.TK_AREAS.USUARIO_ACTUALIZACION%TYPE,
        p_activa                         IN  TICKETS.TK_AREAS.ACTIVA%TYPE,
        pv_resultado                     OUT VARCHAR2
    ) AS
        v_nombre_area       TICKETS.TK_AREAS.NOMBRE_AREA%TYPE;
        v_activa             TICKETS.TK_AREAS.ACTIVA%TYPE;
        v_existentes         PLS_INTEGER;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_ACTUALIZAR_P'
        );

        pv_resultado := NULL;
        v_nombre_area := UPPER(TRIM(p_nombre_area));
        v_activa := COALESCE(UPPER(TRIM(p_activa)), 'S');

        IF p_id_area IS NULL OR p_id_area < 1 THEN
            pv_resultado := 'ERROR: EL ID DEL ÁREA ES OBLIGATORIO Y DEBE SER MAYOR QUE CERO';
            RETURN;
        END IF;

        IF v_nombre_area IS NULL THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA ES OBLIGATORIO';
            RETURN;
        END IF;

        IF v_activa NOT IN ('S', 'N') THEN
            pv_resultado := 'ERROR: ACTIVA SOLO PUEDE SER S O N';
            RETURN;
        END IF;

        SELECT COUNT(*)
          INTO v_existentes
          FROM TICKETS.TK_AREAS
         WHERE ID_AREA = p_id_area;

        IF v_existentes = 0 THEN
            pv_resultado := 'ERROR: EL ÁREA NO EXISTE';
            RETURN;
        END IF;

        SELECT COUNT(*)
          INTO v_existentes
          FROM TICKETS.TK_AREAS
         WHERE NOMBRE_AREA = v_nombre_area
           AND ID_AREA <> p_id_area;

        IF v_existentes > 0 THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA YA EXISTE';
            RETURN;
        END IF;

        UPDATE TICKETS.TK_AREAS
           SET NOMBRE_AREA           = v_nombre_area,
               DESCRIPCION           = p_descripcion,
               FECHA_CREACION        = COALESCE(p_fecha_creacion, FECHA_CREACION),
               USUARIO_CREACION      = COALESCE(p_usuario_creacion, USUARIO_CREACION),
               FECHA_ACTUALIZACION   = COALESCE(p_fecha_actualizacion, FECHA_ACTUALIZACION),
               USUARIO_ACTUALIZACION = COALESCE(p_usuario_actualizacion, USUARIO_ACTUALIZACION),
               ACTIVA                = v_activa
         WHERE ID_AREA = p_id_area;

        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: EL ÁREA NO EXISTE';
            RETURN;
        END IF;

        pv_resultado := 'OK: ÁREA ACTUALIZADA';

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            pv_resultado := 'ERROR: EL NOMBRE DEL ÁREA YA EXISTE';
        WHEN OTHERS THEN
            pv_resultado := 'ERROR: ' || c_modulo || '.TK_AREAS_ACTUALIZAR_P: ' || SQLERRM;
    END TK_AREAS_ACTUALIZAR_P;


    PROCEDURE TK_AREAS_ELIMINAR_P(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE,
        pv_resultado                     OUT VARCHAR2
    ) AS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_ELIMINAR_P'
        );

        pv_resultado := NULL;

        IF p_id_area IS NULL OR p_id_area < 1 THEN
            pv_resultado := 'ERROR: EL ID DEL ÁREA ES OBLIGATORIO Y DEBE SER MAYOR QUE CERO';
            RETURN;
        END IF;

        DELETE FROM TICKETS.TK_AREAS
         WHERE ID_AREA = p_id_area;

        IF SQL%ROWCOUNT = 0 THEN
            pv_resultado := 'ERROR: EL ÁREA NO EXISTE';
            RETURN;
        END IF;

        pv_resultado := 'OK: ÁREA ELIMINADA';

    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                pv_resultado := 'ERROR: EL ÁREA NO SE PUEDE ELIMINAR PORQUE TIENE REGISTROS RELACIONADOS';
            ELSE
                pv_resultado := 'ERROR: ' || c_modulo || '.TK_AREAS_ELIMINAR_P: ' || SQLERRM;
            END IF;
    END TK_AREAS_ELIMINAR_P;


    FUNCTION TK_AREAS_CONSULTAR_F(
        p_id_area                        IN  TICKETS.TK_AREAS.ID_AREA%TYPE DEFAULT NULL
    ) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE(
            module_name => c_modulo,
            action_name => 'TK_AREAS_CONSULTAR_F'
        );

        IF p_id_area IS NOT NULL AND p_id_area < 1 THEN
            RAISE_APPLICATION_ERROR(-20001, c_modulo || '.TK_AREAS_CONSULTAR_F: el ID debe ser mayor que cero');
        END IF;

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
             WHERE p_id_area IS NULL
                OR ID_AREA = p_id_area
             ORDER BY ID_AREA;

        RETURN v_cursor;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                c_modulo || '.TK_AREAS_CONSULTAR_F: ' || SQLERRM
            );
    END TK_AREAS_CONSULTAR_F;

END TK_AREAS_CRUD_PKG;
/
