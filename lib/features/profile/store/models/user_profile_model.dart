class UserProfile {
  final String uid;
  final AuthData auth;
  final UserInfo? info;

  const UserProfile({
    required this.uid,
    required this.auth,
    this.info,
  });

  bool get isInfoComplete => info?.isComplete ?? false;
}

class AuthData {
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  const AuthData({
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
    required this.lastLoginAt,
  });
}

class UserInfo {
  final String? mobileNumber;
  final String? fullName;
  final String? city;
  final String? gender;
  final String? maritalStatus;
  final DateTime? dateOfBirth;
  final double? monthlyIncome;
  final String? employmentStatus;
  final DateTime? lastUpdated;

  const UserInfo({
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
