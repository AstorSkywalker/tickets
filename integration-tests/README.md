# Pruebas integrales

Las pruebas integrales viven separadas de `unit-tests` porque validan varios
paquetes y tablas trabajando juntos, recorriendo flujos de negocio completos.

## Ejecucion

Desde `C:\tickets`:

```powershell
sql -thin -nolog "@integration-tests/000-ejecuta-integration-tests.sql"
```

El maestro solicita usuario, contrasena y EZ Connect. Por defecto propone
`TICKETS`, `Tickets123` y `//192.168.0.17:1521/freepdb1`, respectivamente.
Presiona Enter para aceptar un valor o escribe uno diferente. No usar esta
configuracion contra produccion.

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

Estas pruebas requieren que existan y esten activos los usuarios y roles
semilla usados por el flujo de negocio, incluyendo sus relaciones en
`TK_USUARIOS_ROLES`. Tambien deben existir los catalogos semilla activos:
areas, categorias, prioridades, estados y tipos de activos.
