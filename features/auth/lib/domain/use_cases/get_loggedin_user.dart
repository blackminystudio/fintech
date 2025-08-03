import 'package:core/core.dart';

import '../auth_types.dart';
import '../repositories/auth_repository.dart';

@injectable
class GetLoggedInUser {
  GetLoggedInUser(this._authRepository);
  final AuthRepository _authRepository;

  FutureEitherAuthNull call() async => await _authRepository.getCurrentUser();
}
