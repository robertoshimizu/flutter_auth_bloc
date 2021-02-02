import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneLoginEvent', () {
    group('LoginStartEvent', () {
      test('supports value comparisons', () {
        expect(
          LoginStartEvent(),
          LoginStartEvent(),
        );
      });
    });

    group('SendOtpEvent', () {
      test('supports value comparisons', () {
        String phoNo;
        phoNo = 'any';
        expect(
          SendOtpEvent(phoNo: phoNo),
          SendOtpEvent(phoNo: phoNo),
        );
      });
    });

    group('OtpSendEvent', () {
      test('supports value comparisons', () {
        expect(
          OtpSendEvent(),
          OtpSendEvent(),
        );
      });
    });

    group('VerifyOtpEvent', () {
      test('supports value comparisons', () {
        expect(
          VerifyOtpEvent(otp: '654321'),
          VerifyOtpEvent(otp: '654321'),
        );
      });
    });

    // group('LoginCompleteEvent', () {
    //   test('supports value comparisons', () {
    //     expect(
    //       LoginCompleteEvent(),
    //       LoginCompleteEvent(),
    //     );
    //   });
    // });

    group('LoginExceptionEvent', () {
      test('supports value comparisons', () {
        expect(
          LoginExceptionEvent('exception message'),
          LoginExceptionEvent('exception message'),
        );
      });
    });
  });
}
