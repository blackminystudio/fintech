import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/store/auth_store.dart';
import '../global/di/injector.dart';
import '../services/firebase_options.dart';

class AppModules {
  static Future<void> initialize(ProviderContainer container) async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      try {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        // Trigger and wait for auth state to resolve
        container.read(authStoreProvider.notifier);
        FlutterNativeSplash.remove();
      } catch (e) {
        // Handle initialization error (e.g., log to analytics)
        FlutterNativeSplash.remove();
      }
    }
    injectDependencies();
  }

  static void injectDependencies() {
    // Add any additional dependency injection logic here
    injectRepositories();
    injectServices();
    injectUseCases();
  }
}
