import 'package:flutter/material.dart';
import 'package:miny_uikit/miny_uikit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../utils/pill.dart';

@UseCase(name: 'SliderIndicator', type: SliderIndicator)
Widget slider(BuildContext context) =>
    const Pill(version: '0.1.0', child: SliderIndicator());
