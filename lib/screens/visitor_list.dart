import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VisitorListScreen extends StatelessWidget {
  const VisitorListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista simulada de visitantes
    final visitors = [
      {'id': '1', 'name': 'Juan Pérez', 'reason': 'Reunión'},
      {'id': '2', 'name': 'María López', 'reason': 'Entrega de documentos'},
      {'id': '3', 'name': 'Carlos García', 'reason': 'Visita técnica'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Visitantes'),
      ),
      body: ListView.builder(
        itemCount: visitors.length,
        itemBuilder: (context, index) {
          final visitor = visitors[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(visitor['name'] ?? 'Sin nombre'),
              subtitle: Text('Motivo: ${visitor['reason']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      context.go('/edit/${visitor['id']}');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmation(context, visitor['id']);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String? visitorId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar este visitante? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Aquí se llamará al servicio para eliminar al visitante
                Navigator.of(context).pop(); // Cierra el diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Visitante eliminado (simulado)'),
                  ),
                );
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
