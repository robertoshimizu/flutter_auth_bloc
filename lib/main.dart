import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/repositories.dart';
import 'domain/repository/auth_repository.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  AuthRepository authRepository;
  // Needs to inject Auth Repository Implementation
  authRepository = FirebaseService();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(authRepository: authRepository)
          ..add(AppStarted());
      },
      child: MyApp(
        authRepository: authRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  MyApp({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print('State at Main is $state');

          if (state is Uninitialized) {
            return SplashPage();
          } else if (state is Authenticated) {
            return HomePage(
              authRepository: authRepository,
            );
          } else if (state is Unauthenticated) {
            return PhoneLoginWrapper(
              authRepository: authRepository,
            );
          } else {
            return SplashPage();
          }
        },
      ),
    );
  }
}
