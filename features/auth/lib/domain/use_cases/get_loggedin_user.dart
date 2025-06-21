import 'package:core/core.dart';

import '../auth_types.dart';
import '../repositories/auth_repository.dart';

@injectable
class GetLoggedInUser {
  GetLoggedInUser({required this.authRepository});
  final AuthRepository authRepository;

  EitherUserProfileNullable call() async => authRepository.getLoggedInUser();
}
