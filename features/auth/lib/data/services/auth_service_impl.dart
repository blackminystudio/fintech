import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/auth_model.dart';
import 'auth_service.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  AuthServiceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
  });

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestore;

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
    final appUser = AuthModel(
      email: user.email ?? '',
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastLoginAt: user.metadata.lastSignInTime ?? DateTime.now(),
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
    await firebaseFirestore
        .collection('user')
        .doc(user.uid)
        .set(appUser.toJson());
    await firebaseFirestore
        .collection('user')
        .doc(user.uid)
        .collection('profile')
        .doc('info')
        .set({'email': appUser.email, 'fullName': appUser.displayName});
    return user;
  }
}
