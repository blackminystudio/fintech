import 'package:core/core.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/logout.dart';
import '../../domain/use_cases/sign_in_with_google.dart';
import 'src/auth_state.dart';
import 'src/auth_store.dart';

final authRepoProvider = Provider<AuthRepository>(
  (ref) => getIt<AuthRepository>(),
);

final logoutProvider = Provider<Logout>(
  (ref) => Logout(ref.read(authRepoProvider)),
);

final signInWithGoogleProvider = Provider<SignInWithGoogle>(
  (ref) => SignInWithGoogle(ref.read(authRepoProvider)),
);

final authStoreProvider = StateNotifierProvider<AuthStore, AuthState>(
  AuthStore.new,
);
