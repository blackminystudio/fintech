import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    // If the user cancels the sign-in, googleUser will be null
    if (googleUser == null) {
      throw const AppException(
        source: 'GoogleSignIn',
        code: 'sign-in-cancelled',
        errorType: ErrorType.signinCancelled,
        message: 'Google sign-in was cancelled by the user.',
      );
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCred = await _firebaseAuth.signInWithCredential(credential);
    final user = userCred.user;

    if (user == null) {
      throw const AppException(
        code: 'no-user',
        source: 'FirebaseAuth',
        errorType: ErrorType.noUser,
        message: 'Failed to retrieve user after Google sign-in.',
      );
    }
    return user;
  }

  @override
  Future<User?> getLoggedInUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return firebaseUser;
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
