import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    required this.label,
    super.key,
    this.onTap,
  });
  final String label;
  final VoidCallback? onTap;

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
        vertical: theme.sizing.height.s5,
        horizontal: theme.sizing.height.s8,
      ),
      child: MinyButton(
        label: label,
        onPressed: onTap,
      ),
    );
  }
}
