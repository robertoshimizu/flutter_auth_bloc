import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'dart:io' show Platform;

class FirebaseService implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String smsCode;
  String verificationId;
  int resendToken;

  Future<String> authenticate(String smsCode) async {
    this.smsCode = smsCode;
    print('Platform is Android: ${Platform.isAndroid}');

    if (Platform.isAndroid) {
      // Android-specific code

      PhoneAuthCredential phoneAuthCredential;
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    } else if (Platform.isIOS) {
      // iOS-specific code
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.verificationId,
        smsCode: this.smsCode,
      );
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    }

    // await Future.delayed(Duration(seconds: 2));

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
  Future<String> verifyPhone({String phoNo}) async {
    PhoneVerificationCompleted _verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      print(
          'Verification Complete, here the credential: {phoneAuthCredential.toString()}');
      return phoneAuthCredential.toString();
    };
    PhoneVerificationFailed _verificationFailed =
        (FirebaseAuthException exception) {
      print('Verification Failed: {exception.message}');
      return exception.message;
    };
    PhoneCodeSent _codeSent = (String verId, [int forceCodeResend]) {
      print('Code Sent: $verId');
      this.verificationId = verId;
      this.resendToken = forceCodeResend;
      return verId;
    };
    PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout = (String verId) {
      this.verificationId = verId;
      return verId;
    };

    if (Platform.isAndroid) {
      // Android-specific code
    } else if (Platform.isIOS) {
      // iOS-specific code
    }

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoNo,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
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
