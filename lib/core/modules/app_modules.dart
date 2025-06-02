import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/store/auth_store.dart';
import '../services/firebase_options.dart';

class AppModules {
  static Future<void> initialize(ProviderContainer container) async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      // ✅ Initialize Flutter Native Splash
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // ✅ Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterNativeSplash.remove();

      // ✅ Trigger auth state loading
      container.read(authStoreProvider.notifier);
    }
  }
}
