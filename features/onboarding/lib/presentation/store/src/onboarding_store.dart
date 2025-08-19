import 'package:core/core.dart';

import '../../../domain/entities/onboarding_entity.dart';
import 'onboarding_state.dart';

class OnboardingStore extends StateNotifier<OnboardingState> {
  OnboardingStore(this.ref) : super(const OnboardingState());
  final Ref ref;

  void updateUserInfo(OnboardingEntity onboardingEntity) {
    state = state.copyWith(
      onboardingEntity: onboardingEntity.copyWith(lastUpdated: DateTime.now()),
    );
  }

  void updateCopyUserInfo({
    String? mobileNumber,
    String? fullName,
    String? city,
    String? gender,
    String? maritalStatus,
    DateTime? dateOfBirth,
    String? monthlyIncome,
    String? employmentStatus,
  }) {
    final onboardingEntity =
        (state.onboardingEntity ?? const OnboardingEntity()).copyWith(
          mobileNumber: mobileNumber,
          fullName: fullName,
          city: city,
          gender: gender,
          maritalStatus: maritalStatus,
          dateOfBirth: dateOfBirth,
          monthlyIncome: monthlyIncome,
          employmentStatus: employmentStatus,
          lastUpdated: DateTime.now(),
        );
    state = state.copyWith(onboardingEntity: onboardingEntity);
  }
}
