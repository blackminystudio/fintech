import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

final theme = ThemeData.light();
Future<void> pumpMinyWidgets(
  WidgetTester tester, {
  required Widget child,
}) async {
  final widgetScreen = ScreenUtilInit(
    designSize: const Size(440, 956),
    minTextAdapt: true,
    builder: (context, _) => ProviderScope(
      child: MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pumpWidget(widgetScreen);
}
