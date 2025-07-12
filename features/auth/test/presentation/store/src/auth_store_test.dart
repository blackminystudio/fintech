import 'package:auth/domain/entities/auth_entity.dart';
import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/store/src/auth_state.dart';
import 'package:auth/presentation/store/src/auth_store.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/auth_test_helper.dart';
import '../../../helpers/fakes.dart';
import '../../../helpers/mocks.dart';

void main() {
  group('AuthStore', () {
    final testUser = AuthEntity(
      email: testEmail,
      createdAt: testCreatedAt,
      lastLoginAt: testLastLoginAt,
    );

    late MockAuthRepository mockAuthRepo;
    late FakeLogout fakeLogout;
    late ProviderContainer container;
    late AuthStore authStore;

    setUp(() {
      mockAuthRepo = MockAuthRepository();
      fakeLogout = FakeLogout();

      container = ProviderContainer(
        overrides: [
          authRepoProvider.overrideWithValue(mockAuthRepo),
          logoutProvider.overrideWithValue(fakeLogout),
        ],
      );

      authStore = container.read(authStoreProvider.notifier);
    });

    tearDown(() {
      mockAuthRepo.close();
      container.dispose();
    });

    group('Initial State & Stream Listening', () {
      test(
        'Given AuthStore is created '
        'When no user is logged in '
        'Then state should be unauthenticated with null user and exception',
        () async {
          mockAuthRepo.emit(const Right(null));
          await Future.delayed(Duration.zero);

          final state = container.read(authStoreProvider);
          expect(state.status, AuthStatus.unauthenticated);
          expect(state.authEntity, isNull);
          expect(state.exception, isNull);
        },
      );

      test(
        'Given AuthStore is created '
        'When auth stream emits a valid user '
        'Then state should be authenticated with the user data',
        () async {
          mockAuthRepo.emit(Right(testUser));
          await Future.delayed(Duration.zero);

          final state = container.read(authStoreProvider);
          expect(state.status, AuthStatus.authenticated);
          expect(state.authEntity, testUser);
          expect(state.exception, isNull);
        },
      );

      test(
        'Given AuthStore is created '
        'When auth stream emits an exception '
        'Then state should be unauthenticated with exception set',
        () async {
          const error = AppException(
            source: 'auth',
            message: 'Invalid session',
          );

          mockAuthRepo.emit(const Left(error));
          await Future.delayed(Duration.zero);

          final state = container.read(authStoreProvider);
          expect(state.status, AuthStatus.unauthenticated);
          expect(state.authEntity, isNull);
          expect(state.exception, error);
        },
      );
    });

    group('Sign In', () {
      test(
        'Given user signs in with Google '
        'When successful '
        'Then state becomes authenticated',
        () async {
          final signIn = FakeSignInWithGoogle(Right(testUser));

          final testContainer = ProviderContainer(
            overrides: [
              authRepoProvider.overrideWithValue(mockAuthRepo),
              signInWithGoogleProvider.overrideWithValue(signIn),
              logoutProvider.overrideWithValue(fakeLogout),
            ],
          );

          final store = testContainer.read(authStoreProvider.notifier);
          await store.signInWithGoogle();

          final state = testContainer.read(authStoreProvider);
          expect(state.status, AuthStatus.authenticated);
          expect(state.authEntity, testUser);
          expect(state.exception, isNull);

          testContainer.dispose();
        },
      );

      test(
        'Given user signs in with Google '
        'When failure occurs '
        'Then state becomes unauthenticated with exception',
        () async {
          const error = AppException(
            message: 'Failed login',
            source: 'auth',
          );

          final signIn = FakeSignInWithGoogle(const Left(error));

          final testContainer = ProviderContainer(
            overrides: [
              authRepoProvider.overrideWithValue(mockAuthRepo),
              signInWithGoogleProvider.overrideWithValue(signIn),
              logoutProvider.overrideWithValue(fakeLogout),
            ],
          );

          final store = testContainer.read(authStoreProvider.notifier);
          await store.signInWithGoogle();

          final state = testContainer.read(authStoreProvider);
          expect(state.status, AuthStatus.unauthenticated);
          expect(state.exception, error);
          expect(state.authEntity, isNull);

          testContainer.dispose();
        },
      );
    });

    group('Logout', () {
      test(
        'Given user is logged in '
        'When logout is called '
        'Then state becomes unauthenticated and logout is called',
        () async {
          await authStore.logout();

          final state = container.read(authStoreProvider);
          expect(state.status, AuthStatus.unauthenticated);
          expect(fakeLogout.called, isTrue);
        },
      );
    });
  });
}
