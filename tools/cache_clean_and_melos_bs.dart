import 'dart:convert';
import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

Future<void> main() async {
  print('Starting cache clean and melos bootstrap script.');
  final configFile = File('tools/cache_clean_script_config.json');
  final config =
      json.decode(await configFile.readAsString()) as Map<String, dynamic>;

  if (config['skipMelosActivation'] == false) {
    // To ensure latest version of melos is installed
    print('Activating melos globally...');
    await runProcess('dart', ['pub', 'global', 'activate', 'melos']);
  }

  if (config['skipPubspecLockRemoval'] == false) {
    // Removing pubspec.lock files
    print('Removing pubspec.lock files...');
    await removeFiles('**/pubspec.lock');
  }

  if (config['skipPubspecOverridesRemoval'] == false) {
    // Removing pubspec_overrides.yaml files
    print('Removing pubspec_overrides.yaml files...');
    await removeFiles('**/pubspec_overrides.yaml');
  }

  if (config['skipFlutterClean'] == false) {
    // Removing .dart_tool and build directories
    print('Running "flutter clean" on all packages...');
    await runProcess('melos', ['exec', 'flutter', 'clean']);
  }

  if (config['skipMelosClean'] == false) {
    // Run melos clean
    print('Running melos clean...');
    await runProcess('melos', ['clean']);
  }

  if (config['skipFlutterPubCacheClean'] == false) {
    // Clean Flutter pub cache
    print('Cleaning Flutter pub cache...');
    await runProcess('dart', ['pub', 'cache', 'clean']);
  }

  // Activate melos globally using dart pub
  print('Activating melos globally...');
  await runProcess('dart', ['pub', 'global', 'activate', 'melos']);

  if (config['skipMelosBootstrap'] == false) {
    // Run 'pub get' in the project root to fetch dependencies
    print('Running "pub get" in the project root...');
    await runProcess('flutter', ['pub', 'get']);

    // Bootstrap using melos with retries
    const maxRetries = 5;
    var retryCount = 0;
    var success = false;

    print('Starting melos bootstrap process...');
    while (retryCount < maxRetries && !success) {
      final result = await runProcess('melos', ['bootstrap']);
      if (result) {
        success = true;
        print('melos bootstrap succeeded after $retryCount retries.');
      } else {
        print('melos bootstrap failed, retrying...');
        retryCount++;
        await Future.delayed(const Duration(seconds: 5));
      }
    }
    if (!success) {
      print(
        'melos bootstrap failed after $retryCount retries.'
        ' Please check for errors and try again.',
      );
    } else {
      print('Script completed successfully.');
    }
  }
}

Future<void> removeFiles(String pattern) async {
  final glob = Glob(pattern);
  await for (final entity in glob.list()) {
    if (entity is File) {
      try {
        await entity.delete();
        print('Deleted file: ${entity.path}');
      } catch (e) {
        print('Error deleting file ${entity.path}: $e');
      }
    }
  }
}

Future<bool> runProcess(String command, List<String> arguments) async {
  print('Executing: $command ${arguments.join(' ')}');

  final process = await Process.start(command, arguments, runInShell: true);

  process.stdin.writeln('Y');
  await process.stdin.flush();
  await process.stdin.close();

  final stdoutSubscription = process.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen(print);

  final stderrSubscription = process.stderr
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
        print('Error: $line');
      });

  // Wait for the process to complete and then cancel the subscriptions.
  final exitCode = await process.exitCode;
  await stdoutSubscription.cancel();
  await stderrSubscription.cancel();

  return exitCode == 0;
}
