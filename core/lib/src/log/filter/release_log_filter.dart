// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
// Package imports:
import 'package:logger/logger.dart';

class ReleaseLogFilter extends LogFilter {
  ReleaseLogFilter({this.excludedLevels = const {}});
  final Set<Level> excludedLevels;

  @override
  bool shouldLog(LogEvent event) =>
      kDebugMode && !excludedLevels.contains(event.level);
}
