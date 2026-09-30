import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsers {
  const GetUsers(this._repository);
  final UserRepository _repository;

  Future<List<User>> call() => _repository.getAll();
}

class AddUser {
  const AddUser(this._repository);
  final UserRepository _repository;

  Future<User> call(User user) => _repository.add(user);
}

class UpdateUser {
  const UpdateUser(this._repository);
  final UserRepository _repository;

  Future<void> call(User user) => _repository.update(user);
}

class DeleteUser {
  const DeleteUser(this._repository);
  final UserRepository _repository;

  Future<void> call(int id) => _repository.delete(id);
}
