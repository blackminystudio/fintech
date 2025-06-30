import '../auth_types.dart';

abstract class AuthRepository {
  EitherAuth signInWithGoogle();
  EitherAuthNullable getLoggedInUser();
  Future<void> logout();
}
