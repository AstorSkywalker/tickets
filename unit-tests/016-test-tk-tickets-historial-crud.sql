-- Pruebas unitarias para TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG
CONNECT TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1
SET SERVEROUTPUT ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE
DECLARE
 v_id NUMBER; v_gen NUMBER; v_res VARCHAR2(4000); v_cur SYS_REFCURSOR;
 PROCEDURE ok(p BOOLEAN,m VARCHAR2) IS BEGIN IF NOT p THEN RAISE_APPLICATION_ERROR(-20999,'FALLO: '||m); END IF; DBMS_OUTPUT.PUT_LINE('OK: '||m); END;
BEGIN
 TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG.TK_TICKETS_HISTORIAL_CREAR_P(
  p_id_historial_ticket=>NULL,p_id_ticket=>1,p_operacion=>'INSERT',p_id_estado_anterior=>NULL,p_id_estado_nuevo=>NULL,
  p_id_usuario_reporta_viejo=>NULL,p_id_usuario_reporta_nuevo=>NULL,p_id_tecnico_asignado_viejo=>NULL,p_id_tecnico_asignado_nuevo=>NULL,
  p_id_categoria_viejo=>NULL,p_id_categoria_nuevo=>NULL,p_id_prioridad_viejo=>NULL,p_id_prioridad_nuevo=>NULL,p_id_area_viejo=>NULL,p_id_area_nuevo=>NULL,
  p_horas_estimadas_viejo=>NULL,p_horas_estimadas_nuevo=>1,p_horas_reales_viejo=>NULL,p_horas_reales_nuevo=>NULL,p_porcentaje_avance_viejo=>NULL,p_porcentaje_avance_nuevo=>0,
  p_nombre_ticket_viejo=>NULL,p_nombre_ticket_nuevo=>'TEST HISTORIAL',p_descripcion_viejo=>NULL,p_descripcion_nuevo=>TO_CLOB('Nuevo'),p_descripcion_solucion_viejo=>NULL,p_descripcion_solucion_nuevo=>NULL,
  p_fecha_solicitud_viejo=>NULL,p_fecha_solicitud_nuevo=>SYSTIMESTAMP,p_fecha_asignacion_viejo=>NULL,p_fecha_asignacion_nuevo=>NULL,p_fecha_inicio_viejo=>NULL,p_fecha_inicio_nuevo=>NULL,p_fecha_resolucion_viejo=>NULL,p_fecha_resolucion_nuevo=>NULL,p_fecha_cierre_viejo=>NULL,p_fecha_cierre_nuevo=>NULL,
  p_usuario_creacion_viejo=>NULL,p_usuario_creacion_nuevo=>USER,p_fecha_creacion_viejo=>NULL,p_fecha_creacion_nuevo=>SYSTIMESTAMP,p_usuario_actualizacion_viejo=>NULL,p_usuario_actualizacion_nuevo=>NULL,p_fecha_actualizacion_viejo=>NULL,p_fecha_actualizacion_nuevo=>NULL,p_usuario_cambio=>USER,p_fecha_cambio=>SYSTIMESTAMP,po_ID_HISTORIAL_TICKET_generado=>v_gen,pv_resultado=>v_res);
 ok(v_res='OK: REGISTRO CREADO' AND v_gen IS NOT NULL,'crear historial'); v_id:=v_gen;
 v_cur:=TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG.TK_TICKETS_HISTORIAL_CONSULTAR_F(v_id); CLOSE v_cur; ok(v_id IS NOT NULL,'consultar historial');
 TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG.TK_TICKETS_HISTORIAL_ACTUALIZAR_P(
  p_id_historial_ticket=>v_id,p_id_ticket=>1,p_operacion=>'UPDATE',p_id_estado_anterior=>NULL,p_id_estado_nuevo=>NULL,p_id_usuario_reporta_viejo=>NULL,p_id_usuario_reporta_nuevo=>NULL,p_id_tecnico_asignado_viejo=>NULL,p_id_tecnico_asignado_nuevo=>NULL,p_id_categoria_viejo=>NULL,p_id_categoria_nuevo=>NULL,p_id_prioridad_viejo=>NULL,p_id_prioridad_nuevo=>NULL,p_id_area_viejo=>NULL,p_id_area_nuevo=>NULL,p_horas_estimadas_viejo=>NULL,p_horas_estimadas_nuevo=>2,p_horas_reales_viejo=>NULL,p_horas_reales_nuevo=>NULL,p_porcentaje_avance_viejo=>NULL,p_porcentaje_avance_nuevo=>10,p_nombre_ticket_viejo=>'TEST HISTORIAL',p_nombre_ticket_nuevo=>'TEST HISTORIAL ACTUALIZADO',p_descripcion_viejo=>NULL,p_descripcion_nuevo=>NULL,p_descripcion_solucion_viejo=>NULL,p_descripcion_solucion_nuevo=>NULL,p_fecha_solicitud_viejo=>NULL,p_fecha_solicitud_nuevo=>SYSTIMESTAMP,p_fecha_asignacion_viejo=>NULL,p_fecha_asignacion_nuevo=>NULL,p_fecha_inicio_viejo=>NULL,p_fecha_inicio_nuevo=>NULL,p_fecha_resolucion_viejo=>NULL,p_fecha_resolucion_nuevo=>NULL,p_fecha_cierre_viejo=>NULL,p_fecha_cierre_nuevo=>NULL,p_usuario_creacion_viejo=>USER,p_usuario_creacion_nuevo=>USER,p_fecha_creacion_viejo=>SYSTIMESTAMP,p_fecha_creacion_nuevo=>SYSTIMESTAMP,p_usuario_actualizacion_viejo=>NULL,p_usuario_actualizacion_nuevo=>NULL,p_fecha_actualizacion_viejo=>NULL,p_fecha_actualizacion_nuevo=>NULL,p_usuario_cambio=>USER,p_fecha_cambio=>SYSTIMESTAMP,pv_resultado=>v_res);
 ok(v_res='OK: REGISTRO ACTUALIZADO','actualizar historial'); TICKETS.TK_TICKETS_HISTORIAL_CRUD_PKG.TK_TICKETS_HISTORIAL_ELIMINAR_P(v_id,v_res); ok(v_res='OK: REGISTRO ELIMINADO','eliminar historial'); DBMS_OUTPUT.PUT_LINE('=== TODAS LAS PRUEBAS TK_TICKETS_HISTORIAL PASARON ===');
EXCEPTION WHEN OTHERS THEN IF v_cur%ISOPEN THEN CLOSE v_cur; END IF; IF v_id IS NOT NULL THEN DELETE FROM TICKETS.TK_TICKETS_HISTORIAL WHERE ID_HISTORIAL_TICKET=v_id; COMMIT; END IF; RAISE;
END;
/
