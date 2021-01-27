import 'package:flutter/material.dart';

abstract class AuthRepository {
  final HttpClient httpClient;
  final String url;

  // Login

  AuthRepository({@required this.httpClient, @required this.url});

  Future<bool> sendOtp({@required String phoNo});

  Future<void> verifyOtp({@required String verificationCode});

  Future<String> authenticateUser();

  // Auth

  Future<String> authenticate(
      {@required String email, @required String password});

  Future<void> deleteToken();

  Future<void> persistToken({@required String token});

  Future<bool> hasToken();
}

class HttpClient {}
