import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import 'core/router/app_router.dart';

class FintechApp extends StatelessWidget {
  const FintechApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'FintechApp',
        theme: MinyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      );
}
