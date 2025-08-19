import 'package:core/core.dart';

class OnboardingEntity extends Equatable {
  const OnboardingEntity({
    this.mobileNumber,
    this.fullName,
    this.city,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.monthlyIncome,
    this.employmentStatus,
    this.lastUpdated,
  });

  final String? mobileNumber;
  final String? fullName;
  final String? city;
  final String? gender;
  final String? maritalStatus;
  final DateTime? dateOfBirth;
  final String? monthlyIncome;
  final String? employmentStatus;
  final DateTime? lastUpdated;

  OnboardingEntity copyWith({
    String? id,
    String? mobileNumber,
    String? fullName,
    String? city,
    String? gender,
    String? maritalStatus,
    DateTime? dateOfBirth,
    String? monthlyIncome,
    String? employmentStatus,
    DateTime? lastUpdated,
  }) => OnboardingEntity(
    mobileNumber: mobileNumber ?? this.mobileNumber,
    fullName: fullName ?? this.fullName,
    city: city ?? this.city,
    gender: gender ?? this.gender,
    maritalStatus: maritalStatus ?? this.maritalStatus,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    monthlyIncome: monthlyIncome ?? this.monthlyIncome,
    employmentStatus: employmentStatus ?? this.employmentStatus,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );

  @override
  List<Object?> get props => [
    mobileNumber,
    fullName,
    city,
    gender,
    maritalStatus,
    dateOfBirth,
    monthlyIncome,
    employmentStatus,
    lastUpdated,
  ];

  double getPercentage() {
    final fields = [
      mobileNumber,
      fullName,
      city,
      gender,
      maritalStatus,
      dateOfBirth,
      monthlyIncome,
      employmentStatus,
    ];

    final filled = fields.where((field) => field != null).length;
    return filled / fields.length;
  }

  bool get isComplete =>
      mobileNumber != null &&
      fullName != null &&
      city != null &&
      gender != null &&
      maritalStatus != null &&
      dateOfBirth != null &&
      monthlyIncome != null &&
      employmentStatus != null;
}
