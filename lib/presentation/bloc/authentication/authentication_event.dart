part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String token;

  AuthenticationLoggedIn({@required this.token});
// Note: the meta package is used to annotate the AuthenticationEvent parameters
// as @required. This will cause the dart analyzer to warn developers if they
// don't provide the required parameters.

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthenticationLoggedIn { token: $token }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
