import 'package:fintechapp/features/onboarding/ui/pages/screens/number_screen.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/bottom_action_bar.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/onboarding_title.dart';
import 'package:fintechapp/features/onboarding/utilities/onboarding_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../../../utils/helper.dart';

void main() {
  testWidgets(
    'Given empty values '
    'When NumberScreen is rendered '
    'Then it should display the correct default widgets and texts',
    (tester) async {
      await pumpMinyWidgets(
        tester,
        child: NumberScreen(onTap: () {}),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(MinyContainer), findsOneWidget);
      expect(find.byType(OnboardingTitle), findsOneWidget);
      expect(find.byType(BottomActionBar), findsOneWidget);
      expect(find.text(OnboardingConstants.otpSubText), findsOneWidget);
      expect(find.text(OnboardingConstants.countryCode), findsOneWidget);
      expect(find.text(OnboardingConstants.enterMobileText), findsOneWidget);

      final minyContainer = tester.widget<MinyContainer>(
        find.byType(MinyContainer),
      );
      expect(minyContainer.borderSide!.color, theme.colors.neutralBorder);
    },
  );

  testWidgets(
    'Given NumberScreen is rendered '
    'When user types less than 10 digits '
    'Then the focus should remain on TextField ',
    (tester) async {
      await pumpMinyWidgets(
        tester,
        child: NumberScreen(onTap: () {}),
      );

      final textFieldFinder = find.byType(TextField);

      await tester.tap(textFieldFinder);
      await tester.pump();
      expect(FocusScope.of(tester.element(textFieldFinder)).hasFocus, isTrue);

      await tester.enterText(textFieldFinder, '123456789');
      await tester.pumpAndSettle();
      expect(FocusScope.of(tester.element(textFieldFinder)).hasFocus, isTrue);

      await tester.enterText(textFieldFinder, '1234567890');
      await tester.pumpAndSettle();
      expect(FocusScope.of(tester.element(textFieldFinder)).hasFocus, isFalse);
    },
  );

  group('NumberScreen Validation Logic', () {
    final textFieldFinder = find.byType(TextField);

    testWidgets(
      'Given user types <10 digits '
      'When the user does not tap "Verify" '
      'Then error message and red border should not be displayed',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: NumberScreen(onTap: () {}),
        );

        final controller = tester.widget<TextField>(textFieldFinder).controller;
        expect(controller?.text.isEmpty, true);

        await tester.enterText(textFieldFinder, '123456789');
        await tester.pumpAndSettle();

        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsNothing,
        );
      },
    );

    testWidgets(
      'Given user types <10 digits '
      'When user taps "Verify" '
      'Then error message and red border should be display',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: NumberScreen(onTap: () {}),
        );

        await tester.enterText(textFieldFinder, '123456789');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pumpAndSettle();

        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsOneWidget,
        );

        final minyContainer = tester.widget<MinyContainer>(
          find.byType(MinyContainer),
        );
        expect(minyContainer.borderSide!.color, theme.colors.accentRed);
      },
    );

    testWidgets(
      'Given user types 10 digits '
      'When user taps "Verify" '
      'Then no error message should be shown',
      (tester) async {
        var isTapped = false;
        await pumpMinyWidgets(
          tester,
          child: NumberScreen(onTap: () {
            isTapped = true;
          }),
        );

        await tester.enterText(textFieldFinder, '1234567890');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pumpAndSettle();

        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsNothing,
        );
        expect(isTapped, isTrue);
      },
    );

    testWidgets(
      'Given user entered 10 valid digits and Verify '
      'When user deletes digits to make it <10 '
      'Then error should not be shown',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: NumberScreen(onTap: () {}),
        );

        await tester.enterText(textFieldFinder, '1234567890');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pumpAndSettle();

        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsNothing,
        );

        await tester.enterText(textFieldFinder, '123456789');
        await tester.pumpAndSettle();

        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsNothing,
        );
      },
    );

    testWidgets(
      'Given user taps verify with <10 digits '
      'When user gradually fixes the input to 10 digits '
      'Then error should go away once input is valid',
      (tester) async {
        await pumpMinyWidgets(
          tester,
          child: NumberScreen(onTap: () {}),
        );

        await tester.enterText(textFieldFinder, '12345678');
        await tester.tap(find.byType(BottomActionBar));
        await tester.pumpAndSettle();

        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsOneWidget,
        );

        final minyContainer = tester.widget<MinyContainer>(
          find.byType(MinyContainer),
        );
        expect(minyContainer.borderSide!.color, theme.colors.accentRed);

        await tester.enterText(textFieldFinder, '123456789');
        await tester.pumpAndSettle();
        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsOneWidget,
        );

        await tester.enterText(textFieldFinder, '1234567890');
        await tester.pumpAndSettle();
        expect(
          find.text(OnboardingConstants.mobileValidationError),
          findsNothing,
        );
      },
    );

    testWidgets(
        'Given user types <10 digits '
        'When the user does not tap "Verify" '
        'Then error message and red border should not be displayed',
        (tester) async {
      await pumpMinyWidgets(
        tester,
        child: NumberScreen(onTap: () {}),
      );

      final controller = tester.widget<TextField>(textFieldFinder).controller;
      expect(controller?.text.isEmpty, true);

      await tester.enterText(textFieldFinder, '123456789');
      await tester.pumpAndSettle();

      expect(
        find.text(OnboardingConstants.mobileValidationError),
        findsNothing,
      );
    });
  });
}
