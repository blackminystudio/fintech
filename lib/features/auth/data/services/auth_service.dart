import '../../domain/auth_types.dart';

abstract class AuthService {
  /// Signs in a user with Google and returns their profile or an error.
  EitherUserProfile signInWithGoogle();

  /// Retrieves the logged-in user's profile, or null if not logged in.
  EitherUserProfileNullable getLoggedInUser();

  /// Logs out the current user.
  Future<void> logout();
}
