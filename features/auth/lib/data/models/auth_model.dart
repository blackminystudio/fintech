import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.email,
    required super.createdAt,
    required super.lastLoginAt,
    super.displayName,
    super.photoUrl,
  });
}
