import 'dart:async';

import 'package:auth/data/models/auth_model.dart';
import 'package:auth/data/repositories/auth_repository_impl.dart';
import 'package:core/core.dart' hide test;
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/auth_test_helper.dart';
import '../../helpers/mocks.dart';

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
    this.email = testEmail,
    this.displayName = testDisplayName,
    this.photoURL = testPhotoUrl,
  }) : metadata = FakeUserMetadata(
          creationTime: testCreatedAt,
          lastSignInTime: testLastLoginAt,
        );
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  final fb.UserMetadata metadata;
}

void main() {
  late MockAuthService mockAuthService;
  late AuthRepositoryImpl authRepository;

  setUpAll(() {
    registerFallbackValue(FakeFbUser());
    registerFallbackValue(FirebaseAuthExceptionMock());
  });

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepositoryImpl(mockAuthService);
  });

  group('AuthRepositoryImpl.signInWithGoogle', () {
    final user = FakeFbUser();

    test(
        'Given AuthService.signInWithGoogle succeeds '
        'When repository.signInWithGoogle is called '
        'Then it should return Right<AuthModel>', () async {
      when(() => mockAuthService.signInWithGoogle()).thenAnswer(
        (_) async => user,
      );

      final result = await authRepository.signInWithGoogle();

      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Expected Right, got Left($l)'),
        (model) {
          expect(model, isA<AuthModel>());
          expect(model.email, testEmail);
          expect(model.displayName, testDisplayName);
        },
      );

      verify(() => mockAuthService.signInWithGoogle()).called(1);
    });

    test(
        'Given AuthService.signInWithGoogle throws Exception '
        'When repository.signInWithGoogle is called '
        'Then it should return Left<AppException>', () async {
      when(() => mockAuthService.signInWithGoogle()).thenThrow(
        Exception('oops'),
      );

      final result = await authRepository.signInWithGoogle();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<AppException>()),
        (r) => fail('Expected Left, got Right($r)'),
      );

      verify(() => mockAuthService.signInWithGoogle()).called(1);
    });
  });

  group('AuthRepositoryImpl.getCurrentUser', () {
    test(
        'Given AuthService.getCurrentUser returns null '
        'When repository.getCurrentUser is called '
        'Then it should return Right(null)', () async {
      when(() => mockAuthService.getCurrentUser()).thenAnswer(
        (_) async => null,
      );

      final result = await authRepository.getCurrentUser();

      expect(result, const Right<AppException, AuthModel?>(null));
      verify(() => mockAuthService.getCurrentUser()).called(1);
    });

    test(
        'Given AuthService.getCurrentUser returns a User '
        'When repository.getCurrentUser is called '
        'Then it should return Right<AuthModel>', () async {
      final user = FakeFbUser();
      when(() => mockAuthService.getCurrentUser()).thenAnswer(
        (_) async => user,
      );

      final result = await authRepository.getCurrentUser();

      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Expected Right, got Left($l)'),
        (model) {
          expect(model, isNotNull);
          expect(model!.email, testEmail);
        },
      );

      verify(() => mockAuthService.getCurrentUser()).called(1);
    });

    test(
        'Given AuthService.getCurrentUser throws FirebaseAuthException '
        'When repository.getCurrentUser is called '
        'Then it should return Left<AppException>', () async {
      when(() => mockAuthService.getCurrentUser()).thenThrow(
        FirebaseAuthExceptionMock(),
      );

      final result = await authRepository.getCurrentUser();

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<AppException>()),
        (r) => fail('Expected Left, got Right($r)'),
      );

      verify(() => mockAuthService.getCurrentUser()).called(1);
    });
  });

  group('AuthRepositoryImpl.watchAuth', () {
    test(
        'Given authStateChanges emits null '
        'When repository.watchAuth is listened '
        'Then it emits a single Right(null) and completes', () async {
      when(() => mockAuthService.authStateChanges()).thenAnswer(
        (_) => Stream.value(null),
      );

      final events = await authRepository.watchAuth().toList();
      expect(events, [const Right<AppException, AuthModel?>(null)]);
    });

    test(
        'Given authStateChanges emits a User and getCurrentUser succeeds '
        'When repository.watchAuth is listened '
        'Then it emits a single Right<AuthModel>', () async {
      final user = FakeFbUser();
      when(() => mockAuthService.authStateChanges()).thenAnswer(
        (_) => Stream.value(user),
      );
      when(() => mockAuthService.getCurrentUser()).thenAnswer(
        (_) async => user,
      );

      final events = await authRepository.watchAuth().toList();
      expect(events, hasLength(1));
      events.first.fold(
        (l) => fail('Expected Right, got Left($l)'),
        (m) {
          expect(m, isA<AuthModel>());
          expect(m!.email, testEmail);
        },
      );

      verify(() => mockAuthService.authStateChanges()).called(1);
      verify(() => mockAuthService.getCurrentUser()).called(1);
    });

    test(
        'Given authStateChanges emits a User and getCurrentUser throws error '
        'When repository.watchAuth is listened '
        'Then it emits a AppException with Error userDisabled and completes',
        () async {
      final user = FakeFbUser();
      when(() => mockAuthService.authStateChanges()).thenAnswer(
        (_) => Stream.value(user),
      );
      when(() => mockAuthService.getCurrentUser()).thenThrow(
        fb.FirebaseAuthException(code: 'user-disabled'),
      );

      final events = await authRepository.watchAuth().toList();
      expect(events, hasLength(1));
      expect(events.first.isLeft(), isTrue);
      events.first.fold(
        (l) => expect(l.errorType, ErrorType.userDisabled),
        (r) => fail('Expected Left, got Right($r)'),
      );
    });
    test(
        'Given authStateChanges throws '
        'When listening to watchAuth '
        'Then it emits a Left from outer catch and completes', () async {
      when(mockAuthService.authStateChanges).thenAnswer(
        (_) => Stream.error(Exception('boom')),
      );
      final events = await authRepository.watchAuth().toList();
      expect(events, hasLength(1));
      expect(events.first.isLeft(), isTrue);
      events.first.fold(
        (err) => expect(err, isA<AppException>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('AuthRepositoryImpl.logout', () {
    test(
      'Given AuthService.logout succeeds '
      'When repository.logout is called '
      'Then it should forward the call without error',
      () async {
        when(() => mockAuthService.logout()).thenAnswer((_) async {});
        await authRepository.logout();
        verify(() => mockAuthService.logout()).called(1);
      },
    );
  });
}
