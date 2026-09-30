import 'package:flutter_test/flutter_test.dart';
import 'package:listas_empleados/core/injection.dart';
import 'package:listas_empleados/data/datasources/user_memory_datasource.dart';
import 'package:listas_empleados/data/repositories/user_repository_impl.dart';
import 'package:listas_empleados/domain/entities/user.dart';

void main() {
  group('UserRepositoryImpl', () {
    late UserRepositoryImpl repo;

    setUp(() => repo = UserRepositoryImpl(UserMemoryDataSource()));

    test('add asigna id y getAll devuelve ordenado por nombre', () async {
      final b = await repo.add(const User(nombre: 'beto', email: 'b@x.co'));
      final a = await repo.add(const User(nombre: 'Ana', email: 'a@x.co'));

      expect(a.id, isNotNull);
      expect(b.id, isNot(a.id));
      final all = await repo.getAll();
      expect(all.map((u) => u.nombre), ['Ana', 'beto']);
    });

    test('update modifica el registro existente', () async {
      final u = await repo.add(const User(nombre: 'Ana', email: 'a@x.co'));
      await repo.update(u.copyWith(cargo: 'Gerente'));

      final all = await repo.getAll();
      expect(all.single.cargo, 'Gerente');
    });

    test('update sin id lanza ArgumentError', () {
      expect(
        () => repo.update(const User(nombre: 'X', email: 'x@x.co')),
        throwsArgumentError,
      );
    });

    test('delete elimina el registro', () async {
      final u = await repo.add(const User(nombre: 'Ana', email: 'a@x.co'));
      await repo.delete(u.id!);
      expect(await repo.getAll(), isEmpty);
    });
  });

  group('UserController', () {
    test('save crea, actualiza y remove elimina; notifica la lista', () async {
      final c = buildUserController(UserMemoryDataSource());

      await c.load();
      expect(c.users, isEmpty);

      expect(await c.save(const User(nombre: 'Ana', email: 'a@x.co')), isTrue);
      expect(c.users, hasLength(1));

      final saved = c.users.single;
      await c.save(saved.copyWith(nombre: 'Ana María'));
      expect(c.users.single.nombre, 'Ana María');

      await c.remove(saved.id!);
      expect(c.users, isEmpty);
    });
  });
}
