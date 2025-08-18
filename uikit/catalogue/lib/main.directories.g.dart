// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:catalogue/atoms/icons/nav_icon.dart'
    as _catalogue_atoms_icons_nav_icon;
import 'package:catalogue/atoms/slider/slider.dart'
    as _catalogue_atoms_slider_slider;
import 'package:catalogue/molecules/navbar/navbar.dart'
    as _catalogue_molecules_navbar_navbar;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'atoms',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'icons',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'NavIcon',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'NavIcon',
              builder: _catalogue_atoms_icons_nav_icon.navIcon,
            ),
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'slider',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'SliderIndicator',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'SliderIndicator',
              builder: _catalogue_atoms_slider_slider.slider,
            ),
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookFolder(
    name: 'molecules',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'navbar',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'NavBar',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'NavBar (list from custom knob)',
              builder: _catalogue_molecules_navbar_navbar.navBarUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
];
