import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';
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

    await _firebaseAuth.signInWithCredential(phoneAuthCredential);

    // await Future.delayed(Duration(seconds: 2));

    return '';
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
        (AuthCredential phoneAuthCredential) async {
      print(
          'Verification Complete, here the credential: {phoneAuthCredential.toString()}');
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      return phoneAuthCredential.toString();
    };
    PhoneVerificationFailed _verificationFailed =
        (FirebaseAuthException exception) {
      print('Verification Failed: {exception.message}');
      return exception.message;
    };
    PhoneCodeSent _codeSent = (String verId, [int forceCodeResend]) {
      print('Otp Sent to phone - please verify');
      this.verificationId = verId;
      this.resendToken = forceCodeResend;
      return verId;
    };
    PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout = (String verId) {
      this.verificationId = verId;
      return verId;
    };

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

  AppUser _userFromFirebaseUSer(User user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            mobilePhone: user.phoneNumber,
          )
        : null;
  }

  // @override
  // Stream<AppUser> get user {
  //   _firebaseAuth.authStateChanges().map((User user) {
  //     return _userFromFirebaseUSer(user) == null
  //         ? AppUser.empty
  //         : _userFromFirebaseUSer(user);
  //   });
  //   return null;
  // }
  @override
  AppUser get user {
    return _userFromFirebaseUSer(_firebaseAuth.currentUser) == null
        ? null
        : _userFromFirebaseUSer(_firebaseAuth.currentUser);
  }
}
