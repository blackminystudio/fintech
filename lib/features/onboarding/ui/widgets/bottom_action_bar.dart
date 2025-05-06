import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class BottomActionBar extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const BottomActionBar({
    super.key,
    required this.label,
    required this.onPressed,
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
        vertical: theme.sizing.height.s5,
        horizontal: theme.sizing.height.s8,
      ),
      child: MinyButton(
        label: label,
        onPressed: onPressed,
      ),
    );
  }
}
