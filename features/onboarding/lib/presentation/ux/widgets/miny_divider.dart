import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MinyDivider extends StatelessWidget {
  const MinyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      thickness: theme.sizing.half,
      height: theme.spacing.s0,
      color: theme.colors.neutralLightBackground,
    );
  }
}
