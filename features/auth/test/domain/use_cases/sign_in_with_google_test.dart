import 'package:auth/domain/entities/auth_entity.dart';
import 'package:auth/domain/use_cases/sign_in_with_google.dart';
import 'package:core/core.dart' hide test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/auth_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithGoogle useCase;

  setUpAll(() {
    registerFallbackValue(
      AuthEntity(
        email: testEmail,
        displayName: testDisplayName,
        photoUrl: testPhotoUrl,
        createdAt: testCreatedAt,
        lastLoginAt: testLastLoginAt,
      ),
    );
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignInWithGoogle(mockAuthRepository);
  });

  group('SignInWithGoogle UseCase', () {
    test(
        'Given repository returns a valid AuthEntity '
        'When usecase is called '
        'Then it should forward the same AuthEntity in a Right', () async {
      final authEntity = AuthEntity(
        email: testEmail,
        displayName: testDisplayName,
        photoUrl: testPhotoUrl,
        createdAt: testCreatedAt,
        lastLoginAt: testLastLoginAt,
      );
      when(() => mockAuthRepository.signInWithGoogle()).thenAnswer(
        (_) async => Right(authEntity),
      );

      final result = await useCase();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected a Right but got Left'),
        (value) => expect(value, equals(authEntity)),
      );
      verify(() => mockAuthRepository.signInWithGoogle()).called(1);
    });

    test(
        'Given repository throws an AppException '
        'When usecase is called '
        'Then it should return that exception in a Left', () async {
      const failure = AppException(
        source: 'test',
        code: 'google-fail',
        message: 'Google sign-in failed.',
        errorType: ErrorType.invalidCredential,
      );
      when(() => mockAuthRepository.signInWithGoogle()).thenAnswer(
        (_) async => const Left(failure),
      );

      final result = await useCase();

      expect(result.isLeft(), isTrue);
      result.fold(
        (left) => expect(left, failure),
        (_) => fail('Expected a Left but got Right'),
      );
      verify(() => mockAuthRepository.signInWithGoogle()).called(1);
    });
  });
}
