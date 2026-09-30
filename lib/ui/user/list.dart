import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import 'add.dart';
import 'user_controller.dart';
import 'widget.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key, required this.controller});

  final UserController controller;

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  void _openForm([User? user]) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AddUserScreen(controller: widget.controller, user: user),
      ),
    );
  }

  Future<void> _confirmDelete(User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar empleado'),
        content: Text('¿Eliminar a ${user.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed == true && user.id != null) {
      await widget.controller.remove(user.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Empleados')),
      body: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          final c = widget.controller;
          if (c.loading && c.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (c.error != null && c.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.error!),
                  const SizedBox(height: 12),
                  FilledButton(onPressed: c.load, child: const Text('Reintentar')),
                ],
              ),
            );
          }
          if (c.users.isEmpty) {
            return const Center(child: Text('No hay empleados registrados'));
          }
          return ListView.separated(
            itemCount: c.users.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final user = c.users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user.nombre.isEmpty ? '?' : user.nombre[0].toUpperCase()),
                ),
                title: Text(user.nombre),
                subtitle: Text(user.email),
                onTap: () => showUserDetailSheet(
                  context,
                  user: user,
                  onEdit: () => _openForm(user),
                  onDelete: () => _confirmDelete(user),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        tooltip: 'Agregar empleado',
        child: const Icon(Icons.add),
      ),
    );
  }
}
