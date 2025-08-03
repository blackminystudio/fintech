import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/ux/pages/disabled_user_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/util/router/home_router.gr.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/auth_test_helper.dart';
import '../../../helpers/fakes.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockStore mockStore;
  late MockRouter mockRouter;

  setUp(() {
    mockRouter = MockRouter();
  });

  Future<void> pumpPage(WidgetTester tester) async {
    await pumpWidgetWithOverrides(
      tester,
      mockRouter: mockRouter,
      child: const DisabledUserPage(),
      overrides: [
        logoutProvider.overrideWithValue(FakeLogout()),
        authStoreProvider.overrideWith((ref) => mockStore = MockStore(ref)),
      ],
    );
  }

  testWidgets('Given DisabledUserPage '
      'When the page is rendered '
      'Then it should display the error message and logout button', (
    tester,
  ) async {
    await pumpPage(tester);
    expect(
      find.text('Your account has been disabled due to violation.'),
      findsOneWidget,
    );
    expect(find.text('logout'), findsOneWidget);
  });

  testWidgets('Given user on DisabledUserPage '
      'When logout button is tapped '
      'Then store.loggedOut is true and navigates to HomeRoute', (
    tester,
  ) async {
    when(
      () => mockRouter.replace(const HomeRoute()),
    ).thenAnswer((_) async => null);

    await pumpPage(tester);
    await tester.tap(find.text('logout'));
    await tester.pumpAndSettle();

    expect(mockStore.loggedOut, isTrue);
    verify(() => mockRouter.replace(const HomeRoute())).called(1);
  });
}
