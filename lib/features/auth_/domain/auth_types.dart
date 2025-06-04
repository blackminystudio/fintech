import 'package:dartz/dartz.dart';

import '../../../core/global/model/user_profile_model.dart';
import '../../../core/utilities/app_exception.dart';

typedef EitherUserProfile = Future<Either<AppException, UserProfile>>;
typedef EitherUserProfileNullable = Future<Either<AppException, UserProfile?>>;
