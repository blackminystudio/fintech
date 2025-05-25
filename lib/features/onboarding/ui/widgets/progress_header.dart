import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({
    required this.progressValue,
    required this.onTapSkip,
    required this.onTapBack,
    super.key,
  });
  final double progressValue;
  final VoidCallback onTapSkip;
  final VoidCallback onTapBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressText = (progressValue * 100).toInt();
    return Padding(
      padding: EdgeInsets.all(theme.spacing.height.s32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapBack,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colors.neutralBorder),
                borderRadius: BorderRadius.circular(
                  theme.borderradius.xLarge,
                ),
              ),
              padding: EdgeInsets.all(theme.sizing.height.s3),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: theme.sizing.height.s6,
                color: theme.colors.textPrimary,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                '$progressText% ${OnboardingConstants.progressText}',
                style: theme.textStyle.headingSmall.copyWith(
                  color: theme.colors.accentPurple,
                ),
              ),
              SizedBox(height: theme.sizing.height.s3),
              SizedBox(
                width: theme.sizing.width.s50,
                height: theme.spacing.height.s4,
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(
                    begin: 0.0,
                    end: progressValue,
                  ),
                  builder: (context, value, _) => LinearProgressIndicator(
                    value: value,
                    color: theme.colors.accentPurple,
                    backgroundColor: theme.colors.neutralBorder,
                    borderRadius: BorderRadius.circular(
                      theme.borderradius.xSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // TODO: DS: Add TextButton in design system
          GestureDetector(
            onTap: onTapSkip,
            child: Text(
              OnboardingConstants.skipText,
              style: theme.textStyle.headingSmall.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
