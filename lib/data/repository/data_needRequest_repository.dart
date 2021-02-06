import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/adapters/adapters.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

class DataAllRequests with ChangeNotifier implements AllRequests {
  FirebaseService _api = FirebaseService('needRequest');

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
