import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para agregar un visitante
  Future<void> addVisitor(Map<String, dynamic> visitorData) async {
    await _db.collection('VISITANTE').add(visitorData);
  }

  // Método para obtener los visitantes
  Stream<QuerySnapshot> getVisitors() {
    return _db.collection('VISITANTE').snapshots();
  }

  // Método para actualizar un visitante
  Future<void> updateVisitor(String visitorId, Map<String, dynamic> visitorData) async {
    await _db.collection('VISITANTE').doc(visitorId).update(visitorData);
  }

  // Método para eliminar un visitante
  Future<void> deleteVisitor(String visitorId) async {
    await _db.collection('VISITANTE').doc(visitorId).delete();
  }
}
