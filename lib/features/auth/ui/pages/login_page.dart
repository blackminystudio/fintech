import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/auth_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.neutralLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.sizing.width.s8,
          ),
          child: Column(
            children: [
              SizedBox(height: theme.sizing.height.s20),
              SvgPicture.asset(
                AuthConstants.appLogoPath,
                height: theme.sizing.height.s32,
              ),
              SizedBox(height: theme.sizing.height.s20),
              Text(
                AuthConstants.introducingText,
                style: theme.textStyle.bodyXsmall.copyWith(
                  color: theme.colors.neutralBackground,
                ),
              ),
              SizedBox(height: theme.sizing.height.s6),
              Text(
                AuthConstants.headingText,
                textAlign: TextAlign.center,
                style: theme.textStyle.bodyXxlarge.copyWith(
                  color: theme.colors.neutralBackground,
                ),
              ),
              SizedBox(height: theme.sizing.height.s6),
              Text(
                AuthConstants.subText,
                textAlign: TextAlign.center,
                style: theme.textStyle.bodyMedium.copyWith(
                  color: theme.colors.textSecondary,
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  text: AuthConstants.termsPrefix,
                  style: theme.textStyle.bodyXsmall.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: AuthConstants.termsText,
                      style: theme.textStyle.headingXsmall.copyWith(
                        color: theme.colors.neutralBackground,
                      ),
                    ),
                    TextSpan(
                      text: AuthConstants.andText,
                      style: theme.textStyle.bodyXsmall.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                    TextSpan(
                      text: AuthConstants.privacyPolicyText,
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
                label: AuthConstants.googleButtonLabel,
                iconPath: AuthConstants.googleIconPath,
              ),
              SizedBox(height: theme.sizing.height.s10),
            ],
          ),
        ),
      ),
    );
  }
}
