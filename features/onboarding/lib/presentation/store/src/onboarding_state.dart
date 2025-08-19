import 'package:core/core.dart';

import '../../../domain/entities/onboarding_entity.dart';

enum OnboardingStatus { loading, completed, error }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.loading,
    this.onboardingEntity,
    this.exception,
  });

  final OnboardingStatus status;
  final OnboardingEntity? onboardingEntity;
  final AppException? exception;

  OnboardingState copyWith({
    OnboardingEntity? onboardingEntity,
    OnboardingStatus? status,
    AppException? exception,
  }) => OnboardingState(
    onboardingEntity: onboardingEntity ?? this.onboardingEntity,
    status: status ?? this.status,
    exception: exception,
  );

  @override
  List<Object?> get props => [onboardingEntity, exception, status];
}
