import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/domain/use_cases/logout.dart';
import 'package:auth/domain/use_cases/sign_in_with_google.dart';
import 'package:auth/presentation/store/auth_store_provider.dart';
import 'package:auth/presentation/store/src/auth_store.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/mocks.dart';

void main() {
  test(
    'Given provider overrides, '
    'When reading providers, '
    'Then they resolve correctly',
    () {
      getIt.registerFactory<AuthRepository>(MockAuthRepository.new);
      // Given
      final container = ProviderContainer();

      // When/Then
      expect(container.read(authRepoProvider), isA<AuthRepository>());
      expect(container.read(logoutProvider), isA<Logout>());
      expect(container.read(signInWithGoogleProvider), isA<SignInWithGoogle>());
      expect(container.read(authStoreProvider.notifier), isA<AuthStore>());
    },
  );
}
