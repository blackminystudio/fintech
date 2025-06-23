import 'package:fintechapp/features/home/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miny_design_system/miny_design_system.dart';

void main() {
  testWidgets('Icon find in Notification Widget',
      (final WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        builder: (final _, final __) => MaterialApp(
          title: 'FintechApp',
          theme: MinyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
    expect(find.byType(SafeArea), findsOneWidget);
  });
}
