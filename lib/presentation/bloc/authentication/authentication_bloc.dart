import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // final UserRepository userRepository;

  AuthenticationBloc() : super(AuthenticationInitial());

  AuthenticationState get initialState => AuthenticationInitial();
  UserRepository userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      // final bool hasToken = await userRepository.hasToken();
      final bool hasToken = false;

      if (hasToken) {
        yield AuthenticationSucess();
      } else {
        yield AuthenticationFailure();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      // await userRepository.persistToken(token: event.token);
      yield AuthenticationSucess();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      // await userRepository.deleteToken();
      yield AuthenticationFailure();
    }
  }
}
