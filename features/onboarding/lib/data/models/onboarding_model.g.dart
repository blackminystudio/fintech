// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingModel _$OnboardingModelFromJson(Map<String, dynamic> json) =>
    OnboardingModel(
      mobileNumber: json['mobileNumber'] as String?,
      fullName: json['fullName'] as String?,
      city: json['city'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      dateOfBirth:
          json['dateOfBirth'] == null
              ? null
              : DateTime.parse(json['dateOfBirth'] as String),
      monthlyIncome: json['monthlyIncome'] as String?,
      employmentStatus: json['employmentStatus'] as String?,
      lastUpdated:
          json['lastUpdated'] == null
              ? null
              : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$OnboardingModelToJson(OnboardingModel instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'fullName': instance.fullName,
      'city': instance.city,
      'gender': instance.gender,
      'maritalStatus': instance.maritalStatus,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'monthlyIncome': instance.monthlyIncome,
      'employmentStatus': instance.employmentStatus,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
