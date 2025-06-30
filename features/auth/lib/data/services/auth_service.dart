import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User> signInWithGoogle();
  Future<User?> getLoggedInUser();
  Future<void> logout();
}
