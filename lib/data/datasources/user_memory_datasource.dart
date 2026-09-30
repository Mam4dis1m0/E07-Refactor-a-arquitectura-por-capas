import '../models/user_model.dart';
import 'user_datasource.dart';

class UserMemoryDataSource implements UserDataSource {
  final List<UserModel> _items = [];
  int _nextId = 1;

  @override
  Future<List<UserModel>> getAll() async => List.of(_items);

  @override
  Future<UserModel> insert(UserModel user) async {
    final saved = user.copyWith(id: _nextId++);
    _items.add(saved);
    return saved;
  }

  @override
  Future<void> update(UserModel user) async {
    final index = _items.indexWhere((u) => u.id == user.id);
    if (index == -1) {
      throw StateError('Usuario no encontrado: ${user.id}');
    }
    _items[index] = user;
  }

  @override
  Future<void> delete(int id) async {
    _items.removeWhere((u) => u.id == id);
  }
}
