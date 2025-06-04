import '../auth_types.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogle {
  SignInWithGoogle({
    required this.authRepository,
  });
  final AuthRepository authRepository;

  EitherUserProfile call() async => authRepository.signInWithGoogle();
}
