import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInstance {
  FirebaseFirestore instatiate() {
    return FirebaseFirestore.instance;
  }
}
