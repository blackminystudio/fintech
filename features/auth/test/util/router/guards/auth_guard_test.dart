import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/store/src/auth_state.dart';
import 'package:auth/util/router/auth_router.gr.dart';
import 'package:auth/util/router/guards/auth_guard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockRef mockRef;
  late MockRouter mockRouter;
  late MockResolver mockResolver;
  late AuthGuard guard;

  setUpAll(() {
    registerFallbackValue(FakePageRouteInfo());
  });

  setUp(() {
    mockRef = MockRef();
    mockRouter = MockRouter();
    mockResolver = MockResolver();
    guard = AuthGuard(mockRef);
  });

  test('Given AuthStatus.authenticated, '
      'when navigating, '
      'then calls resolver.next()', () {
    when(
      () => mockRef.read(authStoreProvider),
    ).thenReturn(const AuthState(status: AuthStatus.authenticated));

    guard.onNavigation(mockResolver, mockRouter);

    verify(() => mockResolver.next()).called(1);
    verifyNever(() => mockRouter.replace(any()));
  });

  test('Given AuthStatus.loading, '
      'when navigating, '
      'then redirects to LoadingRoute', () {
    when(
      () => mockRef.read(authStoreProvider),
    ).thenReturn(const AuthState(status: AuthStatus.loading));
    when(
      () => mockRouter.replace(const LoadingRoute()),
    ).thenAnswer((_) async => null);

    guard.onNavigation(mockResolver, mockRouter);

    verify(() => mockRouter.replace(const LoadingRoute())).called(1);
    verifyNever(() => mockResolver.next());
  });

  test('Given AuthStatus.unauthenticated, '
      'when navigating, '
      'then redirects to LoginRoute', () {
    when(() => mockRef.read(authStoreProvider)).thenReturn(const AuthState());
    when(
      () => mockRouter.replace(const LoginRoute()),
    ).thenAnswer((_) async => null);

    guard.onNavigation(mockResolver, mockRouter);

    verify(() => mockRouter.replace(const LoginRoute())).called(1);
    verifyNever(() => mockResolver.next());
  });

  test('Given AuthStatus.disabled, '
      'when navigating, '
      'then redirects to DisabledUserRoute', () {
    when(
      () => mockRef.read(authStoreProvider),
    ).thenReturn(const AuthState(status: AuthStatus.disabled));
    when(
      () => mockRouter.replace(const DisabledUserRoute()),
    ).thenAnswer((_) async => null);

    guard.onNavigation(mockResolver, mockRouter);

    verify(() => mockRouter.replace(const DisabledUserRoute())).called(1);
    verifyNever(() => mockResolver.next());
  });
}
