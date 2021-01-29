import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';

abstract class AuthRepository {
  final HttpClient httpClient;
  final String url;

  // Login

  AuthRepository({@required this.httpClient, @required this.url});

  Future<String> verifyPhone({@required String phoNo});

  Future<void> verifyOtp({@required String verificationCode});

  Future<String> authenticateUser();

  // Auth

  Future<String> authenticate({String smsCode});

  Future<void> logout();

  Future<void> persistToken({@required String token});

  Future<bool> hasToken();

  // ignore: missing_return
  Stream<AppUser> get user {}
}

class HttpClient {}
