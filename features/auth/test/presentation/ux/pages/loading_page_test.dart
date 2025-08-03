import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/store/src/auth_state.dart';
import 'package:auth/presentation/ux/pages/loading_page.dart';
import 'package:auth/util/router/auth_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/auth_test_helper.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockRouter mockRouter;
  late MockStore mockStore;

  setUp(() {
    mockRouter = MockRouter();
  });

  Future<void> pumpPage(WidgetTester tester) async {
    await pumpWidgetWithOverrides(
      tester,
      mockRouter: mockRouter,
      child: const LoadingPage(),
      overrides: [
        authStoreProvider.overrideWith((ref) => mockStore = MockStore(ref)),
      ],
    );
  }

  testWidgets('Given AuthStatus.loading '
      'When LoadingPage is built '
      'Then CircularProgressIndicator is shown', (tester) async {
    await pumpPage(tester);
    mockStore.setStatus(AuthStatus.loading);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Given AuthStatus.authenticated '
      'When LoadingPage is built '
      'Then it navigates to HomeRoute', (tester) async {
    when(() => mockRouter.replacePath('/home')).thenAnswer((_) async => null);

    await pumpPage(tester);
    mockStore.setStatus(AuthStatus.authenticated);
    verify(() => mockRouter.replacePath('/home')).called(1);
  });

  testWidgets('Given AuthStatus.unauthenticated '
      'When LoadingPage is built '
      'Then it navigates to LoginRoute', (tester) async {
    when(
      () => mockRouter.replace(const LoginRoute()),
    ).thenAnswer((_) async => null);

    await pumpPage(tester);
    mockStore.setStatus(AuthStatus.unauthenticated);
    verify(() => mockRouter.replace(const LoginRoute())).called(1);
  });

  testWidgets('Given AuthStatus.disabled '
      'When LoadingPage is built '
      'Then it navigates to DisabledUserRoute', (tester) async {
    when(
      () => mockRouter.replace(const DisabledUserRoute()),
    ).thenAnswer((_) async => null);

    await pumpPage(tester);
    mockStore.setStatus(AuthStatus.disabled);
    verify(() => mockRouter.replace(const DisabledUserRoute())).called(1);
  });
}
