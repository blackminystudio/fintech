import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miny_design_system/miny_design_system.dart';

import 'core/router/app_router.dart';
import 'core/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Optional test data
  await FirebaseFirestore.instance.collection('tests').add({
    'name': 'Test User',
    'createdAt': FieldValue.serverTimestamp(),
    'success': true,
  });

  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (final context, final _) => const ProviderScope(
        child: FintechApp(),
      ),
    ),
  );
}

class FintechApp extends StatelessWidget {
  const FintechApp({super.key});

  @override
  Widget build(final BuildContext context) => ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        builder: (final _, final __) => MaterialApp.router(
          title: 'FintechApp',
          theme: MinyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      );
}
