-- Pruebas unitarias para TICKETS.TK_TICKETS_CRUD_PKG
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET SERVEROUTPUT ON
SET DEFINE ON
WHENEVER SQLERROR EXIT SQL.SQLCODE
DECLARE
    v_id TICKETS.TK_TICKETS.ID_TICKET%TYPE; v_gen TICKETS.TK_TICKETS.ID_TICKET%TYPE;
    v_usr NUMBER; v_cat NUMBER; v_pri NUMBER; v_est NUMBER; v_area NUMBER;
    v_fs TIMESTAMP; v_uc VARCHAR2(128); v_cur SYS_REFCURSOR; v_res VARCHAR2(4000);
    v_name VARCHAR2(200):='TEST CRUD TICKET '||TO_CHAR(SYSTIMESTAMP,'YYYYMMDDHH24MISSFF3');
    PROCEDURE ok(p BOOLEAN,m VARCHAR2) IS BEGIN IF NOT p THEN RAISE_APPLICATION_ERROR(-20999,'FALLO: '||m); END IF; DBMS_OUTPUT.PUT_LINE('OK: '||m); END;
BEGIN
    SELECT ID_USUARIO INTO v_usr FROM TICKETS.TK_USUARIOS WHERE USERNAME='usuario.tickets' AND ACTIVO='S';
    SELECT ID_CATEGORIA INTO v_cat FROM TICKETS.TK_CATEGORIAS WHERE NOMBRE_CATEGORIA='Incidentes' AND ACTIVA='S';
    SELECT ID_PRIORIDAD INTO v_pri FROM TICKETS.TK_CAT_PRIORIDADES WHERE NOMBRE_PRIORIDAD='Media' AND ACTIVA='S';
    SELECT ID_ESTADO INTO v_est FROM TICKETS.TK_CAT_ESTADOS WHERE NOMBRE_ESTADO='Nuevo' AND ACTIVO='S';
    SELECT ID_AREA INTO v_area FROM TICKETS.TK_AREAS WHERE NOMBRE_AREA='Mesa de Ayuda' AND ACTIVA='S';
    TICKETS.TK_TICKETS_CRUD_PKG.TK_TICKETS_CREAR_P(
        p_id_ticket=>NULL,p_nombre_ticket=>v_name,p_descripcion=>TO_CLOB('Ticket CRUD temporal'),
        p_id_usuario_reporta=>v_usr,p_id_tecnico_asignado=>NULL,p_id_categoria=>v_cat,p_id_prioridad=>v_pri,p_id_estado=>v_est,p_id_area=>v_area,
        p_fecha_solicitud=>SYSTIMESTAMP,p_fecha_asignacion=>NULL,p_fecha_inicio=>NULL,p_fecha_resolucion=>NULL,p_fecha_cierre=>NULL,
        p_horas_estimadas=>4,p_horas_reales=>NULL,p_porcentaje_avance=>0,p_descripcion_solucion=>NULL,
        p_usuario_creacion=>USER,p_fecha_creacion=>SYSTIMESTAMP,p_usuario_actualizacion=>NULL,p_fecha_actualizacion=>NULL,
        po_ID_TICKET_generado=>v_gen,pv_resultado=>v_res);
    ok(v_res='OK: REGISTRO CREADO' AND v_gen IS NOT NULL,'crear ticket valido: '||NVL(v_res,'NULL')); v_id:=v_gen;
    v_cur:=TICKETS.TK_TICKETS_CRUD_PKG.TK_TICKETS_CONSULTAR_F(v_id); CLOSE v_cur;
    SELECT FECHA_SOLICITUD,USUARIO_CREACION INTO v_fs,v_uc FROM TICKETS.TK_TICKETS WHERE ID_TICKET=v_id;
    ok(v_id IS NOT NULL,'consultar ticket');
    TICKETS.TK_TICKETS_CRUD_PKG.TK_TICKETS_ACTUALIZAR_P(
        p_id_ticket=>v_id,p_nombre_ticket=>v_name||' ACTUALIZADO',p_descripcion=>TO_CLOB('Descripcion actualizada'),
        p_id_usuario_reporta=>v_usr,p_id_tecnico_asignado=>NULL,p_id_categoria=>v_cat,p_id_prioridad=>v_pri,p_id_estado=>v_est,p_id_area=>v_area,
        p_fecha_solicitud=>v_fs,p_fecha_asignacion=>NULL,p_fecha_inicio=>NULL,p_fecha_resolucion=>NULL,p_fecha_cierre=>NULL,
        p_horas_estimadas=>5,p_horas_reales=>2,p_porcentaje_avance=>25,p_descripcion_solucion=>TO_CLOB('Solucion'),
        p_usuario_creacion=>v_uc,p_fecha_creacion=>v_fs,p_usuario_actualizacion=>NULL,p_fecha_actualizacion=>NULL,pv_resultado=>v_res);
    ok(v_res='OK: REGISTRO ACTUALIZADO','actualizar ticket valido');
    TICKETS.TK_TICKETS_CRUD_PKG.TK_TICKETS_ACTUALIZAR_P(
        p_id_ticket=>v_id,p_nombre_ticket=>v_name,p_descripcion=>TO_CLOB('No debe actualizarse'),
        p_id_usuario_reporta=>v_usr,p_id_tecnico_asignado=>NULL,p_id_categoria=>v_cat,p_id_prioridad=>v_pri,p_id_estado=>v_est,p_id_area=>v_area,
        p_fecha_solicitud=>v_fs,p_fecha_asignacion=>NULL,p_fecha_inicio=>NULL,p_fecha_resolucion=>NULL,p_fecha_cierre=>NULL,
        p_horas_estimadas=>5,p_horas_reales=>2,p_porcentaje_avance=>101,p_descripcion_solucion=>NULL,
        p_usuario_creacion=>v_uc,p_fecha_creacion=>v_fs,p_usuario_actualizacion=>NULL,p_fecha_actualizacion=>NULL,pv_resultado=>v_res);
    ok(v_res LIKE 'ERROR:%','rechazar porcentaje fuera de rango');
    TICKETS.TK_TICKETS_CRUD_PKG.TK_TICKETS_ELIMINAR_P(v_id,v_res); ok(v_res='OK: REGISTRO ELIMINADO','eliminar ticket');
    DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_TICKETS PASARON ===');
EXCEPTION WHEN OTHERS THEN IF v_cur%ISOPEN THEN CLOSE v_cur; END IF; IF v_id IS NOT NULL THEN DELETE FROM TICKETS.TK_COMENTARIOS WHERE ID_TICKET=v_id; DELETE FROM TICKETS.TK_ENCUESTAS WHERE ID_TICKET=v_id; DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_TICKET=v_id; DELETE FROM TICKETS.TK_TICKETS WHERE ID_TICKET=v_id; COMMIT; END IF; RAISE;
END;
/
