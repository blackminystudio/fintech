import 'package:core/core.dart';

import 'entities/auth_entity.dart';

typedef FutureEitherAuth = Future<Either<AppException, AuthEntity>>;
typedef FutureEitherAuthNull = Future<Either<AppException, AuthEntity?>>;
typedef StreamEitherAuthNull = Stream<Either<AppException, AuthEntity?>>;
