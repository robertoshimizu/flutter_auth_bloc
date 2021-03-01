import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';

class IndicationRepository extends ChangeNotifier {
  final String requestId;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference _api;
  List<Indication> indications;

  IndicationRepository(this.requestId) {
    _api = instance
        .collection('needRequest')
        .doc(requestId)
        .collection('indications');
  }

  Future<String> addIndication(Map data) async {
    var result = await _api.add(data);
    return result.id;
  }

  Stream<QuerySnapshot> fetchIndicationAsStream() {
    return _api.snapshots();
  }

  Future<List<Indication>> fetchIndications() async {
    var result = await _api.get();
    indications = result.docs
        .map((doc) => Indication.fromMap(doc.data(), doc.id))
        .toList();
    return indications;
  }
}
