// Package imports:
// ignore_for_file: public_member_api_docs

import 'package:logger/logger.dart';

import '../../core.dart';

enum LogType {
  trace,
  debug,
  info,
  warning,
  error,
  fatal,
}

@LazySingleton()
class Log {
  Log();
  final Logger _logger = getIt<Logger>();

  Future<void> console(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    LogType type = LogType.debug,
  }) async {
    switch (type) {
      case LogType.error:
        _logger.e(message, error: error, stackTrace: stackTrace);
      case LogType.debug:
        _logger.d(message, error: error, stackTrace: stackTrace);
      case LogType.fatal:
        _logger.f(message, error: error, stackTrace: stackTrace);
      case LogType.info:
        _logger.i(message, error: error, stackTrace: stackTrace);
      case LogType.trace:
        _logger.t(message, error: error, stackTrace: stackTrace);
      case LogType.warning:
        _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }
}
