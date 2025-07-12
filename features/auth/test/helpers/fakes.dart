import 'package:auth/domain/entities/auth_entity.dart';
import 'package:auth/domain/use_cases/logout.dart';
import 'package:auth/domain/use_cases/sign_in_with_google.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

class FakePageRouteInfo extends Fake implements PageRouteInfo {}

class FakeSignInWithGoogle extends SignInWithGoogle {
  FakeSignInWithGoogle(this.result) : super(MockAuthRepository());
  final Either<AppException, AuthEntity> result;
  @override
  Future<Either<AppException, AuthEntity>> call() async => result;
}

class FakeLogout extends Logout {
  FakeLogout() : super(MockAuthRepository());
  bool called = false;

  @override
  Future<void> call() async {
    called = true;
  }
}

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

class FirebaseAuthExceptionMock extends Fake
    implements fb.FirebaseAuthException {
  FirebaseAuthExceptionMock({
    this.code = 'test-error',
    this.message = 'something went wrong',
    this.plugin = 'firebase_auth',
  });
  @override
  final String code;
  @override
  final String? message;
  @override
  final String plugin;
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
