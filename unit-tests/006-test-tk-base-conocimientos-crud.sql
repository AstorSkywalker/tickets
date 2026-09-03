-- Pruebas unitarias para TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

DECLARE
    v_id_base               TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE;
    v_id_generado           TICKETS.TK_BASE_CONOCIMIENTOS.ID_BASE_CONOCIMIENTO%TYPE;
    v_titulo                TICKETS.TK_BASE_CONOCIMIENTOS.TITULO%TYPE;
    v_descripcion           TICKETS.TK_BASE_CONOCIMIENTOS.DESCRIPCION%TYPE;
    v_palabras_clave        TICKETS.TK_BASE_CONOCIMIENTOS.PALABRAS_CLAVE%TYPE;
    v_publicado             TICKETS.TK_BASE_CONOCIMIENTOS.PUBLICADO%TYPE;
    v_id_usuario_autor      TICKETS.TK_BASE_CONOCIMIENTOS.ID_USUARIO_AUTOR%TYPE;
    v_fecha_creacion        TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_CREACION%TYPE;
    v_usuario_creacion      TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_CREACION%TYPE;
    v_fecha_actualizacion   TICKETS.TK_BASE_CONOCIMIENTOS.FECHA_ACTUALIZACION%TYPE;
    v_usuario_actualizacion TICKETS.TK_BASE_CONOCIMIENTOS.USUARIO_ACTUALIZACION%TYPE;
    v_resultado             VARCHAR2(4000);
    v_cursor                SYS_REFCURSOR;
    v_titulo_prueba         VARCHAR2(300) :=
        'TEST ARTICULO ' || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3');

    PROCEDURE afirmar(p_condicion IN BOOLEAN, p_mensaje IN VARCHAR2) IS
    BEGIN
        IF NOT p_condicion THEN
            RAISE_APPLICATION_ERROR(-20999, 'FALLO: ' || p_mensaje);
        END IF;
        DBMS_OUTPUT.PUT_LINE('OK: ' || p_mensaje);
    END afirmar;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO PRUEBAS TK_BASE_CONOCIMIENTOS_CRUD_PKG ===');

    -- Crear y validar el ID generado por la columna identity.
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_CREAR_P(
        p_id_base_conocimiento           => NULL,
        p_titulo                         => v_titulo_prueba,
        p_descripcion                    => 'Articulo creado por prueba unitaria.',
        p_palabras_clave                 => 'prueba,sqlcl,oracle',
        p_publicado                      => 'N',
        p_id_usuario_autor               => NULL,
        p_fecha_creacion                 => NULL,
        p_usuario_creacion               => NULL,
        p_fecha_actualizacion            => NULL,
        p_usuario_actualizacion          => NULL,
        po_ID_BASE_CONOCIMIENTO_generado => v_id_generado,
        pv_resultado                     => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO CREADO', 'crear articulo valido');
    afirmar(v_id_generado IS NOT NULL AND v_id_generado > 0,
            'generar ID_BASE_CONOCIMIENTO');
    v_id_base := v_id_generado;

    -- Consultar mediante SYS_REFCURSOR.
    v_cursor := TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_CONSULTAR_F(v_id_base);
    FETCH v_cursor INTO v_id_generado, v_titulo, v_descripcion,
                        v_palabras_clave, v_publicado, v_id_usuario_autor,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion;
    CLOSE v_cursor;
    afirmar(v_id_generado = v_id_base, 'consultar articulo por ID');
    afirmar(v_titulo = v_titulo_prueba, 'devolver titulo correcto');
    afirmar(DBMS_LOB.SUBSTR(v_descripcion, 4000, 1) =
            'Articulo creado por prueba unitaria.',
            'devolver descripcion correcta');
    afirmar(v_publicado = 'N', 'devolver estado no publicado');

    -- Actualizar todos los campos expuestos por el spec.
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P(
        p_id_base_conocimiento           => v_id_base,
        p_titulo                         => v_titulo_prueba || ' ACTUALIZADO',
        p_descripcion                    => 'Descripcion actualizada por prueba unitaria.',
        p_palabras_clave                 => 'actualizado,prueba',
        p_publicado                      => 'S',
        p_id_usuario_autor               => NULL,
        p_fecha_creacion                 => v_fecha_creacion,
        p_usuario_creacion               => v_usuario_creacion,
        p_fecha_actualizacion            => NULL,
        p_usuario_actualizacion          => NULL,
        pv_resultado                     => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ACTUALIZADO', 'actualizar articulo valido');

    -- Validar titulo obligatorio.
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_CREAR_P(
        p_id_base_conocimiento           => NULL,
        p_titulo                         => NULL,
        p_descripcion                    => 'No debe insertarse.',
        p_palabras_clave                 => NULL,
        p_publicado                      => 'N',
        p_id_usuario_autor               => NULL,
        p_fecha_creacion                 => NULL,
        p_usuario_creacion               => NULL,
        p_fecha_actualizacion            => NULL,
        p_usuario_actualizacion          => NULL,
        po_ID_BASE_CONOCIMIENTO_generado => v_id_generado,
        pv_resultado                     => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar titulo nulo');

    -- Validar descripcion obligatoria.
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_CREAR_P(
        p_id_base_conocimiento           => NULL,
        p_titulo                         => v_titulo_prueba || ' INVALIDO',
        p_descripcion                    => NULL,
        p_palabras_clave                 => NULL,
        p_publicado                      => 'N',
        p_id_usuario_autor               => NULL,
        p_fecha_creacion                 => NULL,
        p_usuario_creacion               => NULL,
        p_fecha_actualizacion            => NULL,
        p_usuario_actualizacion          => NULL,
        po_ID_BASE_CONOCIMIENTO_generado => v_id_generado,
        pv_resultado                     => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%' AND v_id_generado IS NULL,
            'rechazar descripcion nula');

    -- Validar dominio de PUBLICADO.
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_ACTUALIZAR_P(
        p_id_base_conocimiento           => v_id_base,
        p_titulo                         => v_titulo_prueba || ' ACTUALIZADO',
        p_descripcion                    => 'No debe actualizarse.',
        p_palabras_clave                 => NULL,
        p_publicado                      => 'X',
        p_id_usuario_autor               => NULL,
        p_fecha_creacion                 => v_fecha_creacion,
        p_usuario_creacion               => v_usuario_creacion,
        p_fecha_actualizacion            => NULL,
        p_usuario_actualizacion          => NULL,
        pv_resultado                     => v_resultado
    );
    afirmar(v_resultado LIKE 'ERROR:%', 'rechazar PUBLICADO fuera de S/N');

    -- Eliminar y validar que el registro ya no exista.
    TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_ELIMINAR_P(
        p_ID_BASE_CONOCIMIENTO => v_id_base,
        pv_resultado           => v_resultado
    );
    afirmar(v_resultado = 'OK: REGISTRO ELIMINADO', 'eliminar articulo');

    v_cursor := TICKETS.TK_BASE_CONOCIMIENTOS_CRUD_PKG.TK_BASE_CONOCIMIENTOS_CONSULTAR_F(v_id_base);
    FETCH v_cursor INTO v_id_generado, v_titulo, v_descripcion,
                        v_palabras_clave, v_publicado, v_id_usuario_autor,
                        v_fecha_creacion, v_usuario_creacion,
                        v_fecha_actualizacion, v_usuario_actualizacion;
    afirmar(v_cursor%NOTFOUND, 'no devolver articulo eliminado');
    CLOSE v_cursor;

    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_BASE_CONOCIMIENTOS PASARON ===');
EXCEPTION
    WHEN OTHERS THEN
        IF v_cursor%ISOPEN THEN
            CLOSE v_cursor;
        END IF;
        DBMS_OUTPUT.PUT_LINE('=== PRUEBA TK_BASE_CONOCIMIENTOS FALLO ===');
        RAISE;
END;
/
