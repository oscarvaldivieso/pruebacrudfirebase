import 'package:flutter/material.dart';
import 'package:crudfirebaseprueba/src/screens/detalle.dart';
import 'package:crudfirebaseprueba/src/screens/form.dart';
import 'package:crudfirebaseprueba/src/services/visitors.service.dart';
import 'package:intl/intl.dart';

class SampleItemListView extends StatefulWidget {
  final List<Map<String, dynamic>> transports;

  const SampleItemListView({super.key, required this.transports});

  static const routeName = '/';

  @override
  _SampleItemListViewState createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  // The list of visitors should be managed here
  late List<Map<String, dynamic>> visitors = [];

  Future<void> _confirmDelete(BuildContext context, int index, dynamic visitor) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Está seguro de querer eliminar este visitante?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // User canceled
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // User confirmed
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
    if (confirm == true) {
      await deleteVisitor(visitor); // Delete visitor from the source
      setState(() {
        visitors.removeAt(index); // Remove from list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Visitantes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(  // Fetch visitors data
        future: fetchVisitors(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No visitors found.'));
          }

          // Initialize the visitors list with data from snapshot
          visitors = snapshot.data!;

          return ListView.builder(
            itemCount: visitors.length,
            itemBuilder: (context, index) {
              final visitor = visitors[index];
              return Container(
                color: index.isEven ? const Color.fromARGB(255, 5, 34, 57) : Colors.green[100], // Set different colors for alternating rows
                child: ListTile(
                  title: Text(visitor['nombre']),
                  subtitle: Text(
                    'Entrada: ${DateFormat('yyyy-MM-dd HH:mm').format(visitor['horaEntrada'].toDate())}\n'
                    'Salida: ${DateFormat('yyyy-MM-dd HH:mm').format(visitor['horaSalida'].toDate())}',
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert), // Ellipsis icon
                    onSelected: (String value) async {
                      if (value == 'Detalle') {
                        // Navigate to the 'Detalle' screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleScreen(visitor: visitor), // Pass the visitor data to the next screen
                          ),
                        );
                      } else if (value == 'Eliminar') {
                        // Perform the delete operation
                        await _confirmDelete(context, index, visitor); // Call delete method with confirmation
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'Detalle',
                          child: Text('Detalle'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Eliminar',
                          child: Text('Eliminar'),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the CreateVisitorScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateVisitorScreen(transports: widget.transports, visitors: visitors,)),
          );
        }, // The "+" icon
        tooltip: 'Crear Visitante',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

