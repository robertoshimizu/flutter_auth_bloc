import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/adapters/adapters.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

class DataAllRequests with ChangeNotifier implements AllRequests {
  FirestoreService _api = FirestoreService('needRequest');

  List<NeedRequest> requests;

  Future<List<NeedRequest>> fetchRequests() async {
    var result = await _api.getDataCollection();
    requests = result.docs
        .map((doc) => NeedRequest.fromMap(doc.data(), doc.id))
        .toList();
    return requests;
  }

  Stream<List<NeedRequest>> fetchRequestsAsStream() {
    var stream = _api.streamDataCollection();
    var result = stream.map((event) => event.docs
        .map((doc) => NeedRequest.fromMap(
              doc.data(),
              doc.id,
            ))
        .toList());
    return result;
  }

  Future addRequest(NeedRequest data) async {
    await _api.addDocument(data.toMap());
    return;
  }

  @override
  void deleteRequest(String requestId) async {
    await _api.removeDocument(requestId);
  }

  @override
  Future updateRequest(NeedRequest data) async {
    await _api.updateDocument(data.toMap(), data.requestId);
    return;
  }
}
