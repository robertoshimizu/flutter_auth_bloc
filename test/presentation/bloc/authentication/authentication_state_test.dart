import 'package:flutter_auth_bloc/domain/entities/user.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements AppUser {}

void main() {
  group('AuthenticationState', () {
    group('Uninitialized', () {
      test('supports value comparisons', () {
        expect(
          Uninitialized(),
          Uninitialized(),
        );
      });
    });

    group('AuthenticationInProgress', () {
      test('supports value comparisons', () {
        // final user = MockUser();
        expect(
          Authenticated(),
          Authenticated(),
        );
      });
    });

    group('AuthenticationFailure', () {
      test('supports value comparisons', () {
        expect(
          Unauthenticated(),
          Unauthenticated(),
        );
      });
    });

    group('AuthenticationSucess', () {
      test('supports value comparisons', () {
        expect(
          Loading(),
          Loading(),
        );
      });
    });
  });
}
