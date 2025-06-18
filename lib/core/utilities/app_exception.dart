import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Error/error_map.dart';
import 'Error/error_type.dart';

class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.source,
    this.errorType = ErrorType.unknown,
  });

  factory AppException.fromFirebaseException(dynamic error) {
    var message = 'Firebase error';
    String? code;
    String? source;
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
    } else {
      message = error.toString();
      code = 'unknown';
      source = 'Firebase';
      errorType = ErrorType.unknown;
    }

    return AppException(
      message: message,
      code: code,
      source: source,
      errorType: errorType,
    );
  }
  final String message;
  final String? code;
  final String? source;
  final ErrorType errorType;

  @override
  String toString() => 'message: $message, '
      'code: $code, '
      'source: $source, '
      'errorType: $errorType';
}

extension AppExceptionExtension on AppException {
  Left<AppException, T> toLeft<T>() => Left<AppException, T>(this);
}
