import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: theme.sizing.base,
      width: theme.sizing.s8,
      decoration: BoxDecoration(
        color: theme.colors.textPrimary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(theme.borderradius.xSmall),
        ),
      ),
    );
  }
}
