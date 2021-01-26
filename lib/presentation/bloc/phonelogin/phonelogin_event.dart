part of 'phonelogin_bloc.dart';

abstract class PhoneloginEvent extends Equatable {
  const PhoneloginEvent();

  @override
  List<Object> get props => [];
}

// Triggered when user clicks the login buttom in Splash
// Should move to phone number form screen
class LoginStartEvent extends PhoneloginEvent {}

// Triggered when user type phone number and press Avançar
class SendOtpEvent extends PhoneloginEvent {
  final String phoNo;

  SendOtpEvent({@required this.phoNo});
}

class OtpSendEvent extends PhoneloginEvent {}

// Triggered when user type SMS received in order to match and verify
class VerifyOtpEvent extends PhoneloginEvent {
  // final String otp;

  // VerifyOtpEvent({this.otp});

}

class LoginCompleteEvent extends PhoneloginEvent {
  // final FirebaseUser firebaseUser;
  // LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends PhoneloginEvent {
  final String message;

  LoginExceptionEvent(this.message);
}

class LogoutEvent extends PhoneloginEvent {}
