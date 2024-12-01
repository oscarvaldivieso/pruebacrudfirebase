import 'package:flutter/material.dart';

class CreateVisitorScreen extends StatelessWidget {
  const CreateVisitorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Visitante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Motivo de Visita'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción en el futuro
              },
              child: const Text('Agregar Visitante'),
            ),
          ],
        ),
      ),
    );
  }
}
