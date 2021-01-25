import 'package:flutter/foundation.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> authenticate(
      {@required String email, @required String password});

  Future<void> deleteToken();

  Future<void> persistToken({@required String token});

  Future<bool> hasToken();
}
