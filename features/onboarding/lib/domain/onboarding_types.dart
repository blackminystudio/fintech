import 'package:core/core.dart';

import 'entities/onboarding_entity.dart';

typedef FutureEitherOnboarding = Future<Either<AppException, Unit>>;
typedef FutureEitherOnboardingEntity =
    Future<Either<AppException, OnboardingEntity>>;
