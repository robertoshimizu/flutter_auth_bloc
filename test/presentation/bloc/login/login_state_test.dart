import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements AppUser {}

void main() {
  group('LoginState', () {
    group('LoginInitial', () {
      test('supports value comparisons', () {
        expect(
          PhoneloginInitial(),
          PhoneloginInitial(),
        );
      });
    });

    group('OtpSentState', () {
      test('supports value comparisons', () {
        // final user = MockUser();
        expect(
          OtpSentState(),
          OtpSentState(),
        );
      });
    });

    group('Loading State', () {
      test('supports value comparisons', () {
        expect(
          LoadingState(),
          LoadingState(),
        );
      });
    });

    group('OtpVerifiedState', () {
      test('supports value comparisons', () {
        expect(
          OtpVerifiedState(),
          OtpVerifiedState(),
        );
      });
    });

    group('OtpExceptionState', () {
      test('supports value comparisons', () {
        expect(
          OtpExceptionState(),
          OtpExceptionState(),
        );
      });
    });

    group('LoginCompleteState', () {
      test('supports value comparisons', () {
        expect(
          LoginCompleteState(),
          LoginCompleteState(),
        );
      });
    });

    group('ExceptionState', () {
      test('supports value comparisons', () {
        expect(
          ExceptionState(),
          ExceptionState(),
        );
      });
    });
  });
}
