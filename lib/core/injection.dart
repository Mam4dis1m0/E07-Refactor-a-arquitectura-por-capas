import '../data/datasources/user_datasource.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/usecases/user_usecases.dart';
import '../ui/user/user_controller.dart';

/// Raíz de composición: único lugar que conoce todas las capas.
UserController buildUserController(UserDataSource dataSource) {
  final repository = UserRepositoryImpl(dataSource);
  return UserController(
    getUsers: GetUsers(repository),
    addUser: AddUser(repository),
    updateUser: UpdateUser(repository),
    deleteUser: DeleteUser(repository),
  );
}
