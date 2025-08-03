import 'package:config/config.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppModules.initialize();
  runApp(
    ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      child: const ProviderScope(child: MyApp()),
      builder: (context, child) => child!,
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: MinyTheme.lightTheme,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    );
  }
}
