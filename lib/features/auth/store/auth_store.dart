import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/store/models/user_profile_model.dart';
import '../store/auth_service.dart';

final authStoreProvider =
    StateNotifierProvider<AuthStore, AsyncValue<UserProfile>>(
  AuthStore.new,
);

class AuthStore extends StateNotifier<AsyncValue<UserProfile>> {
  AuthStore(this.ref) : super(const AsyncLoading());
  final Ref ref;
  Future<void> loginWithGoogle() async {
    try {
      state = const AsyncLoading();
      final authService = ref.read(authServiceProvider);
      final userProfile = await authService.signInWithGoogle();
      state = AsyncData(userProfile);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    await ref.read(authServiceProvider).signOut();
    state = const AsyncLoading();
  }

  bool get isLoggedIn => state.value != null;
  UserProfile? get user => state.valueOrNull;
}
