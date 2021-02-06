import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_bloc/data/external_apis/firebase_instance.dart';

import '../../locator.dart';

class FirebaseService {
  final String path;
  CollectionReference collectionReference;

  FirebaseService(this.path) {
    collectionReference =
        locator<FirebaseInstance>().instatiate().collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return collectionReference.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return collectionReference.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return collectionReference.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return collectionReference.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return collectionReference.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return collectionReference.doc(id).update(data);
  }
}
