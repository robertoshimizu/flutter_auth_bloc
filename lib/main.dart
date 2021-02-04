import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/repositories.dart';
import 'domain/repository/auth_repository.dart';
import 'locator.dart';
import 'presentation/bloc/bloc.dart';
import 'presentation/pages/pages.dart';
import 'presentation/pages/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  Bloc.observer = SimpleBlocObserver();
  AuthRepository authRepository;
  // Needs to inject Auth Repository Implementation
  authRepository = locator<FirebaseService>();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(authRepository: authRepository)
          ..add(AppStarted());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EuIndico.app',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routeer.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // print('State at Main is $state');

          if (state is Uninitialized) {
            return Splash();
          } else if (state is Authenticated) {
            // print(state.getUser().props);
            return HomePage(state.getUser());
          } else if (state is Unauthenticated) {
            return PhoneLoginWrapper();
          } else {
            return Splash();
          }
        },
      ),
    );
  }
}

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
