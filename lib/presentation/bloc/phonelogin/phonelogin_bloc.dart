import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repository/auth_repository.dart';

part 'phonelogin_event.dart';
part 'phonelogin_state.dart';

class PhoneloginBloc extends Bloc<PhoneloginEvent, PhoneloginState> {
  final AuthRepository authRepository;
  // ignore: cancel_subscriptions
  StreamSubscription subscription;
  String verID = "";

  PhoneloginBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(PhoneloginInitial());

  @override
  Stream<PhoneloginState> mapEventToState(
    PhoneloginEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();

      subscription =
          authRepository.verifyPhone(phoNo: event.phoNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.appUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        AppUser result = await authRepository.authenticate(smsCode: event.otp);
        if (result != null) {
          yield LoginCompleteState(result);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
    }
  }

  @override
  void onEvent(PhoneloginEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    print("Bloc closed");
    super.close();
  }
}
