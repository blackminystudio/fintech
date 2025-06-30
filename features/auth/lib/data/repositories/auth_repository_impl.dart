import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/auth_types.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.authService});
  AuthService authService;

  @override
  EitherAuthNullable getLoggedInUser() async {
    try {
      final user = await authService.getLoggedInUser();
      if (user == null) return const Right(null);
      return Right(_userToAuthModel(user));
    } catch (e) {
      return Left(_appException(e));
    }
  }

  @override
  EitherAuth signInWithGoogle() async {
    try {
      final user = await authService.signInWithGoogle();
      return Right(_userToAuthModel(user));
    } catch (e) {
      return Left(_appException(e));
    }
  }

  @override
  Future<void> logout() => authService.logout();

  // Helper methods

  AuthModel _userToAuthModel(User u) {
    final m = u.metadata;
    return AuthModel(
      email: u.email ?? '',
      displayName: u.displayName,
      photoUrl: u.photoURL,
      createdAt: m.creationTime ?? DateTime.now(),
      lastLoginAt: m.lastSignInTime ?? DateTime.now(),
    );
  }

  AppException _appException(Object e) {
    if (e is AppException) return e;
    return AppException.fromFirebaseException(e);
  }
}
