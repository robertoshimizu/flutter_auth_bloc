import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';

abstract class AllRequests extends ChangeNotifier {
  Future<List<NeedRequest>> fetchRequests();

  Stream<List<NeedRequest>> fetchRequestsAsStream();

  Future addRequest(NeedRequest data);

  void deleteRequest(String requestId);
}
