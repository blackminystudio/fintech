import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/global/model/user_profile_model.dart';
import 'auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthServiceImpl());

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserProfile> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'sign-in-cancelled',
          message: 'Google sign-in was cancelled by user.',
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
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'User is null after Google sign-in.',
        );
      }
      return _mapToUserProfile(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserProfile?> getLoggedInUser() async {
    final user = _firebaseAuth.currentUser;
    return user != null ? _mapToUserProfile(user) : null;
  }

  @override
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  UserProfile _mapToUserProfile(User user) {
    final metadata = user.metadata;
    return UserProfile(
      uid: user.uid,
      auth: AuthData.create(
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
        createdAt: metadata.creationTime ?? DateTime.now(),
        lastLoginAt: metadata.lastSignInTime ?? DateTime.now(),
      ),
    );
  }
}
