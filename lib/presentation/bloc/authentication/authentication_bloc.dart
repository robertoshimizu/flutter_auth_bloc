import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(AuthenticationInitial());

  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield AuthenticationInProgress();
      var user = authRepository.user;
      print('User loggedIn: $user');
      if (user == null) {
        yield AuthenticationFailure();
      } else {
        yield AuthenticationSucess();
      }
    }

    if (event is AuthenticationLoggedIn) {
      try {
        yield AuthenticationSucess();
      } catch (e) {
        print(e);
        yield AuthenticationFailure();
      }

      // await userRepository.persistToken(token: event.token);
      // if return from repository fails, throw error and return to login page

    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await authRepository.logout();
      yield AuthenticationInitial();
    }
  }
}
