-- Ejecutar con un usuario con privilegios de administrador.
-- Borra usuario y tablespace de la base de datos.
-- El usuario no debe estar conectado a la base de datos al momento de ejecutar el script.

-- Preguntar al usuario si desea continuar.
prompt ATENCION: Este script borrará el usuario TICKETS y su tablespace TBS_TICKETS. ¿Desea continuar? (S/N)
accept continuar char format 'A' default 'N'
drop user tickets cascade;
drop tablespace tbs_tickets including contents and datafiles;
