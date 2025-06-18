import 'dart:io';

import 'package:auth/modules/auth_module.dart';
import 'package:core/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:home/modules/home_module.dart';

import 'feature_module.dart';

class AppModules {
  static Future<void> initialize() async {
    // Now register each feature’s own dependencies:
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        _initializeDependencyInjection();
        // Trigger and wait for auth state to resolve
        // container.read(authStoreProvider.notifier);
        FlutterNativeSplash.remove();
      } catch (e) {
        // Handle initialization error (e.g., log to analytics)
        FlutterNativeSplash.remove();
      }
    }
  }

  static void _initializeDependencyInjection() {
    final locator = GetIt.instance;
    // TODO: register any core-level singletons here, e.g.:
    // locator.registerLazySingleton<SomeCoreService>(() => SomeCoreService());

    // Now register each feature’s own dependencies:
    final modules = <FeatureModule>[
      AuthModule(),
      HomeModule(),
      // Add future modules here...
    ];

    for (final module in modules) {
      module.registerServices(locator);
    }
  }
}
