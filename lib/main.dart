import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/modules/app_modules.dart';

void main() async {
  final container = ProviderContainer();
  await AppModules.initialize(container);

  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (_, __) => UncontrolledProviderScope(
        container: container,
        child: const FintechApp(),
      ),
    ),
  );
}
