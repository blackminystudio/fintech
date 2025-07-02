import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/auth_entity.dart';
import '../../../domain/use_cases/get_loggedin_user.dart';
import '../../../domain/use_cases/logout.dart';
import '../../../domain/use_cases/sign_in_with_google.dart';
import 'auth_state.dart';

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

class AuthStore extends StateNotifier<AuthState> {
  AuthStore(this.ref) : super(const AuthState.initial()) {
    _listenAuthStateChange();
  }

  final Ref ref;
  final Logout _logout = getIt.get<Logout>();
  final SignInWithGoogle _signInWithGoogle = getIt.get<SignInWithGoogle>();
  final GetLoggedInUser _getLoggedInUser = getIt.get<GetLoggedInUser>();

  bool get isFetching => state.status != AuthStatus.loading;

  void _listenAuthStateChange() {
    ref.listen<AsyncValue<User?>>(
      authStateChangesProvider,
      (
        previous,
        next,
      ) async {
        final user = next.value;
        if (user == null) {
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
          );
          return;
        }

        try {
          state = state.copyWith(
            status: AuthStatus.loading,
          );
          await user.reload();
          final refreshedUser = await _getLoggedInUser();

          refreshedUser.fold(
            (failure) {
              state = state.copyWith(
                status: AuthStatus.failure,
                exception: failure,
              );
              _setUnauthenticated();
            },
            (authEntity) {
              state = state.copyWith(
                authEntity: authEntity,
                status: AuthStatus.authenticated,
              );
            },
          );
        } on FirebaseAuthException catch (e) {
          _handleAuthException(e);
        }
      },
    );
  }

  void _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'user-disabled') {
      state = state.copyWith(
        status: AuthStatus.disabled,
      );
    } else {
      _setUnauthenticated();
    }
  }

  void _setUnauthenticated() {
    state = const AuthState.initial(
      status: AuthStatus.unauthenticated,
    );
  }

  Future<void> signInWithGoogle() async {
    if (isFetching) {
      final user = await _signInWithGoogle();
      updateStateFromUserProfile(user);
    }
  }

  Future<void> logout() async {
    await _logout();
    state = const AuthState.initial(
      status: AuthStatus.unauthenticated,
    );
  }

  void updateStateFromUserProfile(Either<AppException, AuthEntity> user) {
    user.fold(
      (failure) {
        // Handle failure
        // userNotFound
        state = state.copyWith(exception: failure);
        if (failure.errorType == ErrorType.noUser) {
          state = state.copyWith(status: AuthStatus.failure);
          _setUnauthenticated();
          return;
        }
        // signinCancelled
        if (failure.errorType == ErrorType.signinCancelled) {
          state = state.copyWith(status: AuthStatus.initial);
          _setUnauthenticated();
          return;
        }
        // user Disabled
        if (failure.errorType == ErrorType.userDisabled) {
          state = state.copyWith(status: AuthStatus.disabled);

          return;
        }
        state = state.copyWith(status: AuthStatus.failure);
      },
      (authEntity) {
        state = state.copyWith(
          authEntity: authEntity,
          status: AuthStatus.authenticated,
        );
      },
    );
  }

  void resetState() {
    state = const AuthState.initial();
  }
}
