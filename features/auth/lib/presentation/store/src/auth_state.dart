import 'package:core/core.dart';

import '../../../domain/entities/auth_entity.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  disabled,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.authEntity,
    this.exception,
  });

  const AuthState.initial({
    this.authEntity,
    this.exception,
    this.status = AuthStatus.initial,
  });

  final AuthStatus status;
  final AuthEntity? authEntity;
  final AppException? exception;

  AuthState copyWith({
    AuthEntity? authEntity,
    AuthStatus? status,
    AppException? exception,
  }) =>
      AuthState(
        authEntity: authEntity ?? this.authEntity,
        exception: exception ?? this.exception,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        authEntity,
        exception,
        status,
      ];
}
