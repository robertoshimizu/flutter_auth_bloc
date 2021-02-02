part of 'phonelogin_bloc.dart';

abstract class PhoneloginState extends Equatable {
  const PhoneloginState();

  @override
  List<Object> get props => [];
}

class PhoneloginInitial extends PhoneloginState {}

class OtpSentState extends PhoneloginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends PhoneloginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends PhoneloginState {
  @override
  List<Object> get props => [];
}

class LoginCompleteState extends PhoneloginState {
  final AppUser _user;

  LoginCompleteState(this._user);

  AppUser getUser() {
    return _user;
  }

  @override
  List<Object> get props => [];
  // List<Object> get props => [_firebaseUser];
}

class ExceptionState extends PhoneloginState {
  final String message;

  ExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends PhoneloginState {
  final String message;

  OtpExceptionState({this.message});

  @override
  List<Object> get props => [message];
}
