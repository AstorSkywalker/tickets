# Pruebas integrales

Las pruebas integrales validan varios paquetes y tablas trabajando juntos. A
diferencia de las unitarias, recorren flujos completos de negocio como crear,
atender, cerrar y consultar un ticket.

## Requisitos

- SQLcl instalado y disponible como `sql`, o en `C:\sqlcl\bin\sql.exe`.
- Conectividad con Oracle y acceso al servicio configurado mediante EZ Connect.
- Usuario `TICKETS` con permisos de ejecución y modificación de datos.
- Datos semilla activos: usuarios, roles, áreas, categorías, prioridades,
  estados y tipos de activos.

## Ejecución

Desde `C:\tickets`:

```powershell
& "C:\sqlcl\bin\sql.exe" -thin /nolog "@C:\tickets\integration-tests\000-ejecuta-integration-tests.sql"
```

El maestro solicita usuario, contraseña y EZ Connect. Sus valores
predeterminados actuales son:

```text
Usuario: TICKETS
Contraseña: Tickets123
EZ Connect: //192.168.0.17:1521/freepdb1
```

Presiona ENTER para aceptar un valor o escribe uno diferente. No usar estos
valores contra producción.

## Qué validan

- `001-test-flujo-ticket-completo.sql`: flujo completo desde `Nuevo` hasta
  `Cerrado`, incluyendo comentario, activo, encuesta e historial.
- `002-test-escenarios-ticket.sql`: espera, reanudación, cancelación, cierre,
  reapertura y rechazo de reapertura no permitida.
- `003-test-adjuntos-ticket.sql`: creación, actualización y conservación de un
  adjunto durante la atención y el cierre.
- `004-test-base-conocimientos-ticket.sql`: creación y publicación de un
  artículo, y resolución de un ticket usando la solución documentada.

El maestro muestra el progreso de cada escenario y se detiene en el primer
error mediante `WHENEVER SQLERROR EXIT SQL.SQLCODE`.

## Limpieza

Las pruebas crean datos temporales y procuran eliminarlos al finalizar tanto
correctamente como después de una excepción. Si una ejecución es interrumpida,
revisa la base antes de repetirla para identificar datos temporales pendientes.
