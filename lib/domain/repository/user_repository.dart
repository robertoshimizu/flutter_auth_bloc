import 'package:flutter_auth_bloc/domain/entities/entities.dart';

abstract class UserRepository {
  Future<List<UserData>> fetchUsers();
  Future<Map<dynamic, dynamic>> getUserById(String id);
  Future updateUserData(UserData data, String id);
  Future<void> createUser(Map<String, dynamic> values);
}
