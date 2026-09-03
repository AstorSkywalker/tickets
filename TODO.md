# TODO

## Proximas tareas de pruebas

- [ ] Crear pruebas integrales de permisos y seguridad por rol.
  - [ ] Validar que un solicitante no ejecute acciones de tecnico.
  - [ ] Validar que un tecnico no administre catalogos.
  - [ ] Validar permisos de supervisor para cerrar y cancelar tickets.
  - [ ] Validar que un usuario inactivo no pueda operar.
  - [ ] Confirmar que los errores no expongan informacion sensible.
- [ ] Agregar escenarios de datos invalidos a las pruebas integrales.
- [ ] Verificar que todas las pruebas limpien sus datos temporales.
- [ ] Automatizar unit tests e integration tests con GitHub Actions.
- [ ] Generar un reporte de resultados con fecha, duracion y fallo detectado.

## Comandos principales

```powershell
sql -thin -nolog "@unit-tests/000-ejecuta-unit-tests.sql"
sql -thin -nolog "@integration-tests/000-ejecuta-integration-tests.sql"
```

Ambos comandos solicitan usuario, contrasena y EZ Connect al iniciar.
