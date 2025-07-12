import 'package:auth/domain/use_cases/logout.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late Logout useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = Logout(mockAuthRepository);
  });

  group('Logout UseCase', () {
    test(
        'Given repository completes successfully '
        'When usecase is called '
        'Then it should complete without error and call logout() once',
        () async {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});
      await useCase();
      verify(() => mockAuthRepository.logout()).called(1);
    });

    test(
        'Given repository throws AppException '
        'When usecase is called '
        'Then it should rethrow that exception', () async {
      const failure = AppException(
        source: 'test',
        code: 'logout-failed',
        message: 'Logout failed',
      );
      when(() => mockAuthRepository.logout()).thenThrow(failure);
      expect(() => useCase(), throwsA(failure));
      verify(() => mockAuthRepository.logout()).called(1);
    });
  });
}
