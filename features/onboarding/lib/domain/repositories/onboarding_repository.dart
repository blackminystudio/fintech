import '../entities/onboarding_entity.dart';
import '../onboarding_types.dart';

abstract class OnboardingRepository {
  FutureEitherOnboarding updateOnboardingData(OnboardingEntity entity);
  FutureEitherOnboardingEntity fetchOnboardingData();
}
