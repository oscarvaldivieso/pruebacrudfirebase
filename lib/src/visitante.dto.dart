import 'package:cloud_firestore/cloud_firestore.dart';

enum Transporte { carro, moto, bicicleta, aPie }

class Visitor {
  final String id;
  final String nombre;
  final String identificacion;
  final String motivo;
  final String huesped;
  final DateTime horaEntrada;
  final DateTime horaSalida;
  final Transporte transporte;
  final List<String> acompanantes; // IDs of other visitors
  final String fotoPlaca; // URL to the image of the license plate

  Visitor({
    required this.id,
    required this.nombre,
    required this.identificacion,
    required this.motivo,
    required this.huesped,
    required this.horaEntrada,
    required this.horaSalida,
    required this.transporte,
    required this.acompanantes,
    required this.fotoPlaca,
  });

  // Convert from a Firestore document to a Visitor object
  factory Visitor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Visitor(
      id: doc.id,
      nombre: data['nombre'],
      identificacion: data['identificacion'],
      motivo: data['motivo'],
      huesped: data['huesped'],
      horaEntrada: (data['horaEntrada'] as Timestamp).toDate(),
      horaSalida: (data['horaSalida'] as Timestamp).toDate(),
      transporte: Transporte.values[data['transporte']],
      acompanantes: List<String>.from(data['acompanantes']),
      fotoPlaca: data['fotoPlaca'],
    );
  }

  // Convert a Visitor object to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'identificacion': identificacion,
      'motivo': motivo,
      'huesped': huesped,
      'horaEntrada': horaEntrada,
      'horaSalida': horaSalida,
      'transporte': transporte.index,
      'acompanantes': acompanantes,
      'fotoPlaca': fotoPlaca,
    };
  }
}