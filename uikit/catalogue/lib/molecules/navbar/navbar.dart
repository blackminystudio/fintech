import 'package:flutter/material.dart';
import 'package:miny_uikit/miny_uikit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../utils/knobs/nav_items.dart';
import '../../utils/pill.dart';

@UseCase(name: 'NavBar (list from custom knob)', type: NavBar)
Widget navBarUseCase(BuildContext context) {
  final items = context.knobs.navItems();
  final mutedIndex = context.knobs.intOrNull.input(
    label: 'MutedIndex',
    description: 'No ux effect when tap but still capture the Callback.',
    initialValue: 1,
  );
  return Pill(
    version: '0.1.0',
    child: NavBar(
      navIcons: items,
      mutedIndex: mutedIndex,
      onChanged: (index) {},
    ),
  );
}
