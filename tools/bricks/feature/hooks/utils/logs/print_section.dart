import 'package:mason/mason.dart';

void printSectionHeader(Logger logger, String title) {
  logger
    ..info('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    ..info(title)
    ..info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
}
