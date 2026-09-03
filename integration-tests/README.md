# Pruebas integrales

Las pruebas integrales viven separadas de `unit-tests` porque validan varios
paquetes y tablas trabajando juntos, recorriendo flujos de negocio completos.

## Ejecucion

Desde `C:\tickets`:

```powershell
sql -thin "TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1" "@integration-tests/000-ejecuta-integration-tests.sql"
```

## Cobertura actual

`001-test-flujo-ticket-completo.sql` valida el flujo de un ticket desde su
creacion hasta el cierre:

- estado inicial `Nuevo`;
- asignacion a tecnico e inicio de atencion;
- comentario del solicitante;
- asociacion de un activo;
- resolucion y cierre;
- encuesta posterior al cierre;
- persistencia del historial y de la relacion con el activo.

La prueba crea datos temporales y los elimina tanto al finalizar correctamente
como cuando ocurre un error. El maestro se detiene en el primer error mediante
`WHENEVER SQLERROR EXIT SQL.SQLCODE`.

Estas pruebas requieren los usuarios y catalogos semilla activos usados por el
flujo de negocio.
