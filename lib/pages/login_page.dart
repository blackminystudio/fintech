import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../constants/loginpage_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.neutralLight,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.sizing.height.s8),
            child: Column(
              children: [
                SizedBox(height: theme.sizing.height.s36),
                SvgPicture.asset(LoginpageConstants.appLogoPath),
                SizedBox(height: theme.sizing.height.s20),
                Text(
                  LoginpageConstants.introducingText,
                  style: theme.textStyle.bodyXsmall.copyWith(
                    color: theme.colors.neutralBackground,
                  ),
                ),
                SizedBox(height: theme.sizing.height.s6),
                Text(
                  LoginpageConstants.headingText,
                  textAlign: TextAlign.center,
                  style: theme.textStyle.bodyXxlarge.copyWith(
                    color: theme.colors.neutralBackground,
                  ),
                ),
                SizedBox(height: theme.sizing.height.s6),
                Text(
                  LoginpageConstants.subText,
                  textAlign: TextAlign.center,
                  style: theme.textStyle.bodyMedium.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    text: LoginpageConstants.termsPrefix,
                    style: theme.textStyle.bodyXsmall.copyWith(
                      color: theme.colors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: LoginpageConstants.termsText,
                        style: theme.textStyle.headingXsmall.copyWith(
                          color: theme.colors.neutralBackground,
                        ),
                      ),
                      TextSpan(
                        text: LoginpageConstants.andText,
                        style: theme.textStyle.bodyXsmall.copyWith(
                          color: theme.colors.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: LoginpageConstants.privacyPolicyText,
                        style: theme.textStyle.headingXsmall.copyWith(
                          color: theme.colors.neutralBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: theme.sizing.height.s5),
                MinyButton(
                  enableIcon: true,
                  onPressed: () {},
                  label: LoginpageConstants.googleButtonLabel,
                  iconPath: LoginpageConstants.googleIconPath,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
