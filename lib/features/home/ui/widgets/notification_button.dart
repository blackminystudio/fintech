import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      iconSize: theme.sizing.width.s8,
      padding: EdgeInsets.all(theme.spacing.width.s8),
      icon: Icon(
        icon,
        color: theme.colors.textSecondary,
      ),
      onPressed: onPressed,
    );
  }
}
