-- Datos semilla para TK_USUARIOS y TK_USUARIOS_ROLES
-- Estos son usuarios funcionales de la aplicación, no usuarios de Oracle.
SET DEFINE ON
CONNECT &DB_USER/&DB_PASSWORD@&DB_CONNECT
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

MERGE INTO TICKETS.TK_USUARIOS u
USING (
    SELECT 'Administrador' AS nombre, 'Tickets' AS apellido, 'admin.tickets' AS username,
           'admin.tickets@ejemplo.com' AS email, '0000-0000' AS telefono,
           'Mesa de Ayuda' AS ubicacion, 'S' AS activo FROM DUAL
    UNION ALL SELECT 'Técnico', 'Tickets', 'tecnico.tickets', 'tecnico.tickets@ejemplo.com', '0000-0001', 'Mesa de Ayuda', 'S' FROM DUAL
    UNION ALL SELECT 'Supervisor', 'Tickets', 'supervisor.tickets', 'supervisor.tickets@ejemplo.com', '0000-0002', 'Mesa de Ayuda', 'S' FROM DUAL
    UNION ALL SELECT 'Usuario', 'Tickets', 'usuario.tickets', 'usuario.tickets@ejemplo.com', '0000-0003', 'Mesa de Ayuda', 'S' FROM DUAL
) s
ON (u.USERNAME = s.USERNAME)
WHEN MATCHED THEN UPDATE SET
    u.NOMBRE = s.NOMBRE,
    u.APELLIDO = s.APELLIDO,
    u.EMAIL = s.EMAIL,
    u.TELEFONO = s.TELEFONO,
    u.UBICACION = s.UBICACION,
    u.ACTIVO = s.ACTIVO
WHEN NOT MATCHED THEN INSERT (
    NOMBRE, APELLIDO, USERNAME, EMAIL, TELEFONO, UBICACION, ACTIVO
)
VALUES (
    s.NOMBRE, s.APELLIDO, s.USERNAME, s.EMAIL, s.TELEFONO, s.UBICACION, s.ACTIVO
);

MERGE INTO TICKETS.TK_USUARIOS_ROLES ur
USING (
    SELECT u.ID_USUARIO, r.ID_ROL
      FROM TICKETS.TK_USUARIOS u
      CROSS JOIN TICKETS.TK_ROLES r
     WHERE (u.USERNAME, r.NOMBRE_ROL) IN (
         ('admin.tickets', 'Administrador'),
         ('tecnico.tickets', 'Técnico'),
         ('supervisor.tickets', 'Supervisor'),
         ('usuario.tickets', 'Usuario')
     )
) s
ON (ur.ID_USUARIO = s.ID_USUARIO AND ur.ID_ROL = s.ID_ROL)
WHEN NOT MATCHED THEN INSERT (ID_USUARIO, ID_ROL)
VALUES (s.ID_USUARIO, s.ID_ROL);

COMMIT;
