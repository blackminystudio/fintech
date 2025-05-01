import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../constants/onboardpage_constants.dart';

class ProgressHeader extends StatelessWidget {
  final double progressValue;
  final VoidCallback onTapSkip;
  final VoidCallback onTapBack;
  const ProgressHeader({
    super.key,
    required this.progressValue,
    required this.onTapSkip,
    required this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressText = (progressValue * 100).toInt();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: theme.sizing.height.s8),
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
                    '$progressText% ${OnboardpageConstants.progressText}',
                    style: theme.textStyle.headingSmall.copyWith(
                      color: theme.colors.accentPurple,
                    ),
                  ),
                  SizedBox(height: theme.sizing.height.s3),
                  SizedBox(
                    width: theme.sizing.width.s50,
                    height: theme.spacing.height.s4,
                    child: LinearProgressIndicator(
                      value: progressValue,
                      color: theme.colors.accentPurple,
                      backgroundColor: theme.colors.neutralBorder,
                      borderRadius: BorderRadius.circular(
                        theme.borderradius.xSmall,
                      ),
                    ),
                  ),
                ],
              ),
              // TODO: DS: Add TextButton in design system
              GestureDetector(
                onTap: onTapSkip,
                child: Text(
                  OnboardpageConstants.skipText,
                  style: theme.textStyle.headingSmall.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
