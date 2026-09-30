import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._dataSource);
  final UserDataSource _dataSource;

  @override
  Future<List<User>> getAll() async {
    final models = await _dataSource.getAll();
    final users = models.map((m) => m.toEntity()).toList();
    users.sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
    return users;
  }

  @override
  Future<User> add(User user) async {
    final saved = await _dataSource.insert(UserModel.fromEntity(user));
    return saved.toEntity();
  }

  @override
  Future<void> update(User user) async {
    if (user.id == null) {
      throw ArgumentError('No se puede actualizar un usuario sin id');
    }
    await _dataSource.update(UserModel.fromEntity(user));
  }

  @override
  Future<void> delete(int id) => _dataSource.delete(id);
}
