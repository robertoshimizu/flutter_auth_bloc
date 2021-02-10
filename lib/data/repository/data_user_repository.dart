import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/adapters/adapters.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';

import '../../domain/repository/user_repository.dart';

class DataUserRepository with ChangeNotifier implements UserRepository {
  FirestoreService _api = FirestoreService('users');

  @override
  Future<Map> getUserById(String id) async {
    var doc = await _api.getDocumentById(id);
    if (!doc.exists) {
      return null;
    }
    return doc.data();
  }

  @override
  Future updateUserData(UserData data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future<void> createUser(Map<String, dynamic> values) async {
    String uid = values['uid'];
    await _api.createFirestoreUser(values, uid);
    return;
  }
}
