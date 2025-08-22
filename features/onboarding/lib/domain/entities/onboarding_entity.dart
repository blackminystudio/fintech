import 'package:core/core.dart';

class OnboardingEntity extends Equatable {
  const OnboardingEntity({
    this.email,
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
  @JsonKey(includeToJson: false)
  final String? email;
  final String? fullName;
  final String? city;
  final String? gender;
  final String? maritalStatus;
  final DateTime? dateOfBirth;
  final String? monthlyIncome;
  final String? employmentStatus;
  final DateTime? lastUpdated;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => super.hashCode;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isComplete =>
      mobileNumber != null &&
      email != null &&
      fullName != null &&
      city != null &&
      gender != null &&
      maritalStatus != null &&
      dateOfBirth != null &&
      monthlyIncome != null &&
      employmentStatus != null;
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [
    mobileNumber,
    fullName,
    city,
    email,
    gender,
    maritalStatus,
    dateOfBirth,
    monthlyIncome,
    employmentStatus,
    lastUpdated,
  ];
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool? get stringify => super.stringify;

  OnboardingEntity copyWith({
    String? mobileNumber,
    String? fullName,
    String? city,
    String? email,
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
    email: email ?? this.email,
    gender: gender ?? this.gender,
    maritalStatus: maritalStatus ?? this.maritalStatus,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    monthlyIncome: monthlyIncome ?? this.monthlyIncome,
    employmentStatus: employmentStatus ?? this.employmentStatus,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );

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
}
