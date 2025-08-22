import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/onboarding_entity.dart';

part 'onboarding_model.g.dart';

@JsonSerializable(createFactory: true)
class OnboardingModel extends OnboardingEntity {
  const OnboardingModel({
    super.mobileNumber,
    super.fullName,
    super.city,
    super.email,
    super.gender,
    super.maritalStatus,
    super.dateOfBirth,
    super.monthlyIncome,
    super.employmentStatus,
    super.lastUpdated,
  });
  factory OnboardingModel.fromEntity(OnboardingEntity entity) =>
      OnboardingModel(
        mobileNumber: entity.mobileNumber,
        fullName: entity.fullName,
        city: entity.city,
        email: entity.email,
        gender: entity.gender,
        maritalStatus: entity.maritalStatus,
        dateOfBirth: entity.dateOfBirth,
        monthlyIncome: entity.monthlyIncome,
        employmentStatus: entity.employmentStatus,
        lastUpdated: entity.lastUpdated,
      );

  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingModelFromJson(json);

  OnboardingEntity toEntity() => OnboardingEntity(
    mobileNumber: mobileNumber,
    fullName: fullName,
    city: city,
    email: email,
    gender: gender,
    maritalStatus: maritalStatus,
    dateOfBirth: dateOfBirth,
    monthlyIncome: monthlyIncome,
    employmentStatus: employmentStatus,
    lastUpdated: lastUpdated,
  );
  Map<String, dynamic> toJson() => _$OnboardingModelToJson(this);
}
