import '../auth_types.dart';

abstract class AuthRepository {
  FutureEitherAuth signInWithGoogle();
  FutureEitherAuthNull getCurrentUser();
  StreamEitherAuthNull watchAuth();
  Future<void> logout();
}
