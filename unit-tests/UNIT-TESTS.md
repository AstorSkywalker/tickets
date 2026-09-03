# Guía de pruebas unitarias

Las pruebas unitarias validan cada paquete CRUD y las reglas de negocio por
módulo. Se ejecutan contra el esquema `TICKETS` en Oracle.

## Requisitos

- SQLcl instalado y disponible como `sql`, o en `C:\sqlcl\bin\sql.exe`.
- Conectividad con Oracle y acceso al servicio `freepdb1`.
- Usuario `TICKETS` con permisos para ejecutar los paquetes y consultar las
  tablas.
- Datos semilla activos: usuarios, roles, áreas y catálogos.

Los maestros solicitan usuario, contraseña y EZ Connect. Los valores
predeterminados definidos actualmente son:

```text
Usuario: TICKETS
Contraseña: Tickets123
EZ Connect: //192.168.0.17:1521/freepdb1
```

Presiona ENTER para aceptar cada valor o escribe uno diferente. No usar estos
valores contra producción.

## Ejecución resumida

Desde `C:\tickets`:

```powershell
& "C:\sqlcl\bin\sql.exe" -thin /nolog "@C:\tickets\unit-tests\000-ejecuta-unit-tests-resumido.sql"
```

Oculta el eco de comandos y el feedback repetitivo, pero conserva la salida de
las aserciones (`OK`) porque las pruebas usan `DBMS_OUTPUT`.

## Ejecución verbose

```powershell
& "C:\sqlcl\bin\sql.exe" -thin /nolog "@C:\tickets\unit-tests\000-ejecuta-unit-tests-verbose.sql"
```

Muestra los comandos, bloques PL/SQL y mensajes de cada aserción. Úsalo para
diagnosticar un fallo.

## Qué validan

- Operaciones CRUD: crear, consultar, actualizar y eliminar cuando aplica.
- Validaciones de datos inválidos y errores esperados.
- Transiciones de estado y reglas del flujo de tickets.
- Relaciones entre usuarios, roles, activos, adjuntos, comentarios e
  historial.

## Orden y cobertura

| Script | Cobertura |
| --- | --- |
| 001 | CRUD de áreas |
| 002 | Flujo principal de tickets |
| 003 | Reglas negativas del negocio |
| 004 | Espera, cancelación y asociación de activos |
| 005 | CRUD de categorías |
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
| 016 | CRUD del historial de tickets |
| 017 | CRUD de tipos de activos |
| 018 | CRUD de activos |
| 019 | CRUD de activos-tickets |

El maestro detiene la ejecución ante un error de Oracle mediante
`WHENEVER SQLERROR EXIT SQL.SQLCODE`. Las pruebas crean datos temporales y
procuran eliminarlos tanto en el flujo normal como en el de excepción.

## Agregar una prueba

1. Crea un archivo con el siguiente número disponible.
2. Usa las variables `DB_USER`, `DB_PASSWORD` y `DB_CONNECT`.
3. No dependas de IDs generados por otra prueba.
4. Limpia los datos temporales en éxito y en excepción.
5. Agrega el archivo al maestro respetando las dependencias.
6. Ejecuta el maestro resumido y usa verbose para investigar fallos.
