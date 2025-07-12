import 'package:auth/data/services/auth_extentions.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_test_helper.dart';

class FakeUserMetadata extends Fake implements fb.UserMetadata {
  FakeUserMetadata({
    required this.creationTime,
    required this.lastSignInTime,
  });
  @override
  final DateTime? creationTime;
  @override
  final DateTime? lastSignInTime;
}

class FakeFbUser extends Fake implements fb.User {
  FakeFbUser({
    String? email,
    String? displayName,
    String? photoURL,
    DateTime? creationTime,
    DateTime? lastSignInTime,
  })  : metadata = FakeUserMetadata(
          creationTime: creationTime,
          lastSignInTime: lastSignInTime,
        ),
        _email = email,
        _displayName = displayName,
        _photoURL = photoURL;

  final String? _email;
  final String? _displayName;
  final String? _photoURL;

  @override
  String? get email => _email;
  @override
  String? get displayName => _displayName;
  @override
  String? get photoURL => _photoURL;
  @override
  final fb.UserMetadata metadata;
}

void main() {
  group('UserExtension.toAuthModel', () {
    test(
        'Given a Firebase User with full metadata, '
        'when toAuthModel() is called, '
        'then it produces an AuthModel with matching fields', () {
      final fb.User fake = FakeFbUser(
        email: testEmail,
        displayName: testDisplayName,
        photoURL: testPhotoUrl,
        creationTime: testCreatedAt,
        lastSignInTime: testLastLoginAt,
      );

      final model = fake.toAuthModel();

      expect(model.email, testEmail);
      expect(model.displayName, testDisplayName);
      expect(model.photoUrl, testPhotoUrl);
      expect(model.createdAt, testCreatedAt);
      expect(model.lastLoginAt, testLastLoginAt);
    });

    test(
        'Given a Firebase User with null email/displayName/photoURL, '
        'when toAuthModel() is called, '
        'then defaults are applied correctly', () {
      final fb.User fake = FakeFbUser(
        creationTime: testCreatedAt,
        lastSignInTime: testLastLoginAt,
      );

      final model = fake.toAuthModel();

      expect(model.email, isEmpty);
      expect(model.displayName, isNull);
      expect(model.photoUrl, isNull);
      expect(model.createdAt, testCreatedAt);
      expect(model.lastLoginAt, testLastLoginAt);
    });

    test(
        'Given metadata missing creation or sign-in times, '
        'when toAuthModel() is called, '
        'then fallback to DateTime.now() for missing values', () {
      final fb.User fake = FakeFbUser(
        email: testEmail,
        displayName: testDisplayName,
        photoURL: testPhotoUrl,
      );

      final after = DateTime.now();
      final before = DateTime.now();
      final model = fake.toAuthModel();
      final afterAdd = after.add(const Duration(seconds: 1));
      final beforeSubtract = before.subtract(const Duration(seconds: 1));

      expect(model.email, testEmail);
      expect(model.createdAt.isAfter(beforeSubtract), isTrue);
      expect(model.createdAt.isBefore(afterAdd), isTrue);
      expect(model.lastLoginAt.isAfter(beforeSubtract), isTrue);
      expect(model.lastLoginAt.isBefore(afterAdd), isTrue);
    });
  });
}
