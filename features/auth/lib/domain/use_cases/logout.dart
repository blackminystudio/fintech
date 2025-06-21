import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

@injectable
class Logout {
  Logout({required this.authRepository});
  final AuthRepository authRepository;

  Future<void> call() async => authRepository.logout();
}
