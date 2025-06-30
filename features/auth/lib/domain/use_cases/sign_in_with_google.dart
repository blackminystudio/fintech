import 'package:core/core.dart';

import '../auth_types.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignInWithGoogle {
  SignInWithGoogle(this._authRepository);
  final AuthRepository _authRepository;

  EitherAuth call() async => await _authRepository.signInWithGoogle();
}
