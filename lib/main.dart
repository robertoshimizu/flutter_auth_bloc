import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'data/repository/repositories.dart';
import 'domain/repository/repositories.dart';
import 'locator.dart';
import 'presentation/bloc/bloc.dart';
import 'presentation/pages/pages.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  Bloc.observer = SimpleBlocObserver();

  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: locator<DataAuthRepository>().user,
          ),
          ChangeNotifierProvider(
            create: (_) => locator<DataUserRepository>(),
          ),
          ChangeNotifierProvider(
            create: (_) => locator<DataAllRequests>(),
          ),
          ChangeNotifierProvider(
            create: (_) => locator<MyContactSelection>(),
          ),
        ],
        child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
                authRepository: locator<DataAuthRepository>())
              ..add(AppStarted());
          },
          child: MyApp(),
        ),
      ),
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
          print('Authbloc state: $state');

          if (state is Uninitialized) {
            return Splash();
          } else if (state is Authenticated) {
            // print(state.getUser().props);
            return HomePage();
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
    print('bloc event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('bloc transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('bloc error: $error');
    super.onError(cubit, error, stackTrace);
  }
}
