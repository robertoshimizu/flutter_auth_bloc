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

  Stream<QuerySnapshot> streamDataCollection(String param) {
    print(param);
    return collectionReference
        .where('destinationFriends', arrayContains: param)
        .snapshots();
  }

  Stream<QuerySnapshot> streamMyDataCollection(String param) {
    print(param);
    return collectionReference.where('userId', isEqualTo: param).snapshots();
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

  Future<void> addNewIndication(String id, String field, String elementId) {
    return collectionReference.doc(id).update({
      '$field': FieldValue.arrayUnion(['$elementId'])
    });
  }

  Future<void> updateDocumentField({String id, String key, dynamic value}) {
    var objek = {'$key': value};
    return collectionReference
        .doc(id)
        .update(objek)
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
