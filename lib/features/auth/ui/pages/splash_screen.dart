import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/auth_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: SvgPicture.asset(
            AuthConstants.splashScreenLogoPath,
            height: theme.sizing.height.s50,
          ),
        ),
      ),
    );
  }
}
