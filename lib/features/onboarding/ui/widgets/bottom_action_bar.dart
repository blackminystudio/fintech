import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class BottomActionBar extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const BottomActionBar({
    super.key,
    this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.neutralLight,
        border: Border(
          top: BorderSide(
            color: theme.colors.neutralBorder,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: theme.spacing.height.s20,
        horizontal: theme.spacing.width.s32,
      ),
      child: MinyButton(
        label: label,
        onPressed: onTap,
      ),
    );
  }
}
