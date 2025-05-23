import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/store/models/user_profile_model.dart';

final userProfileProvider =
    StateNotifierProvider<UserProfileStore, UserProfile>(
  (ref) => UserProfileStore(),
);

class UserProfileStore extends StateNotifier<UserProfile> {
  UserProfileStore() : super(const UserProfile());
  void setAuthData(AuthData auth) {
    state = UserProfile(uid: state.uid, auth: auth, info: state.info);
  }

  void updateUserInfo(UserInfo updatedInfo) {
    state = UserProfile(
      uid: state.uid,
      auth: state.auth,
      info: updatedInfo.copyWith(lastUpdated: DateTime.now()),
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
    final newInfo = (state.info ?? const UserInfo()).copyWith(
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
    state = state.copyWith(info: newInfo);
  }
}

// extension on UserProfile {
//   UserProfile copyWith({
//     String? uid,
//     AuthData? auth,
//     UserInfo? info,
//   }) =>
//       UserProfile(
//         uid: uid ?? this.uid,
//         auth: auth ?? this.auth,
//         info: info ?? this.info,
//       );
// }
