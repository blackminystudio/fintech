import 'package:core/core.dart';

import '../../domain/auth_types.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';

@LazySingleton(as: AuthRepository)
@injectable
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.authService});
  AuthService authService;

  @override
  EitherUserProfileNullable getLoggedInUser() => authService.getLoggedInUser();

  @override
  EitherUserProfile signInWithGoogle() => authService.signInWithGoogle();

  @override
  Future<void> logout() => authService.logout();
}
