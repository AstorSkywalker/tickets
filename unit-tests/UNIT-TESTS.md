# Guia de pruebas unitarias

Esta carpeta contiene las pruebas de los paquetes CRUD y de las reglas de
negocio del sistema de tickets. Se ejecutan contra el esquema `TICKETS` en la
base de datos Oracle de desarrollo.

## Requisitos

- SQLcl instalado en `C:\sqlcl\bin\sql.exe`.
- Acceso de red a Oracle.
- Permisos para ejecutar los paquetes y consultar las tablas.
- Datos semilla activos para usuarios, areas y catalogos.

La conexion de desarrollo utilizada es:

```text
TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1
```

No usar esta configuracion contra produccion.

## Ejecucion normal

Desde `C:\tickets`:

```powershell
sql -thin "TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1" "@unit-tests/000-ejecuta-unit-tests.sql"
```

El maestro ejecuta las 19 pruebas en orden y muestra una linea `[OK]` por
modulo. Al finalizar muestra:

```text
=== TODAS LAS PRUEBAS PASARON ===
```

## Ejecucion verbose

Para mostrar cada asercion, el codigo PL/SQL y los comandos ejecutados:

```powershell
sql -thin "TICKETS/Tickets123@//192.168.80.178:1521/FREEpdb1" "@unit-tests/000-ejecuta-unit-tests-verbose.sql"
```

El modo normal se recomienda para ejecuciones rutinarias; verbose sirve para
diagnosticar un fallo.

## Orden y cobertura

| Script | Cobertura |
| --- | --- |
| 001 | CRUD de areas |
| 002 | Flujo principal de tickets |
| 003 | Reglas negativas del negocio |
| 004 | Espera, cancelacion y asociacion de activos |
| 005 | CRUD de categorias |
| 006 | CRUD de base de conocimientos |
| 007 | CRUD de estados |
| 008 | CRUD de prioridades |
| 009 | CRUD de comentarios |
| 010 | CRUD de encuestas |
| 011 | CRUD de roles |
| 012 | CRUD de usuarios |
| 013 | CRUD de usuarios-roles |
| 015 | CRUD de tickets |
| 014 | CRUD de adjuntos |
| 016 | CRUD de historial de tickets |
| 017 | CRUD de tipos de activos |
| 018 | CRUD de activos |
| 019 | CRUD de activos-tickets |

El orden respeta las dependencias: tickets se prueba antes de adjuntos, y
tipos de activos y activos antes de su relacion.

## Comportamiento y limpieza

- Cada prueba valida creacion, consulta, actualizacion y eliminacion cuando
  aplica, ademas de errores esperados para datos invalidos.
- Las pruebas que necesitan claves foraneas crean datos temporales y los
  eliminan al terminar.
- El maestro usa `WHENEVER SQLERROR EXIT SQL.SQLCODE`; ante un error se detiene
  y devuelve el codigo de Oracle.
- Los bloques de excepcion intentan limpiar los datos temporales antes de
  propagar el fallo.

## Agregar una prueba

1. Crear un archivo con el siguiente numero disponible.
2. Usar EZ Connect al servicio `FREEpdb1`.
3. No depender de IDs generados previamente.
4. Limpiar los datos temporales en el flujo normal y en la excepcion.
5. Agregar el archivo al maestro respetando sus dependencias.
6. Ejecutar el maestro normal y usar verbose para investigar fallos.
