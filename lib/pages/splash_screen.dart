import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/loginpage_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: Center(
            child: SvgPicture.asset(LoginpageConstants.splashScreenLogoPath),
          ),
        ),
      );
}
