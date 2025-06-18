import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/store/auth_store_provider.dart';
import '../global/di/injector.dart';
// import '../../../core/lib/services/firebase_options.dart';

class AppModules {
  static Future<void> initialize(ProviderContainer container) async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      try {
        // await Firebase.initializeApp(
        //   options: DefaultFirebaseOptions.currentPlatform,
        // );
        injectDependencies();
        // Trigger and wait for auth state to resolve
        container.read(authStoreProvider.notifier);
        FlutterNativeSplash.remove();
      } catch (e) {
        // Handle initialization error (e.g., log to analytics)
        FlutterNativeSplash.remove();
      }
    }
  }

  static void injectDependencies() {
    // Add any additional dependency injection logic here
    injectRepositories();
    injectServices();
    injectUseCases();
  }
}
