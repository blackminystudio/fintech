import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/global/di/injector.dart';
import '../../../../../core/global/model/user_profile_model.dart';
import '../../../../../core/global/store/user_profile_store.dart';
import '../../../../../core/router/app_router_notifier.dart';
import '../../../../../core/utilities/app_exception.dart';
import '../../../../../core/utilities/error/error_type.dart';
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
  final Logout _logout = injector.get<Logout>();
  final SignInWithGoogle _signInWithGoogle = injector.get<SignInWithGoogle>();

  bool get isFetching => state.status != AuthStateStatus.loading;
  AppRouterNotifier get _routeNotifier => ref.read(appRouterNotifier);
  UserProfileStore get _userProfileStore => ref.read(
        userProfileProvider.notifier,
      );

  void _listenAuthStateChange() {
    ref.listen<AsyncValue<User?>>(
      authStateChangesProvider,
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
          final profile = UserProfile.fromFirebaseUser(refreshedUser);

          // Update the state with the new UserProfile:
          state = state.copyWith(
            userProfile: profile,
          );
          _userProfileStore.setAuthData(profile.auth!);

          _routeNotifier.setAuthenticated();
        } on FirebaseAuthException catch (e) {
          _handleAuthException(e);
        }
      },
    );
  }

  void _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'user-disabled') {
      _routeNotifier.setDisabled();
    } else {
      _setUnauthenticated();
    }
  }

  void _setUnauthenticated() {
    state = state.copyWith(
      userProfile: const UserProfile(),
    );
    _routeNotifier.setUnauthenticated();
  }

  Future<void> signInWithGoogle() async {
    if (isFetching) {
      state = state.copyWith(
        status: AuthStateStatus.loading,
        isLoading: true,
      );
      final user = await _signInWithGoogle();
      updateStateFromUserProfile(user);
    }
  }

  void logout() {
    _logout();
    final user = state.userProfile;
    state = state.copyWith(
      userProfile: user,
      hasData: user == null ? false : true,
      status: user == null ? AuthStateStatus.failure : AuthStateStatus.loaded,
    );
  }

  void updateStateFromUserProfile(Either<AppException, UserProfile> user) {
    user.fold((failure) {
      // Handle failure
      // userNotFound
      if (failure.errorType == ErrorType.noUser) {
        state = state.copyWith(
          isLoading: false,
          message: failure.message,
          status: AuthStateStatus.failure,
        );
        _routeNotifier.setUnauthenticated();
        return;
      }
      // signinCancelled
      if (failure.errorType == ErrorType.signinCancelled) {
        state = state.copyWith(
          isLoading: false,
          message: failure.message,
          status: AuthStateStatus.initial,
        );
        _routeNotifier.setUnauthenticated();
        return;
      }
      // user Disabled
      if (failure.errorType == ErrorType.userDisabled) {
        state = state.copyWith(
          isLoading: false,
          message: failure.message,
          status: AuthStateStatus.failure,
        );
        _routeNotifier.setDisabled();
        return;
      }
      state = state.copyWith(
        isLoading: false,
        message: failure.message,
        status: AuthStateStatus.failure,
      );
    }, (userProfile) {
      state = state.copyWith(
        userProfile: userProfile,
        message: '',
        hasData: true,
        isLoading: false,
        status: AuthStateStatus.loaded,
      );
      _userProfileStore.setAuthData(userProfile.auth!);
    });
  }

  void resetState() {
    state = const AuthState.initial();
  }
}
