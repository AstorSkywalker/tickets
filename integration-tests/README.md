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

- `001-test-flujo-ticket-completo.sql`: ciclo completo desde `Nuevo` hasta
  `Cerrado`, con comentario, activo, encuesta e historial.
- `002-test-escenarios-ticket.sql`: espera, reanudacion, cancelacion, cierre,
  reapertura y rechazo de reapertura no permitida.
- `003-test-adjuntos-ticket.sql`: crear, actualizar y conservar un adjunto
  durante la atencion y cierre del ticket.
- `004-test-base-conocimientos-ticket.sql`: crear y publicar un articulo, y
  resolver un ticket usando la solucion documentada.

La prueba crea datos temporales y los elimina tanto al finalizar correctamente
como cuando ocurre un error. El maestro se detiene en el primer error mediante
`WHENEVER SQLERROR EXIT SQL.SQLCODE`.

Estas pruebas requieren que existan y esten activos los usuarios y roles
semilla usados por el flujo de negocio, incluyendo sus relaciones en
`TK_USUARIOS_ROLES`. Tambien deben existir los catalogos semilla activos:
areas, categorias, prioridades, estados y tipos de activos.
