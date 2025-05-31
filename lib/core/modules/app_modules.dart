import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../services/firebase_options.dart';

class AppModules {
  static Future<void> _testFirebaseInit() async {
    await FirebaseFirestore.instance.collection('tests').doc('1234').set({
      'name': 'Test User',
      'createdAt': FieldValue.serverTimestamp(),
      'success': true,
    });
  }

  static Future<void> initialize() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // Only run splash logic outside test
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      // TODO: Dev only, remove in production
      await Future.delayed(const Duration(seconds: 5));
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterNativeSplash.remove();
      await _testFirebaseInit();
    }
  }
}
