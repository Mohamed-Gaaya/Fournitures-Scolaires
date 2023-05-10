import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:firebase_core/firebase_core.dart';

Future<DocumentReference<Map<String, dynamic>>> insert(User user) async {
  await Firebase.initializeApp();
  final db = FirebaseFirestore.instance;
  return await db.collection('users').add(user.toMap());
}

Future<List<User>> queryAllUsers() async {
  await Firebase.initializeApp();
  List<User> users = [];
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  snapshot.docs.forEach((doc) {
    users.add(User.fromMap(doc as Map<String, dynamic>));
  });

  return users;
}

Future<void> deleteAllDocuments() async {
  await Firebase.initializeApp();
  final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();
  final List<DocumentSnapshot> documents = snapshot.docs;

  for (DocumentSnapshot document in documents) {
    await document.reference.delete();
  }
}
