import 'package:flutter/material.dart';
import 'package:miny_uikit/miny_uikit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../utils/knobs/nav_items.dart';
import '../../utils/pill.dart';

@UseCase(name: 'NavIcon', type: NavIcon)
Widget navIcon(BuildContext context) {
  final label = context.knobs.stringOrNull(
    label: 'Label',
    initialValue: 'Home',
  );

  final icon = context.knobs.list<IconPack>(
    label: 'Icon',
    options: MinyIcons.all,
    initialOption: MinyIcons.home,
    labelBuilder: (i) => MinyIcons.names[i] ?? 'Unknown',
  );
  final image = context.knobs.stringOrNull(
    label: 'Image URL',
    initialValue: kotakImage,
  );
  final isSelected = context.knobs.boolean(label: 'IsSelected');

  return Pill(
    version: '0.1.0',
    child: NavIcon(
      icon: icon,
      label: label,
      imageUrl: image,
      isSelected: isSelected,
    ),
  );
}
