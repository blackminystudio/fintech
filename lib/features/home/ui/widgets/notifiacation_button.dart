import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

class NotifiactionButton extends StatelessWidget {
  const NotifiactionButton({
    required this.icon,
    super.key,
  });
  final IconData icon;

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
      onPressed: () {},
    );
  }
}
