import 'package:flutter/material.dart';
import 'package:miny_uikit/miny_uikit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../utils/knobs/nav_items.dart';
import '../../utils/pill.dart';

@UseCase(name: 'NavBar (list from custom knob)', type: NavBar)
Widget navBarUseCase(BuildContext context) {
  final items = context.knobs.navItems();
  final mutedIndexStr = context.knobs.string(
    initialValue: '0',
    label: 'Muted Indices',
    description: 'Comma-separated integer indices to mute, e.g. "1,3,5"',
  );

  final mutedIndex =
      mutedIndexStr
          .split(',')
          .map((e) => int.tryParse(e.trim()))
          .whereType<int>()
          .toList();

  return Pill(
    version: '0.1.0',
    child: NavBar(
      navIcons: items,
      mutedIndex: mutedIndex,
      onChanged: (index) {},
    ),
  );
}
