import 'dart:async';

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
    if (event is SendOtpEvent) {
      yield LoadingState();
      final bool otp = await authRepository.sendOtp(phoNo: 'validphonenumber');

      if (otp == null) {
        yield OtpExceptionState();
      }
      if (otp) {
        yield OtpSentState();
      } else {
        yield OtpExceptionState();
      }
    } else if (event is VerifyOtpEvent) {
      yield OtpVerifiedState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState();
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState();
    } else if (event is LogoutEvent) {
      yield PhoneloginInitial();
    }
  }
}
