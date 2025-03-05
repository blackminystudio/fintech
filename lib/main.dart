import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miny_design_system/miny_design_system.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FintechApp',
        theme: MinyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(
            'Hello Finance',
            style: Theme.of(context).textStyle.bodyLarge,
          ),
        ),
      );
}
