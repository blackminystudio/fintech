import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  /// Fires whenever Firebase’s auth state changes.
  Stream<User?> authStateChanges();

  /// Reloads and returns the current user, or `null` if none.
  Future<User?> getCurrentUser();

  Future<User> signInWithGoogle();

  Future<void> logout();
}
