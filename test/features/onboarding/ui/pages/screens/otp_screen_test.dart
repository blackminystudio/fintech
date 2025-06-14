import 'package:fintechapp/features/onboarding/ui/pages/screens/otp_screen.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/bottom_action_bar.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/onboarding_title.dart';
import 'package:fintechapp/features/onboarding/utilities/onboarding_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../utils/helper.dart';

void main() {
  testWidgets(
    'Given empty values '
    'When OtpScreen is rendered '
    'Then it should display the correct default widgets and texts',
    (tester) async {
      await pumpMinyWidgets(
        tester,
        child: OtpScreen(
          onTap: () {},
          correctOtp: '',
          onResendOtp: () {},
        ),
      );

      final pinCodeField = tester.widget<PinCodeTextField>(
        find.byType(PinCodeTextField),
      );
      expect(find.byType(PinCodeTextField), findsWidgets);
      expect(find.byType(OnboardingTitle), findsOneWidget);
      expect(find.byType(BottomActionBar), findsOneWidget);
      expect(find.text(OnboardingConstants.otpHeading), findsOneWidget);
      expect(pinCodeField.pinTheme.activeColor, theme.colors.neutralBorder);
    },
  );
  testWidgets(
    'Given countdown completes '
    'When user taps "Resend OTP" '
    'Then onResendOtp should be called',
    (WidgetTester tester) async {
      var isResendTapped = false;

      await pumpMinyWidgets(
        tester,
        child: OtpScreen(
          correctOtp: '123456',
          onTap: () {},
          onResendOtp: () {
            isResendTapped = true;
          },
        ),
      );

      expect(find.text(OnboardingConstants.resendOtp), findsNothing);

      await tester.pump(const Duration(seconds: 30));

      final resendButton = find.text(OnboardingConstants.resendOtp);
      expect(resendButton, findsOneWidget);

      await tester.tap(resendButton);
      await tester.pump();

      expect(isResendTapped, isTrue);
    },
  );

  group('OtpScreen Validation Logic', () {
    final pinCodeFieldFinder = find.byType(PinCodeTextField);

    testWidgets(
      'Given OtpScreen is rendered '
      'When user types less than 6 digits and does not tap verify '
      'Then error message should not be shown',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: OtpScreen(
            onTap: () {},
            correctOtp: '',
            onResendOtp: () {},
          ),
        );

        final otpController =
            tester.widget<PinCodeTextField>(pinCodeFieldFinder).controller;
        expect(otpController?.text.isEmpty, true);

        await tester.enterText(pinCodeFieldFinder, '12345');
        await tester.pump();

        expect(
          find.text(OnboardingConstants.otpValidationError),
          findsNothing,
        );
      },
    );

    testWidgets(
      'Given user types <6 digits '
      'When user taps "Verify" '
      'Then otp length error message and red border should be display',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: OtpScreen(
            onTap: () {},
            correctOtp: '',
            onResendOtp: () {},
          ),
        );

        await tester.enterText(pinCodeFieldFinder, '12345');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pump();

        expect(
          find.text(OnboardingConstants.otpLengthError),
          findsOneWidget,
        );

        final pinCodeField = tester.widget<PinCodeTextField>(
          find.byType(PinCodeTextField),
        );

        expect(pinCodeField.pinTheme.activeColor, theme.colors.accentRed);
      },
    );
    testWidgets(
      'Given user types valid 6 digits  otp '
      'When user taps "Verify" '
      'Then otp validation sucessfull and neutral border should be display',
      (tester) async {
        var isTapped = false;
        await pumpMinyWidgets(
          tester,
          child: OtpScreen(
            onTap: () {
              isTapped = true;
            },
            correctOtp: '123456',
            onResendOtp: () {},
          ),
        );

        await tester.enterText(pinCodeFieldFinder, '123456');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pump();
        expect(isTapped, isTrue);
        expect(
          find.text(OnboardingConstants.otpLengthError),
          findsNothing,
        );
        expect(
          find.text(OnboardingConstants.otpValidationError),
          findsNothing,
        );
        final pinCodeField = tester.widget<PinCodeTextField>(
          find.byType(PinCodeTextField),
        );

        expect(pinCodeField.pinTheme.activeColor, theme.colors.neutralBorder);
      },
    );
    testWidgets(
      'Given user types wrong otp  '
      'When user taps "Verify" '
      'Then otp error and accentRed border color should be display',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: OtpScreen(
            onTap: () {},
            correctOtp: '123456',
            onResendOtp: () {},
          ),
        );

        await tester.enterText(pinCodeFieldFinder, '123457');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pump();
        expect(
          find.text(OnboardingConstants.otpValidationError),
          findsOneWidget,
        );
        final pinCodeField = tester.widget<PinCodeTextField>(
          find.byType(PinCodeTextField),
        );

        expect(pinCodeField.pinTheme.activeColor, theme.colors.accentRed);
      },
    );
  });
}
