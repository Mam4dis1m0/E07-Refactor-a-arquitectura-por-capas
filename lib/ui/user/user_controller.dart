import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/user_usecases.dart';

/// Estado de la pantalla. Solo depende de casos de uso (dominio).
class UserController extends ChangeNotifier {
  UserController({
    required GetUsers getUsers,
    required AddUser addUser,
    required UpdateUser updateUser,
    required DeleteUser deleteUser,
  })  : _getUsers = getUsers,
        _addUser = addUser,
        _updateUser = updateUser,
        _deleteUser = deleteUser;

  final GetUsers _getUsers;
  final AddUser _addUser;
  final UpdateUser _updateUser;
  final DeleteUser _deleteUser;

  List<User> _users = const [];
  bool _loading = false;
  String? _error;

  List<User> get users => _users;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _users = await _getUsers();
    } catch (e) {
      _error = 'No se pudo cargar la lista: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Crea o actualiza según tenga id. Devuelve true si salió bien.
  Future<bool> save(User user) async {
    try {
      if (user.id == null) {
        await _addUser(user);
      } else {
        await _updateUser(user);
      }
      await load();
      return true;
    } catch (e) {
      _error = 'No se pudo guardar: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> remove(int id) async {
    try {
      await _deleteUser(id);
      await load();
    } catch (e) {
      _error = 'No se pudo eliminar: $e';
      notifyListeners();
    }
  }
}
