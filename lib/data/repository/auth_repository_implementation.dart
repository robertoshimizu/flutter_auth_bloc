import 'dart:async';

import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';

class AuthRepositoryImpl implements AuthRepository {
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

  @override
  Future<String> authenticateUser() {
    throw UnimplementedError();
  }

  @override
  get httpClient => throw UnimplementedError();

  @override
  Future<bool> sendOtp({String phoNo}) {
    throw UnimplementedError();
  }

  @override
  String get url => throw UnimplementedError();

  @override
  Future<void> verifyOtp({String verificationCode}) {
    throw UnimplementedError();
  }
}
