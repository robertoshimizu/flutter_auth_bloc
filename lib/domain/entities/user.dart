import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String mobilePhone;

  const AppUser({
    this.uid,
    this.mobilePhone,
  });

  @override
  List<Object> get props => [uid, mobilePhone];

  static const empty = AppUser(uid: '', mobilePhone: '');
}
