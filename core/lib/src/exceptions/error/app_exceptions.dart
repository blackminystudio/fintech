import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'error_map.dart';
import 'error_type.dart';

class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.source,
    this.stackTrace,
    this.errorType = ErrorType.unknown,
  });

  factory AppException.fromService(dynamic error, StackTrace stackTrace) {
    var message = error.toString();
    String? code = 'unknown';
    String? source = 'Firebase';
    var errorType = ErrorType.unknown;

    if (error is FirebaseAuthException) {
      final mapping = errorMap[error.code];
      message = mapping?.$2 ?? error.message ?? 'Firebase Auth error';
      code = error.code;
      source = 'FirebaseAuth';
      errorType = mapping?.$1 ?? ErrorType.unknown;
    } else if (error is FirebaseException) {
      final mapping = errorMap[error.code];
      message = mapping?.$2 ?? error.message ?? 'Firebase error';
      code = error.code;
      source = error.plugin;
      errorType = mapping?.$1 ?? ErrorType.unknown;
    } else if (error is AppException) {
      message = error.message;
      code = error.code;
      source = error.source;
      errorType = error.errorType;
    }

    return AppException(
      message: message,
      code: code,
      source: source,
      stackTrace: stackTrace,
      errorType: errorType,
    );
  }
  final String message;
  final String? code;
  final String? source;
  final ErrorType errorType;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      'message: $message, '
      'code: $code, '
      'source: $source, '
      'stackTrace: $stackTrace, '
      'errorType: $errorType';
}

extension AppExceptionExtension on AppException {
  Left<AppException, T> toLeft<T>() => Left<AppException, T>(this);
}
