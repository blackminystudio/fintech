import 'package:core/core.dart';

import '../global/model/user_profile_model.dart';

typedef EitherUserProfile = Future<Either<AppException, UserProfile>>;
typedef EitherUserProfileNullable = Future<Either<AppException, UserProfile?>>;
