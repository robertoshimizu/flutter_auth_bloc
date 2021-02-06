import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';

abstract class AllRequests extends ChangeNotifier {
  Future<List<NeedRequest>> fetchRequests();

  Stream<QuerySnapshot> fetchRequestsAsStream();

  Future addRequest(NeedRequest data);
}
