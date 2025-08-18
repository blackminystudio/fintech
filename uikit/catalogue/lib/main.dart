import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const Catalogue());
}

@widgetbook.App()
class Catalogue extends StatelessWidget {
  const Catalogue({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    themeMode: ThemeMode.dark,
    directories: directories,
    addons: [
      ViewportAddon(Viewports.all),
      // GridAddon(10),
      MaterialThemeAddon(
        themes: [
          WidgetbookTheme(
            name: 'Light',
            data: MinyTheme.lightTheme.copyWith(
              scaffoldBackgroundColor: Colors.white,
            ),
          ),
          WidgetbookTheme(name: 'Flutter', data: ThemeData.light()),
        ],
      ),
      InspectorAddon(),
      ZoomAddon(),
    ],
  );
}
