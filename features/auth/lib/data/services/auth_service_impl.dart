import 'package:core/core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  AuthServiceImpl({required this.firebaseAuth, required this.googleSignIn});

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  @override
  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  @override
  Future<User?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    await user.reload();
    return firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    // Custom exception if the user cancels the sign-in
    if (googleUser == null) {
      throw const AppException(
        code: 'sign-in-cancelled',
        source: 'GoogleSignIn',
        errorType: ErrorType.signinCancelled,
        message: 'Google sign-in was cancelled by the user.',
      );
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCred = await firebaseAuth.signInWithCredential(credential);
    final user = userCred.user;

    if (user == null) {
      // Custom exception if the user is not found
      throw const AppException(
        code: 'no-user',
        source: 'FirebaseAuth',
        errorType: ErrorType.noUser,
        message: 'Failed to retrieve user after Google sign-in.',
      );
    }
    return user;
  }
}
