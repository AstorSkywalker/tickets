
-- =====================================================================
-- PACKAGE: TK_AREAS_CRUD_PKG
-- =====================================================================
-- Objetivo:
--     Proporcionar la capa de acceso para las operaciones de mantenimiento del
--     catálogo de áreas del sistema de Help Desk. Este paquete centraliza la
--     lógica de creación, actualización, eliminación y consulta de registros en
--     la tabla TK_AREAS.
--
-- Requisitos previos:
--     - Existencia de la tabla TK_AREAS en el esquema actual.
--     - Definición de columnas: ID_AREA, NOMBRE_AREA, DESCRIPCION.
--     - Usuario con permisos de EXECUTE sobre el paquete y acceso a la tabla.
--     - Base de datos Oracle 19c o superior.
--     - Convención de negocio: el nombre del área se almacena en mayúsculas.
--
-- Versión:
--     1.0.0
--
-- Historial:
--     v1.0.0 - 2026-08-07 - Creación inicial del paquete CRUD para áreas.
--
-- Autor:
--     Equipo de desarrollo / Ticketing Knowledge
--
-- Responsabilidad funcional:
--     - Crear nuevas áreas con validación de datos.
--     - Actualizar información del área existente.
--     - Eliminar áreas con respuesta textual de resultado.
--     - Consultar una o varias áreas según el identificador recibido.
--
-- Parámetros y salidas:
--     - pi_id_area: identificador del área a consultar, actualizar o eliminar.
--     - pv_nombre_area: nombre del área en texto libre.
--     - pv_descripcion: descripción del área.
--     - pi_id_area_generado: ID generado en la inserción.
--     - pv_resultado: mensaje de resultado de la operación de eliminación.
--     - SYS_REFCURSOR: cursor con el conjunto de registros resultantes.
--
-- Manejo de errores:
--     - Se utilizan códigos de excepción con rango -20001 a -20006.
--     - Las validaciones evitan valores nulos o vacíos.
--     - Cualquier error inesperado se encapsula con mensajes claros para auditoría
--       y depuración.
--
-- Notas de uso:
--     - La operación de alta valida que el campo de nombre no sea nulo ni vacío.
--     - Se recomienda invocar este paquete desde capas de negocio o procedimientos
--       de servicio, no directamente desde triggers.
--     - El resultado de la consulta se devuelve como cursor refcursor para que la
--       aplicación cliente procese el conjunto de filas.
-- =====================================================================

CREATE OR REPLACE PACKAGE TK_AREAS_CRUD_PKG AS

    /*
    ----------------------------------------------------------------------
    PROCEDIMIENTO: TK_CREA_AREA_P
    ----------------------------------------------------------------------
    Descripción:
        Inserta una nueva área en la tabla TK_AREAS y devuelve el ID generado.

    Requiere:
        - pi_id_area: identificador de la nueva área.
        - pv_nombre_area: nombre obligatorio del área.
        - pv_descripcion: descripción opcional del área.

    Salida:
        - pi_id_area_generado: identificador asignado al registro insertado.

    Excepciones:
        - ORA-20001: nombre vacío o nulo.
        - ORA-20002: error general durante la inserción.
    ----------------------------------------------------------------------
    */
    PROCEDURE TK_CREA_AREA_P(
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2,
        pi_id_area_generado OUT INTEGER);

    /*
    ----------------------------------------------------------------------
    PROCEDIMIENTO: TK_ACTUALIZA_AREA_P
    ----------------------------------------------------------------------
    Descripción:
        Actualiza los datos de un área existente en la tabla TK_AREAS.

    Requiere:
        - pi_id_area: identificador de la fila a actualizar.
        - pv_nombre_area: nuevo nombre del área.
        - pv_descripcion: nueva descripción del área.

    Salida:
        - Ninguna salida explícita; la operación confirma la actualización por
          medio de la ejecución exitosa del procedimiento.

    Excepciones:
        - ORA-20003: nombre vacío o nulo.
        - ORA-20004: error general durante la actualización.
    ----------------------------------------------------------------------
    */
    PROCEDURE TK_ACTUALIZA_AREA_P(
        pi_id_area IN INTEGER,
        pv_nombre_area IN VARCHAR2,
        pv_descripcion IN VARCHAR2
    );

    /*
    ----------------------------------------------------------------------
    PROCEDIMIENTO: TK_ELIMINA_AREA_P
    ----------------------------------------------------------------------
    Descripción:
        Elimina un área por su identificador y devuelve un mensaje de resultado.

    Requiere:
        - pi_id_area: ID del área a eliminar.

    Salida:
        - pv_resultado: texto que indica si la operación fue exitosa o si no se
          encontró el registro solicitado.

    Excepciones:
        - ORA-20004: ID nulo.
        - ORA-20005: error general durante la eliminación.
    ----------------------------------------------------------------------
    */
    PROCEDURE TK_ELIMINA_AREA_P(
        pi_id_area IN INTEGER,
        pv_resultado OUT VARCHAR2
    );

    /*
    ----------------------------------------------------------------------
    FUNCIÓN: TK_CONSULTA_AREA_P
    ----------------------------------------------------------------------
    Descripción:
        Retorna un cursor con el conjunto de registros del área consultada.
        Si el identificador es nulo, devuelve todas las áreas existentes.

    Requiere:
        - pi_id_area: identificador opcional del área a buscar.

    Salida:
        - SYS_REFCURSOR con los datos de la consulta.

    Excepciones:
        - ORA-20006: no se encontró el registro esperado.
    ----------------------------------------------------------------------
    */
    FUNCTION TK_CONSULTA_AREA_P(
        pi_id_area IN INTEGER
    ) RETURN SYS_REFCURSOR;
END TK_AREAS_CRUD_PKG;
/