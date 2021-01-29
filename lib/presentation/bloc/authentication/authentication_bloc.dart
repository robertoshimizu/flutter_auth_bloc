import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_auth_bloc/domain/entities/user.dart';

import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(Uninitialized());

  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final AppUser user = authRepository.user;
      print('User: $user');

      if (user != null) {
        yield Authenticated();
      } else {
        yield Uninitialized();
      }
    }

    if (event is Login) {
      yield Loading();
      yield Unauthenticated();
    }

    if (event is Logout) {
      yield Loading();
      yield Unauthenticated();
    }
  }
}
