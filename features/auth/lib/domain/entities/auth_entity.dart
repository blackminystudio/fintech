import 'package:core/core.dart';

class AuthEntity extends Equatable {
  const AuthEntity({
    required this.email,
    required this.createdAt,
    required this.lastLoginAt,
    this.displayName,
    this.photoUrl,
  });
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => super.hashCode;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [
    email,
    createdAt,
    lastLoginAt,
    displayName,
    photoUrl,
  ];

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  bool? get stringify => super.stringify;

  AuthEntity copyWith({
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) => AuthEntity(
    email: email ?? this.email,
    displayName: displayName ?? this.displayName,
    photoUrl: photoUrl ?? this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    lastLoginAt: lastLoginAt ?? this.lastLoginAt,
  );
}
