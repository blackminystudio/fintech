import 'package:auth/domain/entities/auth_entity.dart';
import 'package:auth/presentation/store/src/auth_state.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/auth_test_helper.dart';

void main() {
  group('AuthState', () {
    final baseEntity = AuthEntity(
      email: testEmail,
      createdAt: testCreatedAt,
      lastLoginAt: testLastLoginAt,
      displayName: testDisplayName,
      photoUrl: testPhotoUrl,
    );

    final updatedEntity = baseEntity.copyWith(email: testUpdatedEmail);
    const exception = AppException(source: testPlugin, message: testMessage);

    group('Constructor', () {
      test('Given no arguments '
          'When constructed '
          'Then defaults to unauthenticated with null fields', () {
        const state = AuthState();
        expect(state.status, AuthStatus.unauthenticated);
        expect(state.authEntity, isNull);
        expect(state.exception, isNull);
      });
    });

    group('copyWith', () {
      test('Given a base state '
          'When copyWith is called with all fields '
          'Then creates updated state', () {
        const state = AuthState();
        final copied = state.copyWith(
          status: AuthStatus.authenticated,
          authEntity: baseEntity,
          exception: exception,
        );

        expect(copied.status, AuthStatus.authenticated);
        expect(copied.authEntity, baseEntity);
        expect(copied.exception, exception);
      });

      test('Given a state with exception '
          'When copyWith is called without exception '
          'Then clears exception', () {
        final state = AuthState(
          status: AuthStatus.authenticated,
          authEntity: baseEntity,
          exception: exception,
        );

        final copied = state.copyWith(status: AuthStatus.loading);

        expect(copied.status, AuthStatus.loading);
        expect(copied.authEntity, baseEntity);
        expect(copied.exception, isNull);
      });

      test('Given a state '
          'When copyWith is called without arguments '
          'Then preserves authEntity and status', () {
        final state = AuthState(
          status: AuthStatus.authenticated,
          authEntity: baseEntity,
        );

        final copied = state.copyWith();

        expect(copied.status, AuthStatus.authenticated);
        expect(copied.authEntity, baseEntity);
        expect(copied.exception, isNull);
      });
    });

    group('Equatable', () {
      test('Given two identical auth states '
          'When compared '
          'Then returns true', () {
        final a = AuthState(
          status: AuthStatus.authenticated,
          authEntity: baseEntity,
          exception: exception,
        );

        final b = AuthState(
          status: AuthStatus.authenticated,
          authEntity: baseEntity,
          exception: exception,
        );

        expect(a, equals(b));
      });

      test('Given states with different auth status '
          'When compared '
          'Then returns false', () {
        const a = AuthState(status: AuthStatus.authenticated);
        const b = AuthState();
        expect(a, isNot(equals(b)));
      });

      test('Given states with different authEntity '
          'When compared '
          'Then returns false', () {
        final a = AuthState(
          status: AuthStatus.authenticated,
          authEntity: baseEntity,
        );
        final b = AuthState(
          status: AuthStatus.authenticated,
          authEntity: updatedEntity,
        );
        expect(a, isNot(equals(b)));
      });

      test('Given states with different exceptions '
          'When compared '
          'Then returns false', () {
        const a = AuthState(
          status: AuthStatus.authenticated,
          exception: exception,
        );
        const b = AuthState(status: AuthStatus.authenticated);
        expect(a, isNot(equals(b)));
      });
    });
  });
}
