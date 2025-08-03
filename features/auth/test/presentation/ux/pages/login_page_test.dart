import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/store/src/auth_state.dart';
import 'package:auth/presentation/ux/pages/login_page.dart';
import 'package:auth/util/constants/auth_constants.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/util/router/home_router.gr.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/auth_test_helper.dart';
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
      child: const LoginPage(),
      overrides: [
        authStoreProvider.overrideWith((ref) => mockStore = MockStore(ref)),
      ],
    );
  }

  group('LoginPage UI', () {
    testWidgets('Given status is loading, '
        'When LoginPage is built, '
        'Then shows CircularProgressIndicator', (tester) async {
      await pumpPage(tester);
      mockStore.setStatus(AuthStatus.loading);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Given status is unauthenticated, '
        'When LoginPage is built, '
        'Then shows Google sign-in button', (tester) async {
      await pumpPage(tester);
      expect(find.text(AuthConstants.googleButtonLabel), findsOneWidget);
    });

    testWidgets('Given sign-in was cancelled, '
        'When state is updated, '
        'Then shows cancellation snackbar', (tester) async {
      await pumpPage(tester);
      mockStore.state = const AuthState(
        exception: AppException(
          errorType: ErrorType.signinCancelled,
          message: testMessage,
        ),
      );
      await tester.pump();
      expect(
        find.text('What Happened? You cancelled the sign-in process.'),
        findsOneWidget,
      );
    });
  });

  group('LoginPage Actions', () {
    testWidgets('Given status is unauthenticated, '
        'When Google button is tapped, '
        'Then signInWithGoogle is triggered and navigates to Home', (
      tester,
    ) async {
      when(
        () => mockRouter.replace(const HomeRoute()),
      ).thenAnswer((_) async => null);

      await pumpPage(tester);
      await tester.tap(find.text(AuthConstants.googleButtonLabel));
      await tester.pumpAndSettle();

      expect(mockStore.signInCalled, isTrue);
      verify(() => mockRouter.replace(const HomeRoute())).called(1);
    });
  });
}
