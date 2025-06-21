import 'package:fintechapp/features/home/ui/widgets/notifiacation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax/iconsax.dart';
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
          home: const NotifiactionButton(
            icon: Iconsax.notification_bing,
          ),
        ),
      ),
    );
    expect(find.byType(Icon), findsOneWidget);
  });
}
