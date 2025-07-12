import 'package:auth/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_test_helper.dart';

void main() {
  group('AuthModel', () {
    final base = AuthModel(
      email: testEmail,
      displayName: testDisplayName,
      photoUrl: testPhotoUrl,
      createdAt: testCreatedAt,
      lastLoginAt: testLastLoginAt,
    );

    test(
        'Given two AuthModels with identical data '
        'When comparing them '
        'Then they are equal', () {
      final copy = AuthModel(
        email: base.email,
        displayName: base.displayName,
        photoUrl: base.photoUrl,
        createdAt: base.createdAt,
        lastLoginAt: base.lastLoginAt,
      );

      expect(copy, equals(base));
    });

    test(
        'Given AuthModel '
        'When copyWith is applied '
        'Then only specified fields change', () {
      final changed = base.copyWith(
        displayName: 'Bob',
      );

      expect(changed.email, base.email);
      expect(changed.displayName, 'Bob');
      expect(changed.photoUrl, base.photoUrl);
      expect(changed.createdAt, base.createdAt);
      expect(changed.lastLoginAt, base.lastLoginAt);
    });
  });
}
