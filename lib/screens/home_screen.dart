import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Visitantes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/create'),
              child: const Text('Crear Visitante'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/list'),
              child: const Text('Listar Visitantes'),
            ),
          ],
        ),
      ),
    );
  }
}
