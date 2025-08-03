import 'package:core/core.dart';

import '../../../domain/entities/auth_entity.dart';
import '../auth_store_provider.dart';
import 'auth_state.dart';

final authStatusStreamProvider =
    StreamProvider.autoDispose<Either<AppException, AuthEntity?>>(
      (ref) => ref.watch(authRepoProvider).watchAuth(),
    );

class AuthStore extends StateNotifier<AuthState> {
  AuthStore(this.ref) : super(const AuthState()) {
    _listenAuthStream();
  }
  final Ref ref;

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading);
    final result = await ref.read(signInWithGoogleProvider)();
    _onAuthResult(result);
  }

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loading);
    await ref.read(logoutProvider)();
    // Even after logout we shouldn't remove the auth entity
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  void _listenAuthStream() {
    ref.listen<AsyncValue<Either<AppException, AuthEntity?>>>(
      authStatusStreamProvider,
      (previous, next) => next.when(
        data: _onAuthResult,
        loading: () => state = state.copyWith(status: AuthStatus.loading),
        error:
            (e, st) =>
                state = state.copyWith(
                  status: AuthStatus.unauthenticated,
                  exception: AppException.fromService(e, st),
                ),
      ),
      fireImmediately: true,
    );
  }

  void _onAuthResult(Either<AppException, AuthEntity?> result) {
    result.fold(
      (exception) =>
          state = state.copyWith(
            exception: exception,
            status:
                exception.errorType == ErrorType.userDisabled
                    ? AuthStatus.disabled
                    : AuthStatus.unauthenticated,
          ),
      (user) =>
          state = state.copyWith(
            authEntity: user,
            status:
                user == null
                    ? AuthStatus.unauthenticated
                    : AuthStatus.authenticated,
          ),
    );
  }
}
