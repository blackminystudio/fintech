import 'package:core/core.dart';

import '../../domain/auth_types.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_extensions.dart';
import '../services/auth_service.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this.service);
  AuthService service;

  @override
  FutureEitherAuth signInWithGoogle() async {
    try {
      final user = await service.signInWithGoogle();
      return Right(user.toAuthModel());
    } catch (e, st) {
      return Left(AppException.fromService(e, st));
    }
  }

  @override
  FutureEitherAuthNull getCurrentUser() async {
    try {
      final user = await service.getCurrentUser();
      if (user == null) return const Right(null);
      return Right(user.toAuthModel());
    } catch (e, st) {
      return Left(AppException.fromService(e, st));
    }
  }

  @override
  StreamEitherAuthNull watchAuth() async* {
    try {
      await for (final user in service.authStateChanges()) {
        if (user == null) {
          yield const Right(null);
        } else {
          try {
            final currentUser = await service.getCurrentUser();
            if (currentUser == null) {
              yield const Right(null);
            } else {
              yield Right(currentUser.toAuthModel());
            }
          } catch (e, st) {
            final exception = AppException.fromService(e, st);
            yield Left(exception);
            if (exception.errorType == ErrorType.userDisabled) return;
          }
        }
      }
    } catch (e, st) {
      yield Left(AppException.fromService(e, st));
    }
  }

  @override
  Future<void> logout() => service.logout();
}
