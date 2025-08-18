import 'package:core/core.dart' hide MinyIcons;
import 'package:flutter/material.dart';

import '../../miny_uikit.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    required this.navIcons,
    required this.onChanged,
    List<int>? mutedIndex,
    super.key,
  }) : mutedIndex = mutedIndex ?? const [];
  final List<int> mutedIndex;
  final List<NavIcon> navIcons;
  final Function(int index) onChanged;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemCount = widget.navIcons.length;
    final indicatorWidth = theme.sizing.s8;
    final indicatorHeight = theme.sizing.base;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colors.neutralBorder,
            width: theme.sizing.half,
          ),
        ),
      ),

      padding: EdgeInsets.symmetric(horizontal: theme.spacing.s20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth;
          final slotWidth = barWidth / itemCount;
          final left =
              slotWidth * selectedIndex + (slotWidth - indicatorWidth) / 2;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: indicatorHeight,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      top: 0,
                      left: left,
                      width: indicatorWidth,
                      curve: Curves.easeInOut,
                      height: indicatorHeight,
                      duration: const Duration(milliseconds: 220),
                      child: const SliderIndicator(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: theme.spacing.s16),
                child: Row(
                  children: [
                    ...widget.navIcons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final navIcon = entry.value;
                      return Expanded(
                        child: GestureDetector(
                          onTap:
                              () => setState(() {
                                if (!widget.mutedIndex.contains(index)) {
                                  selectedIndex = index;
                                }

                                widget.onChanged(index);
                              }),
                          behavior: HitTestBehavior.opaque,
                          child: NavIcon(
                            icon: navIcon.icon,
                            label: navIcon.label,
                            isSelected: selectedIndex == index,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
