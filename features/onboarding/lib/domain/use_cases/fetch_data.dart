import 'package:core/core.dart';

import '../onboarding_types.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class FetchData {
  FetchData(this._onboardingRepository);
  final OnboardingRepository _onboardingRepository;

  FutureEitherOnboardingEntity call() async =>
      await _onboardingRepository.fetchOnboardingData();
}
