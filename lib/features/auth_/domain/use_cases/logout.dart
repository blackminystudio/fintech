import '../repositories/auth_repository.dart';

class Logout {
  Logout({required this.authRepository});
  final AuthRepository authRepository;

  Future<void> call() async => authRepository.logout();
}
