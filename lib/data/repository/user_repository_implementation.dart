import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/user_repository.dart';

class FirestoreService implements UserRepository {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Map> getUserById(String id) async {
    var doc = await _firestore.collection(collection).doc(id).get();
    if (!doc.exists) {
      return null;
    }
    return doc.data();
  }
}
