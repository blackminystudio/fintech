import 'package:core/core.dart';

import 'entities/auth_entity.dart';

typedef EitherAuth = Future<Either<AppException, AuthEntity>>;
typedef EitherAuthNullable = Future<Either<AppException, AuthEntity?>>;
