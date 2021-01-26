import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';

import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('A - Auth Repository is instantiated', () {
    // tearDown(() {
    //   authbloc.close();
    // });

    test('1 - throws when authRepository is null', () {
      expect(
        () => PhoneloginBloc(
          authRepository: null,
        ),
        throwsAssertionError,
      );
    });
  });
  group('B - Phone login Bloc Test', () {
    PhoneloginBloc phoneLoginbloc;
    AuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      phoneLoginbloc = PhoneloginBloc(authRepository: authRepository);
    });

    tearDown(() {
      phoneLoginbloc.close();
    });

    test('1 - initial state is AuthenticationInitial', () {
      expect(phoneLoginbloc.state, AuthenticationInitial());
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      '2 - emits [AuthenticationFailure] when AuthenticationStarted hasToken is false',
      build: () {
        when(authRepository.sendOtp(phoNo: 'validphonenumber'))
            .thenAnswer((_) async => false);
        return phoneLoginbloc;
      },
      act: (bloc) {
        bloc.add(SendOtpEvent());
      },
      expect: [AuthenticationFailure()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      '3 - emits [AuthenticationSucess] when AuthenticationStarted hasToken is true',
      build: () {
        when(authRepository.hasToken()).thenAnswer((_) async => true);
        return phoneLoginbloc;
      },
      act: (bloc) {
        bloc.add(AuthenticationStarted());
      },
      expect: [AuthenticationSucess()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      '4 - emits [AuthenticationSucess] when Repository confirms token',
      build: () {
        when(authRepository.persistToken(token: 'any')).thenAnswer((_) => null);
        return phoneLoginbloc;
      },
      act: (bloc) {
        bloc.add(AuthenticationLoggedIn(token: 'any'));
      },
      expect: [AuthenticationInProgress(), AuthenticationSucess()],
    );
    blocTest<AuthenticationBloc, AuthenticationState>(
      '5 - emits [AuthenticationFailure] when Repository rejects token',
      build: () {
        when(authRepository.persistToken(token: 'any'))
            .thenThrow(Exception('token invalid'));
        return phoneLoginbloc;
      },
      act: (bloc) {
        bloc.add(AuthenticationLoggedIn(token: 'any'));
      },
      expect: [AuthenticationInProgress(), AuthenticationFailure()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      '6 - emits [AuthenticationLoggedOut] when Repository logs user out',
      build: () => phoneLoginbloc,
      act: (bloc) {
        bloc.add(AuthenticationLoggedOut());
      },
      expect: [AuthenticationInProgress(), AuthenticationInitial()],
    );
  });
}
