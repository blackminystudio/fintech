import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../auth/utilities/auth_constants.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({
    required this.userName,
    required this.greetingIcon,
    required this.greetingMeassage,
    super.key,
  });
  final String userName;
  final IconData greetingIcon;
  final String greetingMeassage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        ClipSmoothRect(
          radius: SmoothBorderRadius(
            cornerSmoothing: 1,
            cornerRadius: theme.borderradius.normal,
          ),
          child: SvgPicture.asset(
            width: theme.sizing.width.s12,
            height: theme.sizing.height.s12,
            ImagePath.splashScreenLogoPath,
          ),
        ),
        SizedBox(width: theme.spacing.width.s16),
        // Greeting
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  greetingMeassage,
                  style: theme.textStyle.bodyXxsmall.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                ),
                SizedBox(width: theme.spacing.width.s8),
                Icon(
                  greetingIcon,
                  size: theme.sizing.height.s4,
                  color: theme.colors.textSecondary,
                ),
              ],
            ),
            Text(
              userName,
              style: theme.textStyle.headingMedium.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
