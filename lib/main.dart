import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/repositories.dart';
import 'presentation/bloc/bloc.dart';
import 'presentation/pages/pages.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  UserRepository userRepository;
  // Needs to inject User Repository Implementation
  userRepository = UserRepositoryImpl();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print('State at Main is $state');
          if (state is AuthenticationInitial) {
            return SplashPage();
          }
          if (state is AuthenticationSucess) {
            return HomePage();
          }
          if (state is AuthenticationFailure) {
            return LoginPage();
          }
          if (state is AuthenticationInProgress) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}
