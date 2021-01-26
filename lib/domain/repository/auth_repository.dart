import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<void> sendOtp({@required String phoNo});

  Future<void> verifyOtp({@required String verificationCode});

  Future<String> authenticateUser();
}
