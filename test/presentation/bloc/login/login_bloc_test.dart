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

    test('1 - initial state is PhoneloginInitial', () {
      expect(phoneLoginbloc.state, PhoneloginInitial());
    });

    // blocTest<PhoneloginBloc, PhoneloginState>(
    //   '2 - emits [OtpSendEvent()] when AuthServer sends a SMS',
    //   build: () {
    //     when(authRepository.sendOtp(phoNo: 'validphonenumber'))
    //         .thenAnswer((_) async => true);
    //     return phoneLoginbloc;
    //   },
    //   act: (bloc) {
    //     bloc.add(SendOtpEvent(
    //         phoNo: 'validphonenumber')); // this event is a http request
    //     bloc.add(OtpSendEvent()); //This event should be from a http response
    //   },
    //   expect: [LoadingState(), OtpSentState()],
    // );

    blocTest<PhoneloginBloc, PhoneloginState>(
      '2 - emits [OtpSendEvent()] when AuthServer sends a SMS',
      build: () {
        String smsCode = 'xxxx';
        when(authRepository.sendOtp(phoNo: 'validphonenumber')).thenAnswer(
          (_) => Future.value(smsCode),
        );
        return phoneLoginbloc;
      },
      act: (bloc) {
        bloc.add(SendOtpEvent(phoNo: 'validphonenumber'));
      },
      expect: [LoadingState(), OtpSentState()],
    );

    blocTest<PhoneloginBloc, PhoneloginState>(
      '3 - emits [OtpExceptionState()] when AuthServer fails to send SMS',
      build: () {
        when(authRepository.sendOtp(phoNo: 'validphonenumber')).thenThrow(
          Exception('Unable to send SMS or phone invalid'),
        );
        return phoneLoginbloc;
      },
      act: (bloc) {
        bloc.add(SendOtpEvent(phoNo: 'validphonenumber'));
      },
      expect: [LoadingState(), OtpExceptionState()],
    );

    // blocTest<AuthenticationBloc, AuthenticationState>(
    //   '4 - emits [AuthenticationSucess] when Repository confirms token',
    //   build: () {
    //     when(authRepository.persistToken(token: 'any')).thenAnswer((_) => null);
    //     return phoneLoginbloc;
    //   },
    //   act: (bloc) {
    //     bloc.add(AuthenticationLoggedIn(token: 'any'));
    //   },
    //   expect: [AuthenticationInProgress(), AuthenticationSucess()],
    // );
    // blocTest<AuthenticationBloc, AuthenticationState>(
    //   '5 - emits [AuthenticationFailure] when Repository rejects token',
    //   build: () {
    //     when(authRepository.persistToken(token: 'any'))
    //         .thenThrow(Exception('token invalid'));
    //     return phoneLoginbloc;
    //   },
    //   act: (bloc) {
    //     bloc.add(AuthenticationLoggedIn(token: 'any'));
    //   },
    //   expect: [AuthenticationInProgress(), AuthenticationFailure()],
    // );

    // blocTest<AuthenticationBloc, AuthenticationState>(
    //   '6 - emits [AuthenticationLoggedOut] when Repository logs user out',
    //   build: () => phoneLoginbloc,
    //   act: (bloc) {
    //     bloc.add(AuthenticationLoggedOut());
    //   },
    //   expect: [AuthenticationInProgress(), AuthenticationInitial()],
    // );
  });
}
