import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements User {}

void main() {
  group('AuthenticationState', () {
    group('AuthenticationInitial', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationInitial(),
          AuthenticationInitial(),
        );
      });
    });

    group('AuthenticationInProgress', () {
      test('supports value comparisons', () {
        // final user = MockUser();
        expect(
          AuthenticationInProgress(),
          AuthenticationInProgress(),
        );
      });
    });

    group('AuthenticationFailure', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationFailure(),
          AuthenticationFailure(),
        );
      });
    });

    group('AuthenticationSucess', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationSucess(),
          AuthenticationSucess(),
        );
      });
    });
  });
}
