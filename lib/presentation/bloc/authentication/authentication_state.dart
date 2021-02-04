part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final AppUser _user;

  Authenticated(this._user);

  AppUser getUser() {
    return _user;
  }

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthenticationState {}

class Loading extends AuthenticationState {}
