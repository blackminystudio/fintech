import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

@injectable
class Logout {
  Logout(this._authRepository);
  final AuthRepository _authRepository;

  Future<void> call() async => _authRepository.logout();
}
