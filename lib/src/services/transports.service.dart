import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchTransports() async {
  CollectionReference transportes = FirebaseFirestore.instance.collection('transportes');
  QuerySnapshot querySnapshot = await transportes.get();
  return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}
