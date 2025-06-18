import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/global/model/user_profile_model.dart';
import '../../../../core/utilities/Error/error_type.dart';
import '../../../../core/utilities/app_exception.dart';
import '../../domain/auth_types.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  EitherUserProfile signInWithGoogle() async {
    try {
      // 1. Trigger Google sign‐in flow:
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled before selecting an account
        return const Left(
          AppException(
            source: 'GoogleSignIn',
            code: 'sign-in-cancelled',
            errorType: ErrorType.signinCancelled,
            message: 'Google sign-in was cancelled by the user.',
          ),
        );
      }

      // 2. Obtain GoogleAuth credentials
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 3. Sign in to Firebase with those credentials
      final userCred = await _firebaseAuth.signInWithCredential(credential);
      final user = userCred.user;
      if (user == null) {
        // This should rarely happen—treat as an error
        return const Left(
          AppException(
            source: 'FirebaseAuth',
            code: 'no-user',
            errorType: ErrorType.noUser,
            message: 'Failed to retrieve user after Google sign-in.',
          ),
        );
      }

      // 4. Map Firebase User → UserProfile and wrap in Right
      return Right(UserProfile.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      // Any FirebaseAuth-specific errors (invalid-token, account-exists, etc.)
      return Left(AppException.fromFirebaseException(e));
    } catch (e) {
      // Fallback for any other unexpected error
      return Left(AppException.fromFirebaseException(e));
    }
  }

  @override
  EitherUserProfileNullable getLoggedInUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        // Not signed in
        return const Right(null);
      }
      // Signed in → map to our domain model
      return Right(UserProfile.fromFirebaseUser(firebaseUser));
    } on FirebaseAuthException catch (e) {
      return Left(AppException.fromFirebaseException(e));
    } catch (e) {
      return Left(AppException.fromFirebaseException(e));
    }
  }

  @override
  Future<Either<AppException, void>> logout() async {
    try {
      // Sign out from Google (if signed in)
      await _googleSignIn.signOut();
      // Then sign out from Firebase
      await _firebaseAuth.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AppException.fromFirebaseException(e));
    } catch (e) {
      return Left(AppException.fromFirebaseException(e));
    }
  }
}
