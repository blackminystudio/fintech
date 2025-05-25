import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

enum OnboardingPageType {
  large,
  small,
}

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({
    required this.title,
    required this.subTitle,
    super.key,
    this.onboardingPageType = OnboardingPageType.large,
  });
  final String title;
  final String subTitle;
  final OnboardingPageType onboardingPageType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = (onboardingPageType == OnboardingPageType.large)
        ? theme.textStyle.headingXxlarge.copyWith(
            color: theme.colors.textPrimary,
          )
        : theme.textStyle.headingXlarge.copyWith(
            color: theme.colors.textPrimary,
          );
    final subtitleTextStyle = (onboardingPageType == OnboardingPageType.large)
        ? theme.textStyle.bodyMedium.copyWith(
            color: theme.colors.textSecondary,
          )
        : theme.textStyle.bodySmall.copyWith(
            color: theme.colors.textSecondary,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleTextStyle),
        SizedBox(height: theme.spacing.height.s20),
        Text(subTitle, style: subtitleTextStyle),
        SizedBox(height: theme.spacing.height.s32),
      ],
    );
  }
}
