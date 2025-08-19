import 'package:core/core.dart';

import 'onboarding_state.dart';

class OnboardingStore extends StateNotifier<OnboardingState> {
  OnboardingStore(this.ref) : super(const OnboardingState());
  final Ref ref;
}
