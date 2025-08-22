import 'package:core/core.dart';

import '../../domain/entities/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable(createFactory: false)
class AuthModel extends AuthEntity {
  const AuthModel({
    required super.email,
    required super.createdAt,
    required super.lastLoginAt,
    super.displayName,
    super.photoUrl,
  });

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
