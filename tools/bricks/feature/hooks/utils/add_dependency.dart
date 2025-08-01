import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;

import 'logs/print_section.dart';

/// Adds or updates the `core:` dependency in the pubspec.yaml
Future<void> addCoreDependencyIfMissing(
  Logger logger,
  Directory targetDir,
) async {
  printSectionHeader(logger, '🔍 Searching for "core" in the project...');

  final pubspecFile = File(p.join(targetDir.path, 'pubspec.yaml'));
  if (!pubspecFile.existsSync()) {
    logger.err('❌ pubspec.yaml not found in ${targetDir.path}');
    exit(1); // Stop hook execution
  }

  // Traverse upwards to find the project root
  var rootDir = targetDir;
  while (!Directory(p.join(rootDir.path, '.git')).existsSync() &&
      rootDir.parent.path != rootDir.path) {
    rootDir = rootDir.parent;
  }

  // Recursively look for "core/pubspec.yaml" inside the project
  Directory? coreDir;
  await for (final entity in rootDir.list(recursive: true)) {
    if (entity is Directory && p.basename(entity.path) == 'core') {
      final pubspec = File(p.join(entity.path, 'pubspec.yaml'));
      if (pubspec.existsSync()) {
        coreDir = entity;
        break;
      }
    }
  }

  if (coreDir == null) {
    logger.err('❌ Could not find a valid "core" package in the project.');
    exit(1); // Stop hook execution
  }

  final relativePath = p.relative(coreDir.path, from: targetDir.path);
  logger.info(
    '📁 Detected core at: $relativePath',
  );

  // Read pubspec.yaml
  final lines = pubspecFile.readAsLinesSync();
  var coreAdded = false;
  final buffer = <String>[];

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    buffer.add(line);

    // Add after "dependencies:" if not present
    if (line.trim() == 'dependencies:' && !coreAdded) {
      buffer
        ..add('  core:')
        ..add('    path: $relativePath');
      coreAdded = true;
    }

    // If already exists, update
    if (line.trim() == 'core:' &&
        i + 1 < lines.length &&
        lines[i + 1].contains('path:')) {
      buffer[i + 1] = '    path: $relativePath';
      coreAdded = true;
      i++; // skip next line
    }
  }

  // If dependencies not found at all
  if (!coreAdded) {
    buffer.addAll([
      '',
      'dependencies:',
      '  core:',
      '    path: $relativePath',
    ]);
  }

  await pubspecFile.writeAsString(buffer.join('\n'));
  logger.success('✅ pubspec.yaml updated with dynamic core path.');
}
