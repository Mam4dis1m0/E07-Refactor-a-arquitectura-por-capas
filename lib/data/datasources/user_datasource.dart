import '../models/user_model.dart';

/// Origen de datos abstracto. Hoy en memoria; el repositorio no se entera.
abstract class UserDataSource {
  Future<List<UserModel>> getAll();
  Future<UserModel> insert(UserModel user);
  Future<void> update(UserModel user);
  Future<void> delete(int id);
}
