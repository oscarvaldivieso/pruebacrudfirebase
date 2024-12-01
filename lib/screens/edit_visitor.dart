import 'package:flutter/material.dart';

class EditVisitorScreen extends StatelessWidget {
  final String visitorId;

  const EditVisitorScreen({Key? key, required this.visitorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Visitante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: 'Nombre inicial',
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: visitorId,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Motivo inicial',
              decoration: const InputDecoration(labelText: 'Motivo de Visita'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción en el futuro
              },
              child: const Text('Actualizar Visitante'),
            ),
          ],
        ),
      ),
    );
  }
}
