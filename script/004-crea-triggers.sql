-- Correr con usuario TICKETS
-- Triggers del proyecto de tickets
SET DEFINE OFF;
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TICKETS.TK_AREAS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_AREAS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_AREAS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        19/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_AREAS_BIU_TRG
      Sysdate:         19/08/2026
      Date and Time:   19/08/2026, 12:11:23 PM, and 19/08/2026 12:11:23 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_AREAS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/

BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_AREAS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_BASE_CONOCIMIENTOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_BASE_CONOCIMIENTOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_BASE_CONOCIMIENTOS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_BASE_CONOCIMIENTOS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:04:52 PM, and 24/08/2026 5:04:52 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_BASE_CONOCIMIENTOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_BASE_CONOCIMIENTOS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_CAT_ESTADOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_CAT_ESTADOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 4:50:52 PM, and 24/08/2026 4:50:52 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_CAT_ESTADOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_CAT_PRIORIDADES_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_CAT_PRIORIDADES
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 4:51:47 PM, and 24/08/2026 4:51:47 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_CAT_PRIORIDADES (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_CATEGORIAS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_CATEGORIAS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_CATEGORIAS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_CATEGORIAS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 4:49:03 PM, and 24/08/2026 4:49:03 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_CATEGORIAS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/

BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_CATEGORIAS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_COMENTARIOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_COMENTARIOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_COMENTARIOS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_COMENTARIOS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:05:35 PM, and 24/08/2026 5:05:35 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_COMENTARIOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN


   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_COMENTARIOS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_ENCUESTAS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_ENCUESTAS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_ENCUESTAS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_ENCUESTAS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:06:23 PM, and 24/08/2026 5:06:23 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_ENCUESTAS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN


   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   


   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_ENCUESTAS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_ROLES_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_ROLES
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 4:53:06 PM, and 24/08/2026 4:53:06 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_ROLES (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_TICKET_ADJUNTOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_TICKET_ADJUNTOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_TICKET_ADJUNTOS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_TICKET_ADJUNTOS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:07:23 PM, and 24/08/2026 5:07:23 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_TICKET_ADJUNTOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN


   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   


   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_TICKET_ADJUNTOS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_TIPOS_ACTIVOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_TIPOS_ACTIVOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_TIPOS_ACTIVOS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_TIPOS_ACTIVOS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 4:55:26 PM, and 24/08/2026 4:55:26 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_TIPOS_ACTIVOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_TIPOS_ACTIVOS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_USUARIOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_USUARIOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_USUARIOS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_USUARIOS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:00:19 PM, and 24/08/2026 5:00:19 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_USUARIOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_USUARIOS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_USUARIOS_ROLES_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_USUARIOS_ROLES
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_USUARIOS_ROLES_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_USUARIOS_ROLES_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:08:04 PM, and 24/08/2026 5:08:04 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_USUARIOS_ROLES (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN


   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   


   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_USUARIOS_ROLES_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TRG_TK_TICKETS_HIST_DEL
AFTER DELETE ON TICKETS.TK_TICKETS
FOR EACH ROW
DECLARE
    V_USUARIO_CAMBIO VARCHAR2(128 CHAR);
BEGIN
    V_USUARIO_CAMBIO :=
        COALESCE(
            SYS_CONTEXT('APEX$SESSION', 'APP_USER'),
            SYS_CONTEXT('USERENV', 'SESSION_USER')
        );

    INSERT INTO TK_TICKETS_HISTORIAL
    (
        ID_TICKET,
        OPERACION,
        ID_ESTADO_ANTERIOR,
        ID_USUARIO_REPORTA_VIEJO,
        ID_TECNICO_ASIGNADO_VIEJO,
        ID_CATEGORIA_VIEJO,
        ID_PRIORIDAD_VIEJO,
        ID_AREA_VIEJO,
        HORAS_ESTIMADAS_VIEJO,
        HORAS_REALES_VIEJO,
        PORCENTAJE_AVANCE_VIEJO,
        NOMBRE_TICKET_VIEJO,
        DESCRIPCION_VIEJO,
        DESCRIPCION_SOLUCION_VIEJO,
        FECHA_SOLICITUD_VIEJO,
        FECHA_ASIGNACION_VIEJO,
        FECHA_INICIO_VIEJO,
        FECHA_RESOLUCION_VIEJO,
        FECHA_CIERRE_VIEJO,
        USUARIO_CREACION_VIEJO,
        FECHA_CREACION_VIEJO,
        USUARIO_ACTUALIZACION_VIEJO,
        FECHA_ACTUALIZACION_VIEJO,
        USUARIO_CAMBIO,
        FECHA_CAMBIO
    )
    VALUES
    (
        :OLD.ID_TICKET,
        'DELETE',
        :OLD.ID_ESTADO,
        :OLD.ID_USUARIO_REPORTA,
        :OLD.ID_TECNICO_ASIGNADO,
        :OLD.ID_CATEGORIA,
        :OLD.ID_PRIORIDAD,
        :OLD.ID_AREA,
        :OLD.HORAS_ESTIMADAS,
        :OLD.HORAS_REALES,
        :OLD.PORCENTAJE_AVANCE,
        :OLD.NOMBRE_TICKET,
        :OLD.DESCRIPCION,
        :OLD.DESCRIPCION_SOLUCION,
        :OLD.FECHA_SOLICITUD,
        :OLD.FECHA_ASIGNACION,
        :OLD.FECHA_INICIO,
        :OLD.FECHA_RESOLUCION,
        :OLD.FECHA_CIERRE,
        :OLD.USUARIO_CREACION,
        :OLD.FECHA_CREACION,
        :OLD.USUARIO_ACTUALIZACION,
        :OLD.FECHA_ACTUALIZACION,
        V_USUARIO_CAMBIO,
        SYSTIMESTAMP
    );
END;
/

CREATE OR REPLACE TRIGGER TICKETS.TRG_TK_TICKETS_HIST_INS
AFTER INSERT ON TICKETS.TK_TICKETS
FOR EACH ROW
DECLARE
    V_USUARIO_CAMBIO VARCHAR2(128 CHAR);
BEGIN
    V_USUARIO_CAMBIO :=
        COALESCE(
            SYS_CONTEXT('APEX$SESSION', 'APP_USER'),
            SYS_CONTEXT('USERENV', 'SESSION_USER')
        );

    INSERT INTO TK_TICKETS_HISTORIAL
    (
        ID_TICKET,
        OPERACION,
        ID_ESTADO_NUEVO,
        ID_USUARIO_REPORTA_NUEVO,
        ID_TECNICO_ASIGNADO_NUEVO,
        ID_CATEGORIA_NUEVO,
        ID_PRIORIDAD_NUEVO,
        ID_AREA_NUEVO,
        HORAS_ESTIMADAS_NUEVO,
        HORAS_REALES_NUEVO,
        PORCENTAJE_AVANCE_NUEVO,
        NOMBRE_TICKET_NUEVO,
        DESCRIPCION_NUEVO,
        DESCRIPCION_SOLUCION_NUEVO,
        FECHA_SOLICITUD_NUEVO,
        FECHA_ASIGNACION_NUEVO,
        FECHA_INICIO_NUEVO,
        FECHA_RESOLUCION_NUEVO,
        FECHA_CIERRE_NUEVO,
        USUARIO_CREACION_NUEVO,
        FECHA_CREACION_NUEVO,
        USUARIO_ACTUALIZACION_NUEVO,
        FECHA_ACTUALIZACION_NUEVO,
        USUARIO_CAMBIO,
        FECHA_CAMBIO
    )
    VALUES
    (
        :NEW.ID_TICKET,
        'INSERT',
        :NEW.ID_ESTADO,
        :NEW.ID_USUARIO_REPORTA,
        :NEW.ID_TECNICO_ASIGNADO,
        :NEW.ID_CATEGORIA,
        :NEW.ID_PRIORIDAD,
        :NEW.ID_AREA,
        :NEW.HORAS_ESTIMADAS,
        :NEW.HORAS_REALES,
        :NEW.PORCENTAJE_AVANCE,
        :NEW.NOMBRE_TICKET,
        :NEW.DESCRIPCION,
        :NEW.DESCRIPCION_SOLUCION,
        :NEW.FECHA_SOLICITUD,
        :NEW.FECHA_ASIGNACION,
        :NEW.FECHA_INICIO,
        :NEW.FECHA_RESOLUCION,
        :NEW.FECHA_CIERRE,
        :NEW.USUARIO_CREACION,
        :NEW.FECHA_CREACION,
        :NEW.USUARIO_ACTUALIZACION,
        :NEW.FECHA_ACTUALIZACION,
        V_USUARIO_CAMBIO,
        SYSTIMESTAMP
    );
END;
/

CREATE OR REPLACE TRIGGER TICKETS.TRG_TK_TICKETS_HIST_UPD
AFTER UPDATE ON TICKETS.TK_TICKETS
FOR EACH ROW
DECLARE
    V_USUARIO_CAMBIO VARCHAR2(128 CHAR);
BEGIN
    V_USUARIO_CAMBIO :=
        COALESCE(
            SYS_CONTEXT('APEX$SESSION', 'APP_USER'),
            SYS_CONTEXT('USERENV', 'SESSION_USER')
        );

    INSERT INTO TK_TICKETS_HISTORIAL
    (
        ID_TICKET,
        OPERACION,
        ID_ESTADO_ANTERIOR,
        ID_ESTADO_NUEVO,
        ID_USUARIO_REPORTA_VIEJO,
        ID_USUARIO_REPORTA_NUEVO,
        ID_TECNICO_ASIGNADO_VIEJO,
        ID_TECNICO_ASIGNADO_NUEVO,
        ID_CATEGORIA_VIEJO,
        ID_CATEGORIA_NUEVO,
        ID_PRIORIDAD_VIEJO,
        ID_PRIORIDAD_NUEVO,
        ID_AREA_VIEJO,
        ID_AREA_NUEVO,
        HORAS_ESTIMADAS_VIEJO,
        HORAS_ESTIMADAS_NUEVO,
        HORAS_REALES_VIEJO,
        HORAS_REALES_NUEVO,
        PORCENTAJE_AVANCE_VIEJO,
        PORCENTAJE_AVANCE_NUEVO,
        NOMBRE_TICKET_VIEJO,
        NOMBRE_TICKET_NUEVO,
        DESCRIPCION_VIEJO,
        DESCRIPCION_NUEVO,
        DESCRIPCION_SOLUCION_VIEJO,
        DESCRIPCION_SOLUCION_NUEVO,
        FECHA_SOLICITUD_VIEJO,
        FECHA_SOLICITUD_NUEVO,
        FECHA_ASIGNACION_VIEJO,
        FECHA_ASIGNACION_NUEVO,
        FECHA_INICIO_VIEJO,
        FECHA_INICIO_NUEVO,
        FECHA_RESOLUCION_VIEJO,
        FECHA_RESOLUCION_NUEVO,
        FECHA_CIERRE_VIEJO,
        FECHA_CIERRE_NUEVO,
        USUARIO_CREACION_VIEJO,
        USUARIO_CREACION_NUEVO,
        FECHA_CREACION_VIEJO,
        FECHA_CREACION_NUEVO,
        USUARIO_ACTUALIZACION_VIEJO,
        USUARIO_ACTUALIZACION_NUEVO,
        FECHA_ACTUALIZACION_VIEJO,
        FECHA_ACTUALIZACION_NUEVO,
        USUARIO_CAMBIO,
        FECHA_CAMBIO
    )
    VALUES
    (
        :OLD.ID_TICKET,
        'UPDATE',
        :OLD.ID_ESTADO,
        :NEW.ID_ESTADO,
        :OLD.ID_USUARIO_REPORTA,
        :NEW.ID_USUARIO_REPORTA,
        :OLD.ID_TECNICO_ASIGNADO,
        :NEW.ID_TECNICO_ASIGNADO,
        :OLD.ID_CATEGORIA,
        :NEW.ID_CATEGORIA,
        :OLD.ID_PRIORIDAD,
        :NEW.ID_PRIORIDAD,
        :OLD.ID_AREA,
        :NEW.ID_AREA,
        :OLD.HORAS_ESTIMADAS,
        :NEW.HORAS_ESTIMADAS,
        :OLD.HORAS_REALES,
        :NEW.HORAS_REALES,
        :OLD.PORCENTAJE_AVANCE,
        :NEW.PORCENTAJE_AVANCE,
        :OLD.NOMBRE_TICKET,
        :NEW.NOMBRE_TICKET,
        :OLD.DESCRIPCION,
        :NEW.DESCRIPCION,
        :OLD.DESCRIPCION_SOLUCION,
        :NEW.DESCRIPCION_SOLUCION,
        :OLD.FECHA_SOLICITUD,
        :NEW.FECHA_SOLICITUD,
        :OLD.FECHA_ASIGNACION,
        :NEW.FECHA_ASIGNACION,
        :OLD.FECHA_INICIO,
        :NEW.FECHA_INICIO,
        :OLD.FECHA_RESOLUCION,
        :NEW.FECHA_RESOLUCION,
        :OLD.FECHA_CIERRE,
        :NEW.FECHA_CIERRE,
        :OLD.USUARIO_CREACION,
        :NEW.USUARIO_CREACION,
        :OLD.FECHA_CREACION,
        :NEW.FECHA_CREACION,
        :OLD.USUARIO_ACTUALIZACION,
        :NEW.USUARIO_ACTUALIZACION,
        :OLD.FECHA_ACTUALIZACION,
        :NEW.FECHA_ACTUALIZACION,
        V_USUARIO_CAMBIO,
        SYSTIMESTAMP
    );
END;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_ACTIVOS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_ACTIVOS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE


/******************************************************************************
   NAME:       TK_ACTIVOS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_ACTIVOS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:01:36 PM, and 24/08/2026 5:01:36 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_ACTIVOS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   


   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_ACTIVOS_BIU_TRG;
/

CREATE OR REPLACE TRIGGER TICKETS.TK_ACTIVOS_TICKETS_BIU_TRG
BEFORE INSERT OR UPDATE
ON TICKETS.TK_ACTIVOS_TICKETS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

/******************************************************************************
   NAME:       TK_ACTIVOS_TICKETS_BIU_TRG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        24/08/2026      User       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TK_ACTIVOS_TICKETS_BIU_TRG
      Sysdate:         24/08/2026
      Date and Time:   24/08/2026, 5:02:39 PM, and 24/08/2026 5:02:39 PM
      Username:        User (set in TOAD Options, Proc Templates)
      Table Name:      TK_ACTIVOS_TICKETS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

   -- Maneja el INSERT
   IF INSERTING THEN
        :NEW.FECHA_CREACION    := SYSTIMESTAMP;
        :NEW.USUARIO_CREACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
   END IF;

   -- Maneja el UPDATE
   IF UPDATING THEN
        :NEW.FECHA_ACTUALIZACION    := SYSTIMESTAMP;
        :NEW.USUARIO_ACTUALIZACION  := COALESCE(
                                        SYS_CONTEXT('APEX$SESSION', 'APP_USER'), -- Captures the active APEX user
                                        SYS_CONTEXT('USERENV', 'SESSION_USER')   -- Fallback if run from SQL*Developer/PL/SQL
                                        );
    
   END IF;
   

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TK_ACTIVOS_TICKETS_BIU_TRG;
/

