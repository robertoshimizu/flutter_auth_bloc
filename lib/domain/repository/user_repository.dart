import 'package:flutter/foundation.dart';

abstract class UserRepository {
  Future<String> authenticate(
      {@required String email, @required String password});

  Future<void> deleteToken();

  Future<void> persistToken({@required String token});

  Future<bool> hasToken();
}
