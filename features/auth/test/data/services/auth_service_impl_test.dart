import 'package:auth/data/services/auth_service_impl.dart';
import 'package:core/core.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/auth_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockGoogleSignIn mockGoogle;
  late MockFirebaseAuth mockAuth;
  late AuthServiceImpl service;

  void createService({
    MockUser? user,
    bool signedIn = false,
  }) {
    mockAuth = MockFirebaseAuth(mockUser: user, signedIn: signedIn);
    service = AuthServiceImpl(firebaseAuth: mockAuth, googleSignIn: mockGoogle);
  }

  setUp(() {
    mockGoogle = MockGoogleSignIn();
    createService();
  });

  group('signInWithGoogle()', () {
    test(
      'Given Google sign-in is cancelled '
      'When signInWithGoogle() is called '
      'Then throws AppException with signinCancelled type',
      () async {
        // Given
        mockGoogle.setCancelled(true);

        // When & Then
        await expectLater(
          () => service.signInWithGoogle(),
          throwsA(
            isA<AppException>().having(
              (e) => e.errorType,
              'errorType',
              ErrorType.signinCancelled,
            ),
          ),
        );
      },
    );

    test(
      'Given valid Google sign-in and Firebase success '
      'When signInWithGoogle() is called '
      'Then returns a signed-in user',
      () async {
        // Given
        final user = MockUser(
          uid: 'uid',
          email: 'bob@example.com',
          displayName: 'Bob',
        );
        mockGoogle.setCancelled(false);
        createService(user: user, signedIn: true);

        // When
        final result = await service.signInWithGoogle();

        // Then
        expect(result.uid, user.uid);
        expect(result.email, user.email);
      },
    );
  });

  group('getCurrentUser()', () {
    test(
      'Given no user is signed in '
      'When getCurrentUser() is called '
      'Then returns null',
      () async {
        // Given: no signed-in user

        // When
        final result = await service.getCurrentUser();

        // Then
        expect(result, isNull);
      },
    );

    test(
      'Given a user is signed in '
      'When getCurrentUser() is called '
      'Then returns that user',
      () async {
        // Given
        final user = MockUser(uid: 'u1');
        createService(user: user, signedIn: true);

        // When
        final result = await service.getCurrentUser();

        // Then
        expect(result, same(user));
      },
    );
  });

  group('logout()', () {
    test(
      'Given a user is signed in '
      'When logout() is called '
      'Then signs out from both Firebase and Google',
      () async {
        // Given
        final user = MockUser(email: testEmail);
        final googleSignIn = MockGoogleSignIn();
        mockAuth = MockFirebaseAuth(mockUser: user, signedIn: true);
        service = AuthServiceImpl(
          firebaseAuth: mockAuth,
          googleSignIn: googleSignIn,
        );

        // When
        await service.logout();

        // Then
        expect(mockAuth.currentUser, isNull);
        expect(googleSignIn.currentUser, isNull);
      },
    );
  });

  group('authStateChanges()', () {
    test(
      'Given a signed-in user '
      'When authStateChanges() is listened '
      'Then emits the user as the first event',
      () async {
        // Given
        final user = MockUser(email: testEmail);
        createService(user: user, signedIn: true);

        // When
        final result = await service.authStateChanges().take(1).toList();

        // Then
        expect(result, [user]);
      },
    );

    test(
      'Given no signed-in user '
      'When authStateChanges() is listened '
      'Then emits null as the first event',
      () async {
        // Given: no user
        createService();

        // When
        final result = await service.authStateChanges().take(1).toList();

        // Then
        expect(result, [null]);
      },
    );
  });
}
