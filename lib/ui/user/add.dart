import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import 'user_controller.dart';

/// Pantalla para crear o editar un usuario (si recibe [user], edita).
class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key, required this.controller, this.user});

  final UserController controller;
  final User? user;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _email;
  late final TextEditingController _cargo;
  bool _saving = false;

  bool get _isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    _nombre = TextEditingController(text: widget.user?.nombre ?? '');
    _email = TextEditingController(text: widget.user?.email ?? '');
    _cargo = TextEditingController(text: widget.user?.cargo ?? '');
  }

  @override
  void dispose() {
    _nombre.dispose();
    _email.dispose();
    _cargo.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final user = User(
      id: widget.user?.id,
      nombre: _nombre.text.trim(),
      email: _email.text.trim(),
      cargo: _cargo.text.trim(),
    );
    final ok = await widget.controller.save(user);
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.controller.error ?? 'Error al guardar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar empleado' : 'Nuevo empleado'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombre,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa el nombre' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Correo'),
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return 'Ingresa el correo';
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
                return ok ? null : 'Correo no válido';
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cargo,
              decoration: const InputDecoration(labelText: 'Cargo (opcional)'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditing ? 'Guardar cambios' : 'Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
