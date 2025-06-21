import 'package:core/core.dart';

import '../../../global/model/user_profile_model.dart';

enum AuthStateStatus { initial, loading, loaded, failure }

class AuthState extends Equatable {
  const AuthState({
    this.userProfile,
    this.hasData = false,
    this.message = '',
    this.status = AuthStateStatus.initial,
    this.isLoading = false,
  });

  const AuthState.initial({
    this.userProfile,
    this.hasData = false,
    this.message = '',
    this.status = AuthStateStatus.initial,
    this.isLoading = false,
  });

  final UserProfile? userProfile;
  final bool hasData;
  final String message;
  final AuthStateStatus status;
  final bool isLoading;

  AuthState copyWith({
    UserProfile? userProfile,
    bool? hasData,
    String? message,
    AuthStateStatus? status,
    bool? isLoading,
  }) =>
      AuthState(
        userProfile: userProfile ?? this.userProfile,
        message: message ?? this.message,
        hasData: hasData ?? this.hasData,
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [userProfile, hasData, message, status, isLoading];
}
