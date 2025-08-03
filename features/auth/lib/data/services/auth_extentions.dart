import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_model.dart';

extension UserExtension on User {
  AuthModel toAuthModel() {
    final m = metadata;
    return AuthModel(
      email: email ?? '',
      displayName: displayName,
      photoUrl: photoURL,
      createdAt: m.creationTime ?? DateTime.now(),
      lastLoginAt: m.lastSignInTime ?? DateTime.now(),
    );
  }
}
