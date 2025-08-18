import 'package:core/core.dart' hide MinyIcons;
import 'package:flutter/material.dart';

import 'miny_icons.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({
    required this.icon,
    super.key,
    this.label,
    this.isSelected = false,
    this.imageUrl,
  });
  final String? label;
  final bool isSelected;
  final String? imageUrl;
  final IconPack icon;

  @override
  Widget build(BuildContext context) {
    final text = label;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // show image OR icon
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(theme.sizing.s8 / 2),
            child: Image.network(
              imageUrl!,
              width: theme.sizing.s8,
              height: theme.sizing.s8,
              fit: BoxFit.contain,
            ),
          )
        else
          Icon(
            isSelected ? icon.filled : icon.outline,
            size: theme.sizing.s8,
            color:
                isSelected
                    ? theme.colors.neutralBackground
                    : theme.colors.textSecondary,
          ),

        SizedBox(height: theme.spacing.s4),
        if (text != null && text.isNotEmpty) _buildText(text, theme),
      ],
    );
  }

  Text _buildText(String text, ThemeData theme) => Text(
    text,
    style:
        isSelected
            ? theme.textStyle.headingXxsmall.copyWith(
              color: theme.colors.neutralBackground,
            )
            : theme.textStyle.headingXxsmall.copyWith(
              color: theme.colors.textSecondary,
            ),
  );
}
