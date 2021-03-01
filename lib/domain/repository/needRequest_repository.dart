import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';

abstract class AllRequests extends ChangeNotifier {
  Future<List<NeedRequest>> fetchRequests();

  Stream<List<NeedRequest>> fetchRequestsAsStream(String userId);

  Stream<List<NeedRequest>> fetchMyRequestsAsStream(String userId);

  Future addRequest(NeedRequest data);

  Future updateRequest(NeedRequest data);

  void deleteRequest(String requestId);

  Future addIndication(String requestId, String indicationId);
}
