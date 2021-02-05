import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';

class AllRequests extends ChangeNotifier {
  DatabaseService _api = DatabaseService('needRequest');

  List<NeedRequest> requests;

  Future<List<NeedRequest>> fetchRequests() async {
    var result = await _api.getDataCollection();
    requests = result.docs
        .map((doc) => NeedRequest.fromMap(doc.data(), doc.id))
        .toList();
    return requests;
  }

  Stream<QuerySnapshot> fetchRequestsAsStream() {
    return _api.streamDataCollection();
  }

  Future addRequest(NeedRequest data) async {
    await _api.addDocument(data.toMap());
    return;
  }
}

class DatabaseService {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  final String path;
  CollectionReference collectionReference;

  DatabaseService(this.path) {
    collectionReference = instance.collection(path);
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
