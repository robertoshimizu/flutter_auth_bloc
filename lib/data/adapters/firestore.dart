import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_bloc/data/external_apis/firestore_instance.dart';

import '../../locator.dart';

class FirestoreService {
  final String path;
  CollectionReference collectionReference;

  FirestoreService(this.path) {
    collectionReference =
        locator<FirestoreInstance>().instatiate().collection(path);
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

  Future<void> createFirestoreUser(Map data, String id) {
    return collectionReference.doc(id).set(data);
  }
}
