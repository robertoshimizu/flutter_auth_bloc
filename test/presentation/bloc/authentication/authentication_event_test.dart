import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationEvent', () {
    group('Authentication Started', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationStarted(),
          AuthenticationStarted(),
        );
      });
    });

    group('Authentication LoggedIn', () {
      test('supports value comparisons', () {
        String token;
        token = 'any';
        expect(
          AuthenticationLoggedIn(token: token),
          AuthenticationLoggedIn(token: token),
        );
      });
    });

    group('Authentication Logged Out', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationLoggedOut(),
          AuthenticationLoggedOut(),
        );
      });
    });
  });
}
