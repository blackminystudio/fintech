enum UserStatus { active, disabled }

class UserProfile {
  const UserProfile({
    this.uid,
    this.auth,
    this.info,
    this.status = UserStatus.active,
  });

  final String? uid;
  final AuthData? auth;
  final UserInfo? info;
  final UserStatus status;

  bool get isInfoComplete => info?.isComplete ?? false;
  bool get isDisabled => status == UserStatus.disabled;

  UserProfile copyWith({
    String? uid,
    AuthData? auth,
    UserInfo? info,
  }) =>
      UserProfile(
        uid: uid ?? this.uid,
        auth: auth ?? this.auth,
        info: info ?? this.info,
      );
}

class AuthData {
  factory AuthData.create({
    required String email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) =>
      AuthData._internal(
        email,
        displayName,
        photoUrl,
        createdAt ?? DateTime.now(),
        lastLoginAt ?? DateTime.now(),
      );

  // private constructor
  const AuthData._internal(
    this.email,
    this.displayName,
    this.photoUrl,
    this.createdAt,
    this.lastLoginAt,
  );
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastLoginAt;
}

class UserInfo {
  factory UserInfo.create({
    String? mobileNumber,
    String? fullName,
    String? city,
    String? gender,
    String? maritalStatus,
    DateTime? dateOfBirth,
    String? monthlyIncome,
    String? employmentStatus,
    DateTime? lastUpdated,
  }) =>
      UserInfo._internal(
        mobileNumber: mobileNumber,
        fullName: fullName,
        city: city,
        gender: gender,
        maritalStatus: maritalStatus,
        dateOfBirth: dateOfBirth,
        monthlyIncome: monthlyIncome,
        employmentStatus: employmentStatus,
        lastUpdated: lastUpdated,
      );

  // private constructor
  const UserInfo._internal({
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

  UserInfo copyWith({
    String? mobileNumber,
    String? fullName,
    String? city,
    String? gender,
    String? maritalStatus,
    DateTime? dateOfBirth,
    String? monthlyIncome,
    String? employmentStatus,
    DateTime? lastUpdated,
  }) =>
      UserInfo._internal(
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
