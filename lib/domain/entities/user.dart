/// Entidad de dominio. No conoce Flutter, SQLite ni ningún detalle de datos.
class User {
  const User({
    this.id,
    required this.nombre,
    required this.email,
    this.cargo = '',
  });

  final int? id;
  final String nombre;
  final String email;
  final String cargo;

  User copyWith({int? id, String? nombre, String? email, String? cargo}) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      cargo: cargo ?? this.cargo,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is User &&
      other.id == id &&
      other.nombre == nombre &&
      other.email == email &&
      other.cargo == cargo;

  @override
  int get hashCode => Object.hash(id, nombre, email, cargo);
}
