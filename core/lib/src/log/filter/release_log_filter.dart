// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
// Package imports:
import 'package:logger/logger.dart';

class ReleaseLogFilter extends LogFilter {
  final Set<Level> excludedLevels;
  ReleaseLogFilter({this.excludedLevels = const {}});

  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode && !excludedLevels.contains(event.level);
  }
}
