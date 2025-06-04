import 'package:dartz/dartz.dart';
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

// Future<void> loginWithGoogle() async {
//   try {
//     state = const AsyncLoading();
//     if (_routeNotifier.status == AuthStateStatus.disabled) return;
//     final userProfile = await _authService.signInWithGoogle();
//     state = AsyncData(userProfile);
//     // ① Push the newly‐signed‐in AuthData into the global store:
//     _userProfileStore.setAuthData(userProfile.auth!);
//     _routeNotifier.setAuthenticated();
//   } on FirebaseAuthException catch (e) {
//     _handleAuthException(e);
//   } catch (e, st) {
//     state = AsyncError(e, st);
//   }
// }

class AuthStore extends StateNotifier<AuthState> {
  AuthStore(this.ref) : super(const AuthState.initial());

  final Ref ref;
  final Logout _logout = injector.get<Logout>();
  final SignInWithGoogle _signInWithGoogle = injector.get<SignInWithGoogle>();

  bool get isFetching => state.status != AuthStateStatus.loading;
  AppRouterNotifier get _routeNotifier => ref.read(appRouterNotifier);
  UserProfileStore get _userProfileStore =>
      ref.read(userProfileProvider.notifier);

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

  void logout(UserProfile user) {
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
