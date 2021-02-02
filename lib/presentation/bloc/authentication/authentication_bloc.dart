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
        super(Uninitialized()) {
    _userSubscription = authRepository.state.listen(
      (user) => add(ListeningToUserAuthChanges(user)),
    );
  }

  AuthenticationState get initialState => Uninitialized();
  StreamSubscription<AppUser> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is ListeningToUserAuthChanges) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is Logout) {
      await authRepository.logout();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    ListeningToUserAuthChanges event,
  ) {
    // print((event.user) == null ? 'AppUser is null' : event.user.props);
    return event.user != null ? Authenticated() : Unauthenticated();
  }
}
// if (event is AppStarted) {
// authRepository.state.listen((user) {
//   _user = user;
//   print('User dentro do Authbloc: $user');
// });

//   _user = authRepository.user;
//   if (_user != null) {
//     yield Authenticated();
//   } else {
//     yield Unauthenticated();
//   }
// }

// if (event is Login) {
//   yield Loading();
//   yield Authenticated();
// }

// if (event is Logout) {
//   yield Loading();
//   yield Unauthenticated();
// }
// }
