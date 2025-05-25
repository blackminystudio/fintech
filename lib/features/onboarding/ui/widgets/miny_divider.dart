import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class MinyDivider extends StatelessWidget {
  const MinyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      thickness: theme.spacing.height.s2,
      height: theme.spacing.height.s0,
      color: theme.colors.neutralLightBackground,
    );
  }
}
