# E07 – Refactor a arquitectura por capas (listas_empleados)

## Cómo ejecutar
```powershell
flutter create .        # genera android/ios/windows/web sin tocar lib/ ni pubspec.yaml
flutter pub get
flutter test
flutter run
```

## Capas y regla de dependencia
```
ui  ──►  domain  ◄──  data
```
- `lib/domain`: entidad `User`, contrato `UserRepository` y casos de uso. No importa Flutter ni `data`.
- `lib/data`: `UserModel`, `UserDataSource` (abstracto), `UserMemoryDataSource` y `UserRepositoryImpl`.
- `lib/ui/user`: pantallas (`list.dart`, `add.dart`), bottom sheet (`widget.dart`) y `UserController`.
- `lib/core/injection.dart`: raíz de composición; único sitio que conoce todas las capas.

## Antes / después
Antes la UI manipulaba los datos directamente. Ahora la UI solo habla con el controlador,
el controlador con casos de uso y estos con la interfaz del repositorio, de modo que cambiar
el origen de datos (E08: SQLite) no toca ni dominio ni UI.
