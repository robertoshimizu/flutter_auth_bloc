import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'phonelogin_event.dart';
part 'phonelogin_state.dart';

class PhoneloginBloc extends Bloc<PhoneloginEvent, PhoneloginState> {
  PhoneloginBloc() : super(PhoneloginInitial());

  @override
  Stream<PhoneloginState> mapEventToState(
    PhoneloginEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
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
