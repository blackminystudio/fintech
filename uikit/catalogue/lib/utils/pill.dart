import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  const Pill({
    required this.child,
    required this.version,
    this.pills,
    this.show = true,
    super.key,
  });
  final Widget child;
  final String version;
  final List<PillConfig>? pills;
  final bool show;

  @override
  Widget build(BuildContext context) {
    if (!show) return child;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(child: child),
        Positioned(
          right: 10,
          top: 10,
          child: SizedBox(
            width: 350,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.end,
              children: [
                _buildBadge(PillConfig(label: version)),
                if (pills != null) ...pills!.map(_buildBadge).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _buildBadge(PillConfig badgeConfig) {
    final (pillColor, pillLabel) = _valueForType(badgeConfig.type);
    return Container(
      decoration: BoxDecoration(
        color: pillColor,
        borderRadius: BorderRadius.circular(20),
      ),

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(
        badgeConfig.label ?? pillLabel,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  (Color, String) _valueForType(PillType type) {
    switch (type) {
      case PillType.info:
        return (Colors.green, 'Info');
      case PillType.warning:
        return (Colors.orange, 'Warning');
      case PillType.error:
        return (Colors.red, 'Error');
      case PillType.debug:
        return (Colors.grey, 'debug');
      case PillType.baseDesign:
        return (Colors.blue, 'Base Design');
      case PillType.minyDesign:
        return (Colors.purple, 'Miny Design');
    }
  }
}

class PillConfig {
  PillConfig({this.label, this.type = PillType.info});

  final String? label;
  final PillType type;
}

enum PillType { info, warning, error, debug, minyDesign, baseDesign }
