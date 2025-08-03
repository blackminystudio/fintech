import 'package:auth/domain/entities/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_test_helper.dart';

void main() {
  group('AuthEntity Value Object', () {
    final baseAuthEntity = AuthEntity(
      email: testEmail,
      displayName: testDisplayName,
      photoUrl: testPhotoUrl,
      createdAt: testCreatedAt,
      lastLoginAt: testLastLoginAt,
    );

    test('Given a newly constructed entity '
        'When inspecting its fields '
        'Then all properties match the constructor arguments', () {
      expect(baseAuthEntity.email, testEmail);
      expect(baseAuthEntity.displayName, testDisplayName);
      expect(baseAuthEntity.photoUrl, testPhotoUrl);
      expect(baseAuthEntity.createdAt, testCreatedAt);
      expect(baseAuthEntity.lastLoginAt, testLastLoginAt);
    });

    test('Given an entity '
        'When copyWith() is called with partial overrides '
        'Then only those fields change and others remain intact', () {
      final updatedAuthEntity = baseAuthEntity.copyWith(
        email: newEmail,
        lastLoginAt: newLastLogin,
      );
      expect(updatedAuthEntity.email, newEmail);
      expect(updatedAuthEntity.lastLoginAt, newLastLogin);
      expect(updatedAuthEntity.displayName, baseAuthEntity.displayName);
      expect(updatedAuthEntity.photoUrl, baseAuthEntity.photoUrl);
      expect(updatedAuthEntity.createdAt, baseAuthEntity.createdAt);
    });

    test('Given an entity '
        'When copyWith() is called with no arguments '
        'Then a new instance is returned with identical values', () {
      final copyAuthEntity = baseAuthEntity.copyWith();

      expect(copyAuthEntity, isNot(same(baseAuthEntity)));
      expect(copyAuthEntity.email, baseAuthEntity.email);
      expect(copyAuthEntity.displayName, baseAuthEntity.displayName);
      expect(copyAuthEntity.photoUrl, baseAuthEntity.photoUrl);
      expect(copyAuthEntity.createdAt, baseAuthEntity.createdAt);
      expect(copyAuthEntity.lastLoginAt, baseAuthEntity.lastLoginAt);
    });

    test('Given two separate instances constructed with the same data '
        'When comparing them '
        'Then they are considered equal by value', () {
      final otherAuthEntity = AuthEntity(
        email: baseAuthEntity.email,
        displayName: baseAuthEntity.displayName,
        photoUrl: baseAuthEntity.photoUrl,
        createdAt: baseAuthEntity.createdAt,
        lastLoginAt: baseAuthEntity.lastLoginAt,
      );

      expect(otherAuthEntity, equals(baseAuthEntity));
    });
  });
}
