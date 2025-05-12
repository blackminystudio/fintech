import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';

class ExpandableSearchField extends StatefulWidget {
  final List<String> allItems;
  final String? selected;
  final ValueChanged<String> onSelected;

  const ExpandableSearchField({
    super.key,
    required this.allItems,
    required this.onSelected,
    this.selected,
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
    final query = _controller.text.toLowerCase();
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
    // if parent resets the selected city, update the text
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
    final showDropdown =
        _controller.text.isNotEmpty && itemCount > 0 && !_isItemSelected;
    final containerHeight =
        showDropdown ? (itemCount > 4 ? maxHeight : itemCount * itemHeight) : 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.neutralBorder),
        borderRadius: BorderRadius.circular(theme.borderradius.normal),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: theme.spacing.width.s32,
                vertical: theme.spacing.height.s20,
              ),
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
          ),
          if (showDropdown) ...[
            Divider(
              height: theme.spacing.height.s1,
              color: theme.colors.neutralBorder,
            ),
            ClipRRect(
              borderRadius: showDropdown
                  ? BorderRadius.vertical(
                      bottom: Radius.circular(theme.borderradius.normal),
                    )
                  : BorderRadius.zero,
              child: SizedBox(
                height: containerHeight.toDouble(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.width.s16,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) => ListTile(
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
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
