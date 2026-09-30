import '../entities/user.dart';

/// Contrato que el dominio necesita. La capa de datos lo implementa.
abstract class UserRepository {
  Future<List<User>> getAll();
  Future<User> add(User user);
  Future<void> update(User user);
  Future<void> delete(int id);
}
