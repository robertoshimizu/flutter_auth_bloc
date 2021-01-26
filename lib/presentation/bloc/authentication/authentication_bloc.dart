import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationInitial());

  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield AuthenticationInProgress();
      final bool hasToken = await userRepository.hasToken();

      if (hasToken == null) {
        yield AuthenticationFailure();
      }
      if (hasToken) {
        yield AuthenticationSucess();
      } else {
        yield AuthenticationFailure();
      }
    }

    if (event is AuthenticationLoggedIn) {
      try {
        await userRepository.persistToken(token: event.token);
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
      await userRepository.deleteToken();
      yield AuthenticationInitial();
    }
  }
}
