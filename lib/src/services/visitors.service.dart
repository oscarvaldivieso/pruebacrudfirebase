import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createVisitor(visitorData) async {
  try {
    // Add the visitor data to Firestore
    await FirebaseFirestore.instance.collection('visitantes').add(visitorData);
  } catch (e) {
    print('Error creating visitor: $e');
  }
}

Future<List<Map<String, dynamic>>> fetchVisitors() async {
  CollectionReference visitors = FirebaseFirestore.instance.collection('visitantes');
  QuerySnapshot querySnapshot = await visitors.get();
  return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}

Future<void> deleteVisitor(dynamic visitor) async {
  try {
    // Assuming you have a Firestore collection named 'visitors'
    await FirebaseFirestore.instance
        .collection('visitors')
        .doc(visitor['id']) // Assuming 'id' is the unique identifier
        .delete();
  } catch (e) {
    // Handle any errors (e.g., network issues)
    print("Error deleting visitor: $e");
  }
}
