import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalleScreen extends StatelessWidget {
  final dynamic visitor; // The visitor data passed from the previous screen

  const DetalleScreen({Key? key, required this.visitor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Formatting timestamps
    String formatTimestamp(Timestamp timestamp) {
      return DateFormat('yyyy-MM-dd HH:mm').format(timestamp.toDate());
    }

    // Conditionally display the list of acompañantes (accompanying persons)
    List<Widget> buildAcompanantes() {
      if (visitor['acompanantes'] != null && visitor['acompanantes'].isNotEmpty) {
        List<Widget> companionsList = [];
        visitor['acompanantes'].forEach((companion) {
          companionsList.add(Text(companion));
        });
        return companionsList;
      } else {
        return [Text("No tiene acompañantes registrados.")];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Visita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Added for scrolling content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Visitor Name
              Text(
                'Nombre: ${visitor['nombre']}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),

              // Visitor Motive
              Text(
                'Motivo: ${visitor['motivo'] ?? 'No especificado'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8),

              // Huesped (Guest)
              Text(
                'Huésped: ${visitor['huesped']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8),

              // Entry and Exit Time
              Text(
                'Entrada: ${formatTimestamp(visitor['horaEntrada'])}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8),
              Text(
                'Salida: ${formatTimestamp(visitor['horaSalida'])}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),

              // Acompañantes (Accompanying persons)
              Text(
                'Acompañantes:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...buildAcompanantes(),  // Display the list of companions
              SizedBox(height: 16),

              // Additional information like Photo plate or Identification
              if (visitor['fotoPlaca']?.isNotEmpty ?? false) 
                Text('Foto Placa: ${visitor['fotoPlaca']}'),
              if (visitor['identificacion']?.isNotEmpty ?? false)
                Text('Identificación: ${visitor['identificacion']}'),
              if (visitor['transporte'] != null)
                Text('Transporte: ${visitor['transporte']}'),
            ],
          ),
        ),
      ),
    );
  }
}