import 'dart:developer' as dev;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../core.dart';
import '../services/firebase_options.dart';

class AppModules {
  static Future<void> initialize() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    try {
      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await configureDependencies();
    } catch (e) {
      dev.log('Error: $e', name: 'AppModules.initialize');
    } finally {
      FlutterNativeSplash.remove();
      await initLogs();
    }
  }
}

Future<void> initLogs() async {
  if (!getIt.isRegistered<Log>()) {
    dev.log('Log not initialized', name: 'initLogs');
    return;
  }
  final log = getIt<Log>();
  final package = getIt<PackageUtil>();
  final device = await getIt<DeviceUtil>().name();

  await log.console(
    'AppInfo: \n'
    'appName = ${package.appName}, \n'
    'version = ${package.version}, \n'
    'build = ${package.buildNumber}, \n'
    'device = $device,',
    type: LogType.info,
  );
}
