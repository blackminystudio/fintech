import 'package:core/core.dart';

import '../../../domain/entities/auth_entity.dart';

enum AuthStatus { loading, authenticated, unauthenticated, disabled }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.authEntity,
    this.exception,
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
        status: status ?? this.status,
        exception: exception,
      );

  @override
  List<Object?> get props => [authEntity, exception, status];
}
