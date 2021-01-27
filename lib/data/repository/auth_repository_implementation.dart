import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';

class FirebaseService implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String smsCode;
  String verificationId;
  int resendToken;

  Future<String> authenticate({@required String smsCode}) async {
    this.smsCode = smsCode;
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: this.verificationId,
      smsCode: this.smsCode,
    );
    // await Future.delayed(Duration(seconds: 2));
    await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    return 'token';
  }

  Future<void> logout() async {
    /// delete from keystore/keychain
    await _firebaseAuth.signOut();
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
  Future<String> sendOtp({String phoNo}) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoNo,
      verificationCompleted: (AuthCredential phoneAuthCredential) {
        print(
            'Verification Complete, here the credential: {phoneAuthCredential.toString()}');
        return phoneAuthCredential.toString();
      },
      verificationFailed: (FirebaseAuthException exception) {
        print('Verification Failed: {exception.message}');
        return exception.message;
      },
      codeSent: (String verId, [int forceCodeResend]) {
        print('Code Sent: $verId');
        this.verificationId = verId;
        this.resendToken = forceCodeResend;
        return verId;
      },
      codeAutoRetrievalTimeout: (String verId) {
        this.verificationId = verId;
        return verId;
      },
    );
    return 'SendOtp failed';
  }

  @override
  String get url => throw UnimplementedError();

  @override
  Future<void> verifyOtp({String verificationCode}) {
    throw UnimplementedError();
  }
}
