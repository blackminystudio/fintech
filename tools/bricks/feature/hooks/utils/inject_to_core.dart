import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;

/// Injects everything that a new feature needs inside the core package.
///
/// 1. Finds the nearest `core` folder
/// 2. Adds `import 'package:<feature>/<feature>.dart';`
/// 3. Inserts  `ExternalModule(FeaturePackageModule),`
/// 4. Inserts  `...FeatureRouter().routes,`
/// 5. Adds the feature as a dependency in `core/pubspec.yaml`
Future<void> injectIntoCoreFeature(
  Logger logger,
  String featureName,
  Directory featureDir,
) async {
  final pascal = _toPascalCase(featureName); // Abcd
  final importLine = "import 'package:$featureName/$featureName.dart';";
  final moduleLine = 'ExternalModule(${pascal}PackageModule),';
  final routerLine = '...${pascal}Router().routes,';

  // ── 1. locate `core/` folder ─────────────────────────────────────────────
  final coreDir = _findCoreFolder(featureDir);
  if (coreDir == null) {
    logger.err('❌  core/ package not found. Injection skipped.');
    return;
  }
  logger.info(
    '📁 core found: ${p.relative(coreDir.path, from: Directory.current.path)}',
  );

  // Resolve target files
  final locatorFile =
      File(p.join(coreDir.path, 'lib/src/di/service_locator.dart'));
  final appRouterFile =
      File(p.join(coreDir.path, 'lib/src/router/app_router.dart'));
  final corePubspec = File(p.join(coreDir.path, 'pubspec.yaml'));

  if (!locatorFile.existsSync() || !appRouterFile.existsSync()) {
    logger.err(
        '❌  service_locator.dart or app_router.dart missing – cannot inject.');
    return;
  }

  // ── 2. add import lines (if absent) ──────────────────────────────────────
  _addImportIfMissing(locatorFile, importLine, logger);
  _addImportIfMissing(appRouterFile, importLine, logger);

  // ── 3. insert ExternalModule line ────────────────────────────────────────
  _appendIfMissing(
    file: locatorFile,
    marker: 'externalPackageModulesAfter:',
    line: '    $moduleLine',
    logger: logger,
  );

  // ── 4. insert Router line ────────────────────────────────────────────────
  _appendIfMissing(
    file: appRouterFile,
    marker: 'List<AutoRoute> get routes => [',
    line: '    $routerLine',
    logger: logger,
  );

  // ── 5. add dependency to core/pubspec.yaml ───────────────────────────────
  _addFeatureDependency(corePubspec, featureName, featureDir, logger);

  // 🆕 Run flutter pub get in core
  final result = await Process.run('flutter', ['pub', 'get'],
      workingDirectory: coreDir.path);
  if (result.exitCode != 0) {
    logger.err('❌  pub get failed in core:\n${result.stderr}');
  } else {
    logger.info('📦  pub get completed in core/');
  }

  logger.success('✅  Injection completed for $pascal.\n');
}

/*───────────────────────── helpers ─────────────────────────*/

void _addImportIfMissing(File file, String importLine, Logger logger) {
  final content = file.readAsStringSync();
  if (content.contains(importLine)) {
    logger.info('⚠️  import already exists in ${p.basename(file.path)}');
    return;
  }
  file.writeAsStringSync('$importLine\n$content');
  logger.info('➕  import added to ${p.basename(file.path)}');
}

void _appendIfMissing({
  required File file,
  required String marker,
  required String line,
  required Logger logger,
}) {
  final content = file.readAsStringSync();
  if (content.contains(line)) {
    logger.info('⚠️  line already present in ${p.basename(file.path)}');
    return;
  }

  final lines = content.split('\n');
  final out = <String>[];
  var inserted = false;

  for (final l in lines) {
    out.add(l);
    if (!inserted && l.contains(marker)) {
      out.add(line);
      inserted = true;
    }
  }
  file.writeAsStringSync(out.join('\n'));
  logger.info('➕  line injected into ${p.basename(file.path)}');
}

void _addFeatureDependency(
  File pubspec,
  String featureName,
  Directory featureDir,
  Logger logger,
) {
  final content = pubspec.readAsStringSync();
  if (RegExp('^\\s*$featureName:', multiLine: true).hasMatch(content)) {
    logger.info('⚠️  $featureName already in core/pubspec.yaml');
    return;
  }

  final relPath = p.relative(featureDir.path, from: pubspec.parent.path);
  logger.info('🔗  Adding dependency with path: $relPath');

  final lines = content.split('\n');
  final out = <String>[];
  var inserted = false;

  for (final l in lines) {
    out.add(l);
    if (!inserted && l.trim() == 'dependencies:') {
      out
        ..add('  $featureName:')
        ..add('    path: $relPath');
      inserted = true;
    }
  }
  if (!inserted) {
    out.addAll([
      '',
      'dependencies:',
      '  $featureName:',
      '    path: $relPath',
    ]);
  }
  pubspec.writeAsStringSync(out.join('\n'));
  logger.info('✅  core/pubspec.yaml updated');
}

Directory? _findCoreFolder(Directory start) {
  var dir = start;
  while (true) {
    final candidate = Directory(p.join(dir.path, 'core'));
    if (candidate.existsSync()) return candidate;
    final parent = dir.parent;
    if (parent.path == dir.path) break; // reached filesystem root
    dir = parent;
  }
  return null;
}

String _toPascalCase(String input) => input
    .split(RegExp(r'[_\-.]'))
    .map((s) => s.isEmpty ? '' : '${s[0].toUpperCase()}${s.substring(1)}')
    .join();
