import 'package:core/core.dart';

import '../entities/onboarding_entity.dart';
import '../onboarding_types.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class UpdateData {
  UpdateData(this._onboardingRepository);
  final OnboardingRepository _onboardingRepository;

  FutureEitherOnboarding call(OnboardingEntity entity) async =>
      await _onboardingRepository.updateOnboardingData(entity);
}
