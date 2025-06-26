import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';

class BriefInfoCard extends StatelessWidget {
  const BriefInfoCard({
    required this.icon,
    required this.color,
    required this.month,
    required this.percentage,
    required this.percentColor,
    required this.primaryAmount,
    required this.secondaryAmount,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String month;
  final String percentage;
  final Color percentColor;
  final String primaryAmount;
  final String secondaryAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _buildOuterContainer(
      theme: theme,
      child: _buildInnerCard(theme),
    );
  }

  /// Outer colored border with padding
  Widget _buildOuterContainer({
    required ThemeData theme,
    required Widget child,
  }) =>
      Container(
        decoration: ShapeDecoration(
          color: color,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerSmoothing: 1,
                cornerRadius: theme.borderradius.large,
              ),
            ),
          ),
        ),
        padding: EdgeInsets.only(
          left: theme.spacing.width.s12,
          right: theme.spacing.width.s1,
          top: theme.spacing.width.s1,
          bottom: theme.spacing.width.s1,
        ),
        child: child,
      );

  /// Main white card with border
  Widget _buildInnerCard(ThemeData theme) => Container(
        height: theme.sizing.height.s28,
        width: theme.sizing.height.s50,
        decoration: ShapeDecoration(
          color: theme.colors.neutralLight,
          shape: SmoothRectangleBorder(
            side: BorderSide(
              width: theme.spacing.width.s2,
              color: color,
            ),
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerSmoothing: 1,
                cornerRadius: theme.borderradius.large,
              ),
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.width.s12,
          horizontal: theme.spacing.height.s12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTopRow(theme),
            _buildBottomRow(theme),
          ],
        ),
      );

  /// Top row: icon and month
  Widget _buildTopRow(ThemeData theme) => Row(
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.width.s2),
            child: Icon(
              icon,
              size: theme.sizing.width.s4,
              color: color,
            ),
          ),
          SizedBox(width: theme.spacing.width.s2),
          Text(
            month.toUpperCase(),
            style: theme.textStyle.headingXxsmall.copyWith(
              color: theme.colors.textSecondarylight,
            ),
          ),
        ],
      );

  /// Bottom row: percentage and amount values
  Widget _buildBottomRow(ThemeData theme) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$percentage${HomeConstants.percentage}',
            style: theme.textStyle.headingSmall.copyWith(
              color: percentColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${HomeConstants.currency}$primaryAmount',
                style: theme.textStyle.headingLarge.copyWith(
                  color: theme.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${HomeConstants.currency}$secondaryAmount',
                style: theme.textStyle.headingSmall.copyWith(
                  color: theme.colors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      );
}
