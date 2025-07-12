import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/store/src/auth_store.dart';
import 'package:auth/presentation/ux/pages/disabled_user_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/util/router/home_router.gr.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthStore extends Mock implements AuthStore {}

class MockRouter extends Mock implements StackRouter {}

void main() {
  late MockAuthStore mockStore;
  late MockRouter mockRouter;

  setUp(() {
    mockStore = MockAuthStore();
    mockRouter = MockRouter();
  });

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authStoreProvider.overrideWith((_) => mockStore),
        ],
        child: StackRouterScope(
          controller: mockRouter,
          stateHash: 0,
          child: const MaterialApp(home: DisabledUserPage()),
        ),
      ),
    );
  }

  testWidgets('displays error & logout button', (t) async {
    await pumpPage(t);
    expect(find.text('Your account has been disabled due to violation.'),
        findsOneWidget);
    expect(find.text('logout'), findsOneWidget);
  });

  testWidgets('logout calls store and navigates', (t) async {
    when(() => mockStore.logout()).thenAnswer((_) async {});
    when(() => mockRouter.replace(const HomeRoute()))
        .thenAnswer((_) async => null);

    await pumpPage(t);
    await t.tap(find.text('logout'));
    await t.pumpAndSettle();

    verify(() => mockStore.logout()).called(1);
    verify(() => mockRouter.replace(const HomeRoute())).called(1);
  });
}
