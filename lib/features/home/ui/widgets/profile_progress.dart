import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileProgress extends StatelessWidget {
  const ProfileProgress({
    required this.progressValue,
    required this.profilePictureUrl,
    super.key,
  });

  final double progressValue;
  final String profilePictureUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
        boxShadow: [
          // TODO: DS: Add proper box shadow color (e.g., e2  in design tokens)

          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: ClipOval(
        child: CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          percent: progressValue,
          radius: theme.borderradius.xLarge,
          lineWidth: theme.borderwidth.medium,
          center: Container(
            margin: EdgeInsets.all(theme.spacing.width.s4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(profilePictureUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          fillColor: theme.colors.neutralLight,
          backgroundColor: theme.colors.neutralBorder,
          progressColor: theme.colors.neutralBackground,
        ),
      ),
    );
  }
}
