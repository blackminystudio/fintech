import '../../onboarding.dart';

abstract class OnboardingService {
  Future<OnboardingModel> fetchData();
  void updateData(OnboardingModel model);
}
