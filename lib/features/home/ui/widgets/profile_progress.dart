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
          // TODO:Ds add boxshadow color name e2
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: ClipOval(
        child: CircularPercentIndicator(
          animation: true,
          percent: progressValue,
          radius: theme.borderradius.xLarge,
          lineWidth: theme.borderwidth.medium, // Confusion
          center: Padding(
            padding: EdgeInsets.all(theme.spacing.width.s4),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(profilePictureUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Todo : fillcolor check
          fillColor: theme.colors.neutralLight, // neutral/border
          backgroundColor: theme.colors.neutralBorder, // neutral/border
          progressColor: theme.colors.neutralBackground, // neutral/background
        ),
      ),
    );
  }
}
