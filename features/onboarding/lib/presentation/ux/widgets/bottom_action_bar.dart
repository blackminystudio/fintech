import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({required this.label, super.key, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.neutralLight,
        border: Border(top: BorderSide(color: theme.colors.neutralBorder)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: theme.spacing.s20,
        horizontal: theme.spacing.s32,
      ),
      child: MinyButton(label: label, onPressed: onTap),
    );
  }
}
