// ignore_for_file: public_member_api_docs

import 'package:logger/logger.dart';

class SimplePrettyPrinter extends PrettyPrinter {
  SimplePrettyPrinter();

  @override
  bool get colors => true;

  @override
  bool get printEmojis => true;

  @override
  int? get methodCount => 0;

  @override
  int? get errorMethodCount => 5;

  @override
  int get lineLength => 120;

  @override
  DateTimeFormatter get dateTimeFormat => DateTimeFormat.dateAndTime;

  @override
  Map<Level, AnsiColor>? get levelColors => {
        Level.info: const AnsiColor.fg(178), // Golden
        Level.warning: const AnsiColor.fg(214), // Orange
        Level.debug: const AnsiColor.fg(150), // Green
        Level.trace: const AnsiColor.fg(8), // Grey
        Level.error: const AnsiColor.fg(196), // Red
        Level.fatal: const AnsiColor.fg(199), // Magenta
      };

  @override
  Map<Level, String>? get levelEmojis =>
      super.levelEmojis ??
      {
        Level.info: '💡',
        Level.warning: '⚠️',
        Level.debug: '🐛',
        Level.trace: '🔍',
        Level.error: '❌',
        Level.fatal: '💀',
      };

  @override
  List<String> log(LogEvent event) {
    final levelColor = levelColors?[event.level] ?? const AnsiColor.none();
    final levelName = event.level.name.toUpperCase().padRight(5);
    final rawPrefix = '[$levelName]';
    final coloredPrefix = levelColor(rawPrefix);
    final lines = super.log(event);
    return lines.map((line) => '$coloredPrefix $line').toList();
  }
}
