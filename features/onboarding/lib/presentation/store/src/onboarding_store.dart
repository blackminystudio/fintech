import 'package:core/core.dart';

import '../../../domain/entities/onboarding_entity.dart';
import '../onboarding_store_provider.dart';
import 'onboarding_state.dart';

class OnboardingStore extends StateNotifier<OnboardingState> {
  OnboardingStore(this.ref) : super(const OnboardingState()) {
    fetchUserInfo();
  }
  final Ref ref;

  Future<void> fetchUserInfo() async {
    state = state.copyWith(status: OnboardingStatus.loading);
    final result = await ref.read(fetchDataProvider)();
    _onFetchResult(result);
  }

  Future<void> updateCopyUserInfo({
    String? mobileNumber,
    String? fullName,
    String? city,
    String? gender,
    String? maritalStatus,
    DateTime? dateOfBirth,
    String? monthlyIncome,
    String? employmentStatus,
    bool toUpdate = false,
  }) async {
    final entity = (state.entity ?? const OnboardingEntity()).copyWith(
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
    state = state.copyWith(entity: entity);
    if (toUpdate) {
      await updateUserInfo(entity);
    }
  }

  Future<void> updateUserInfo(OnboardingEntity entity) async {
    state = state.copyWith(status: OnboardingStatus.loading);
    final result = await ref.read(updateDataProvier).call(entity);
    _onResult(result);
  }

  void _onFetchResult(Either<AppException, OnboardingEntity> result) {
    result.fold(
      (exception) {
        state = state.copyWith(
          exception: exception,
          status: OnboardingStatus.error,
        );
      },
      (entity) {
        state = state.copyWith(
          entity: entity,
          status: OnboardingStatus.completed,
        );
      },
    );
  }

  void _onResult(Either<AppException, Unit> result) {
    result.fold(
      (exception) =>
          state = state.copyWith(
            exception: exception,
            status: OnboardingStatus.error,
          ),
      (unit) => state = state.copyWith(status: OnboardingStatus.completed),
    );
  }
}
