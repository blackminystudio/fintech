import 'package:core/core.dart';

import '../../../domain/entities/onboarding_entity.dart';

enum OnboardingStatus { loading, completed, error }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.loading,
    this.entity,
    this.exception,
  });

  final OnboardingStatus status;
  final OnboardingEntity? entity;
  final AppException? exception;

  OnboardingState copyWith({
    OnboardingEntity? entity,
    OnboardingStatus? status,
    AppException? exception,
  }) => OnboardingState(
    entity: entity ?? this.entity,
    status: status ?? this.status,
    exception: exception,
  );

  @override
  List<Object?> get props => [entity, exception, status];
}
