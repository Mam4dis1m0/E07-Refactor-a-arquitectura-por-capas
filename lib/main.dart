import 'package:flutter/material.dart';

import 'core/injection.dart';
import 'data/datasources/user_memory_datasource.dart';
import 'ui/user/list.dart';
import 'ui/user/user_controller.dart';

void main() {
  final controller = buildUserController(UserMemoryDataSource());
  runApp(ListasEmpleadosApp(controller: controller));
}

class ListasEmpleadosApp extends StatelessWidget {
  const ListasEmpleadosApp({super.key, required this.controller});

  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listas de empleados',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: UserListScreen(controller: controller),
    );
  }
}
