import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';

class ExpandableSearchField extends StatefulWidget {
  final List<String> allItems;
  final String? selected;
  final ValueChanged<String> onSelected;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const ExpandableSearchField({
    super.key,
    required this.allItems,
    required this.onSelected,
    this.selected,
    this.inputFormatters,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<ExpandableSearchField> createState() => _ExpandableSearchFieldState();
}

class _ExpandableSearchFieldState extends State<ExpandableSearchField> {
  late TextEditingController _controller;
  bool _isItemSelected = false;
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.allItems;
    _controller = TextEditingController(text: widget.selected ?? '');
    _controller.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _controller.text.toLowerCase().trim();
    setState(() {
      _isItemSelected = false;
      filteredItems = widget.allItems
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void didUpdateWidget(covariant ExpandableSearchField old) {
    super.didUpdateWidget(old);
    if (widget.selected != old.selected) {
      _controller.text = widget.selected ?? '';
      _isItemSelected = widget.selected != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemHeight = theme.sizing.height.s14;
    final itemCount = filteredItems.length;
    final maxHeight = itemHeight * 4;
    final showDropdown = _controller.text.isNotEmpty && !_isItemSelected;
    final calculateHeight = itemCount > 0
        ? (itemCount > 4 ? maxHeight : itemCount * itemHeight)
        : itemHeight;
    final containerHeight = showDropdown ? calculateHeight : 0.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.neutralBorder),
        borderRadius: BorderRadius.circular(theme.borderradius.normal),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(theme.borderradius.normal),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              focusNode: widget.focusNode,
              inputFormatters: widget.inputFormatters ??
                  [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z, ]')),
                  ],
              controller: _controller,
              decoration: InputDecoration(
                hintText: OnboardingConstants.enterCityText,
                hintStyle: theme.textStyle.bodyMedium.copyWith(
                  color: theme.colors.textSecondarylight,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: theme.textStyle.bodyMedium.copyWith(
                color: theme.colors.textPrimary,
              ),
              onChanged: (value) {
                widget.onChanged?.call(value);
              },
            ),
            if (showDropdown)
              ..._buildExpandedWidgetLIst(
                theme,
                showDropdown,
                containerHeight,
                itemCount,
                itemHeight,
              )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExpandedWidgetLIst(
    ThemeData theme,
    bool showDropdown,
    num containerHeight,
    int itemCount,
    double itemHeight,
  ) =>
      [
        Divider(
          height: theme.sizing.height.quarter,
          color: theme.colors.neutralBorder,
        ),
        ClipRRect(
          child: Material(
            color: theme.colors.neutralLight,
            child: SizedBox(
              height: containerHeight.toDouble(),
              child: itemCount > 0
                  ? ListView.builder(
                      itemCount: itemCount,
                      itemBuilder: (context, index) => _buildListTile(
                        itemHeight,
                        index,
                        theme,
                        context,
                      ),
                    )
                  : _buildNoItemsTile(itemHeight, theme),
            ),
          ),
        ),
      ];

  Widget _buildNoItemsTile(double itemHeight, ThemeData theme) => ListTile(
        minTileHeight: itemHeight,
        title: Text(
          OnboardingConstants.cityAvailable,
          style: theme.textStyle.bodyMedium.copyWith(
            color: theme.colors.textSecondary,
          ),
        ),
      );

  ListTile _buildListTile(
    double itemHeight,
    int index,
    ThemeData theme,
    BuildContext context,
  ) =>
      ListTile(
        minTileHeight: itemHeight,
        title: Text(
          filteredItems[index],
          style: theme.textStyle.bodyMedium.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
        onTap: () {
          final city = filteredItems[index];
          _controller.text = city;
          widget.onSelected(city);
          FocusScope.of(context).unfocus();
          _isItemSelected = true;
          setState(() {});
        },
      );
}
