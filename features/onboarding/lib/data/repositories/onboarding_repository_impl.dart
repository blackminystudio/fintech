import 'package:core/core.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../services/onboarding_service.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl extends OnboardingRepository {
  OnboardingRepositoryImpl(this.service);
  OnboardingService service;
}
