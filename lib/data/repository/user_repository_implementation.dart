import 'dart:async';

import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<void> persistToken({@required String token}) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
    return false;
  }
}
