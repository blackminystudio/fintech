import 'package:core/core.dart';

import '../../global/model/user_profile_model.dart';

abstract class AuthRepository {
  /// Signs in a user with Google and returns their profile or an error.
  Future<Either<AppException, UserProfile>> signInWithGoogle();

  /// Retrieves the logged-in user's profile, or null if not logged in.
  Future<Either<AppException, UserProfile?>> getLoggedInUser();

  /// Logs out the current user.
  Future<void> logout();
}
