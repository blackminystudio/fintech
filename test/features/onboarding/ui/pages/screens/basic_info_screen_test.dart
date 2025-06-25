import 'package:fintechapp/features/onboarding/ui/pages/screens/basic_info_screen.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/bottom_action_bar.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/miny_divider.dart';
import 'package:fintechapp/features/onboarding/ui/widgets/onboarding_title.dart';
import 'package:fintechapp/features/onboarding/utilities/onboarding_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../utils/helper.dart';

void main() {
  testWidgets(
      'Given empty values '
      'When the BasicInfoScreen widget tree is built '
      'Then all default widgets and texts should render correctly',
      (WidgetTester tester) async {
    await pumpMinyWidgets(
      tester,
      child: BasicInfoScreen(onTap: () {}),
    );
    expect(find.byType(TextField), findsWidgets);
    expect(find.byType(MinyDivider), findsWidgets);
    expect(find.byType(OnboardingTitle), findsOneWidget);
    expect(find.byType(BottomActionBar), findsOneWidget);
    expect(find.text(OnboardingConstants.basicInfoTitle), findsOneWidget);
    expect(find.text(OnboardingConstants.basicInfoSubtitle), findsOneWidget);
    expect(find.text(OnboardingConstants.basicInfoFooterNote), findsOneWidget);
    expect(find.byIcon(OnboardingConstants.infoIcon), findsOneWidget);
  });
  testWidgets(
      'Given user does not enter name '
      'When user taps confirm button '
      'Then name empty error message should be display',
      (WidgetTester tester) async {
    await pumpMinyWidgets(
      tester,
      child: BasicInfoScreen(onTap: () {}),
    );
    await tester.tap(find.byType(BottomActionBar));
    await tester.pump();

    expect(find.text(OnboardingConstants.nameEmpty), findsOneWidget);
  });

  testWidgets(
      'Given user enters a text as name '
      'When user taps confirm button '
      'Then onTap should be trigger and no error should be shown',
      (WidgetTester tester) async {
    var isTapped = false;

    await pumpMinyWidgets(
      tester,
      child: BasicInfoScreen(onTap: () {
        isTapped = true;
      }),
    );

    final nameField = find.byType(TextField);
    await tester.enterText(nameField, 'John Doe');
    await tester.tap(find.byType(BottomActionBar));
    await tester.pumpAndSettle();

    expect(isTapped, isTrue);
    expect(find.text(OnboardingConstants.nameEmpty), findsNothing);
    expect(find.textContaining('John Doe'), findsOneWidget);
  });

  testWidgets(
      'Given user enters non-alphabetic characters in name field '
      'When user types into the TextField '
      'Then only alphabetic characters should be allowed',
      (WidgetTester tester) async {
    await pumpMinyWidgets(
      tester,
      child: BasicInfoScreen(onTap: () {}),
    );
    final nameField = find.byType(TextField);
    await tester.enterText(nameField, '123@#John');
    await tester.pump();
    expect(find.textContaining('John'), findsOneWidget);
    expect(find.textContaining('123@'), findsNothing);
  });
}
