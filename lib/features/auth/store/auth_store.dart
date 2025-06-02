import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/global/model/user_profile_model.dart';
import '../../../core/global/store/user_profile_store.dart';
import '../../../core/router/app_router_notifier.dart';
import 'auth_service.dart';
import 'auth_service_impl.dart';

final authStoreProvider =
    StateNotifierProvider<AuthStore, AsyncValue<UserProfile>>(
  AuthStore.new,
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.idTokenChanges(),
);

class AuthStore extends StateNotifier<AsyncValue<UserProfile>> {
  AuthStore(this.ref) : super(const AsyncLoading()) {
    _listenAuthStateChange();
  }

  final Ref ref;
  UserProfile? get user => state.valueOrNull;
  AuthService get _authService => ref.read(authServiceProvider);
  AppRouterNotifier get _routeNotifier => ref.read(appRouterNotifier);
  UserProfileStore get _userProfileStore =>
      ref.read(userProfileProvider.notifier);

  Future<void> loginWithGoogle() async {
    try {
      state = const AsyncLoading();
      if (_routeNotifier.status == AuthStatus.disabled) return;
      final userProfile = await _authService.signInWithGoogle();
      state = AsyncData(userProfile);
      // ① Push the newly‐signed‐in AuthData into the global store:
      _userProfileStore.setAuthData(userProfile.auth!);
      _routeNotifier.setAuthenticated();
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AsyncLoading();
    _routeNotifier.setUnauthenticated();
  }

  void _listenAuthStateChange() {
    ref.listen<AsyncValue<User?>>(authStateChangesProvider,
        (previous, next) async {
      final user = next.value;
      if (user == null) {
        _setUnauthenticated();
        return;
      }

      try {
        await user.reload();
        final refreshedUser = FirebaseAuth.instance.currentUser;

        if (refreshedUser == null) {
          _setUnauthenticated();
          return;
        }
        final profile = _mapUserToProfile(refreshedUser);

        // Update the state with the new UserProfile:
        state = AsyncData(profile);
        _userProfileStore.setAuthData(profile.auth!);

        _routeNotifier.setAuthenticated();
      } on FirebaseAuthException catch (e) {
        _handleAuthException(e);
      }
    });
  }

  // ---------------------
  // Helper methods below
  // ---------------------

  void _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'user-disabled') {
      _routeNotifier.setDisabled();
    } else {
      _setUnauthenticated();
    }
  }

  void _setUnauthenticated() {
    state = const AsyncData(UserProfile());
    _routeNotifier.setUnauthenticated();
  }

  UserProfile _mapUserToProfile(
    User user, {
    UserStatus status = UserStatus.active,
  }) {
    final metadata = user.metadata;
    return UserProfile(
      uid: user.uid,
      status: status,
      auth: AuthData.create(
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
        createdAt: metadata.creationTime ?? DateTime.now(),
        lastLoginAt: metadata.lastSignInTime ?? DateTime.now(),
      ),
    );
  }
}
