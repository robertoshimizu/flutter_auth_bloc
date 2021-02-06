import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/external_apis/firebase_auth_instance.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../locator.dart';
import '../../presentation/bloc/bloc.dart';

class DataAuthRepository with ChangeNotifier implements AuthRepository {
  final FirebaseAuth _firebaseAuth =
      locator<FirebaseAuthInstance>().instatiate();
  String smsCode;
  String verificationId;
  int resendToken;

  Future<AppUser> authenticate({@required String smsCode}) async {
    this.smsCode = smsCode;

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: this.verificationId,
      smsCode: this.smsCode,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);

    // await Future.delayed(Duration(seconds: 2));
    return _userFromFirebaseUSer(userCredential.user);
  }

  Future<void> logout() async {
    /// delete from keystore/keychain
    await _firebaseAuth.signOut();
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
  Stream<PhoneloginEvent> verifyPhone({String phoNo}) async* {
    StreamController<PhoneloginEvent> eventStream = StreamController();

    final PhoneVerificationCompleted _verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      try {
        var user = _userFromFirebaseUSer(_firebaseAuth.currentUser);
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      } on Exception {
        print('Error on phoneverificationcompleted');
      }
    };
    final PhoneVerificationFailed _verificationFailed =
        (FirebaseAuthException exception) {
      print('Verification Failed: {exception.message}');

      eventStream.add(LoginExceptionEvent(exception.message));
      eventStream.close();
    };
    final PhoneCodeSent _codeSent = (String verId, [int forceCodeResend]) {
      print('Otp Sent to phone - please verify');
      this.verificationId = verId;
      this.resendToken = forceCodeResend;
      eventStream.add(OtpSendEvent());
    };
    final PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout =
        (String verId) {
      this.verificationId = verId;
      eventStream.close();
    };

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoNo,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
    yield* eventStream.stream;
  }

  @override
  Future<void> verifyOtp({String verificationCode}) {
    throw UnimplementedError();
  }

  AppUser _userFromFirebaseUSer(User user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            mobilePhone: user.phoneNumber,
          )
        : null;
  }

  @override
  Stream<AppUser> get state {
    return _firebaseAuth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUSer(user));
  }

  @override
  AppUser get user => _userFromFirebaseUSer(_firebaseAuth.currentUser);
}
