import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Authentication Bloc Test', () {
    AuthenticationBloc authbloc;

    setUp(() {
      authbloc = AuthenticationBloc();
    });

    tearDown(() {
      authbloc.close();
    });

    test('initial state is AuthenticationInitial', () {
      expect(authbloc.state, AuthenticationInitial());
    });

    blocTest(
      'emits [AuthenticationStarted] when CounterEvent.increment is added',
      build: () => authbloc,
      act: (bloc) {
        final bool hasToken = false;
        bloc.add(AuthenticationStarted);
      },
      expect: [1],
    );
  });
}
