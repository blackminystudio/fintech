import '../../../core/global/model/user_profile_model.dart';

abstract class AuthService {
  Future<UserProfile> signInWithGoogle();
  Future<UserProfile?> getLoggedInUser();
  Future<void> logout();
}
