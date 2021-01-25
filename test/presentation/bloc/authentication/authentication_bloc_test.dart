import 'package:flutter_auth_bloc/domain/repository/user_repository.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('Authentication Bloc Test', () {
    AuthenticationBloc authbloc;
    UserRepository userRepository;

    setUp(() {
      authbloc = AuthenticationBloc();
      userRepository = MockUserRepository();
    });

    tearDown(() {
      authbloc.close();
    });

    test('initial state is AuthenticationInitial', () {
      expect(authbloc.state, AuthenticationInitial());
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationFailure] when AuthenticationStarted hasToken is null',
      build: () {
        when(userRepository.hasToken()).thenAnswer((_) async => false);
        return authbloc;
      },
      act: (bloc) {
        bloc.add(AuthenticationStarted());
      },
      expect: [AuthenticationFailure()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationSucess] when AuthenticationStarted hasToken is true',
      build: () {
        when(userRepository.hasToken()).thenAnswer((_) async => true);
        return authbloc;
      },
      act: (bloc) {
        bloc.add(AuthenticationStarted());
      },
      expect: [AuthenticationFailure()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationSucess] when Repository confirms token',
      build: () => authbloc,
      act: (bloc) {
        String token;
        token = 'any';
        bloc.add(AuthenticationLoggedIn(token: token));
      },
      expect: [AuthenticationInProgress(), AuthenticationSucess()],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationFailure] when Repository rejects token',
      build: () => authbloc,
      act: (bloc) {
        String token;
        token = 'any';
        bloc.add(AuthenticationLoggedIn(token: token));
      },
      expect: [AuthenticationInProgress(), AuthenticationFailure()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoggedOut] when Repository logs user out',
      build: () => authbloc,
      act: (bloc) {
        String token;
        token = 'any';
        bloc.add(AuthenticationLoggedOut());
      },
      expect: [AuthenticationInitial()],
    );
  });
}
