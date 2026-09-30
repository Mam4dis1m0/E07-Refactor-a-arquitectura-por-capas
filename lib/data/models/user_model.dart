import '../../domain/entities/user.dart';

/// Modelo de la capa de datos: sabe convertirse a/desde mapas y a entidad.
class UserModel {
  const UserModel({
    this.id,
    required this.nombre,
    required this.email,
    this.cargo = '',
  });

  final int? id;
  final String nombre;
  final String email;
  final String cargo;

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        nombre: user.nombre,
        email: user.email,
        cargo: user.cargo,
      );

  factory UserModel.fromMap(Map<String, Object?> map) => UserModel(
        id: map['id'] as int?,
        nombre: map['nombre'] as String,
        email: map['email'] as String,
        cargo: (map['cargo'] as String?) ?? '',
      );

  Map<String, Object?> toMap() => {
        if (id != null) 'id': id,
        'nombre': nombre,
        'email': email,
        'cargo': cargo,
      };

  User toEntity() => User(id: id, nombre: nombre, email: email, cargo: cargo);

  UserModel copyWith({int? id}) =>
      UserModel(id: id ?? this.id, nombre: nombre, email: email, cargo: cargo);
}
