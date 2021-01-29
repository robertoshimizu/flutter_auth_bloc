import 'dart:async';
import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';

part 'phonelogin_event.dart';
part 'phonelogin_state.dart';

class PhoneloginBloc extends Bloc<PhoneloginEvent, PhoneloginState> {
  final AuthRepository authRepository;
  PhoneloginBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(PhoneloginInitial());

  @override
  Stream<PhoneloginState> mapEventToState(
    PhoneloginEvent event,
  ) async* {
    if (Platform.isAndroid) {
      if (event is SendOtpEvent) {
        yield LoadingState();
        final String otp = await authRepository.verifyPhone(phoNo: event.phoNo);
        if (otp == null) {
          yield OtpExceptionState();
        } else {
          yield LoginCompleteState();
        }
      } else if (event is LogoutEvent) {
        yield PhoneloginInitial();
      }
    }
    if (Platform.isIOS) {
      if (event is SendOtpEvent) {
        yield LoadingState();
        final String otp = await authRepository.verifyPhone(phoNo: event.phoNo);
        if (otp == null) {
          yield OtpExceptionState();
        } else {
          yield OtpSentState();
        }
      } else if (event is VerifyOtpEvent) {
        final String uuid =
            await authRepository.authenticate(smsCode: event.otp);
        if (uuid == null) {
          yield ExceptionState();
        } else {
          print('Login Sucesful, uuid: $uuid');
          yield LoginCompleteState();
        }
      } else if (event is LogoutEvent) {
        yield PhoneloginInitial();
      }
      //   yield OtpVerifiedState();
      // } else if (event is LoginCompleteEvent) {
      //   yield LoginCompleteState();
      // } else if (event is LoginExceptionEvent) {
      //   yield ExceptionState();
      // } else if (event is LogoutEvent) {
      //   yield PhoneloginInitial();
    }
  }
}
