import 'package:auth/domain/entities/auth_entity.dart';
import 'package:auth/domain/use_cases/get_loggedin_user.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/auth_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetLoggedInUser usecase;

  setUpAll(() {
    registerFallbackValue(AuthEntity);
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetLoggedInUser(mockAuthRepository);
  });

  group('GetLoggedInUser UseCase', () {
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
      when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
        (_) async => Right(authEntity),
      );

      final result = await usecase();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected a Right but got Left'),
        (value) {
          expect(value, equals(authEntity));
        },
      );

      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });

    test(
        'Given repository returns null '
        'When usecase is called '
        'Then it should return Right(null)', () async {
      when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase();

      expect(
        result,
        const Right<AppException, AuthEntity?>(null),
      );
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });

    test(
        'Given repository throws an AppException '
        'When usecase is called '
        'Then it should return that exception in a Left', () async {
      const failure = AppException(
        code: 'oops',
        source: 'test',
        message: 'something went wrong',
      );
      when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
        (_) async => const Left(failure),
      );

      final result = await usecase();

      expect(result.isLeft(), isTrue);

      result.fold(
        (left) => expect(left, failure),
        (_) => fail('Expected a Left but got Right'),
      );
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });
  });
}
