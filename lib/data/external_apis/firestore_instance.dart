import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstance {
  FirebaseFirestore instatiate() {
    return FirebaseFirestore.instance;
  }
}
