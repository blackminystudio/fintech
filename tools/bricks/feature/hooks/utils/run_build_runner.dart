import 'dart:io';

import 'package:mason/mason.dart';

import 'logs/print_section.dart';

Future<double> runBuildRunner(HookContext context, Directory dir) async {
  final logger = context.logger;
  printSectionHeader(logger, '🛠️  Step 2: Running `build_runner`');

  final sw = Stopwatch()..start();
  final result = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: dir.path,
  );

  stdout.write(result.stdout);
  stderr.write(result.stderr);

  final elapsed = sw.elapsed.inMilliseconds / 1000;
  return elapsed;
}
