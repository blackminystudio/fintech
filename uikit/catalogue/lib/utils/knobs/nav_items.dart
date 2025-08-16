import 'package:miny_uikit/miny_uikit.dart';
import 'package:widgetbook/widgetbook.dart';

const kotakImage =
    'https://companieslogo.com/img/orig/KOTAKBANK.NS-36440c5e.png';

extension NavItemsKnob on KnobsBuilder {
  /// Builds a List<NavItemData> using knobs (count + per-item controls).
  List<NavIcon> navItems({String label = 'Nav items'}) {
    final list = [
      const NavIcon(icon: MinyIcons.home, label: 'Home'),
      const NavIcon(icon: MinyIcons.scan, label: 'Scan'),
      const NavIcon(icon: MinyIcons.document, label: 'Analytics'),
      const NavIcon(icon: MinyIcons.bank, label: 'Au Bank'),
    ];

    final count = this.int.slider(
      label: 'Count',
      max: list.length,
      min: 1,
      initialValue: 1,
    );

    final navList = list.sublist(0, count);
    return List.generate(
      count,
      (i) => NavIcon(icon: navList[i].icon, label: navList[i].label),
    );
  }
}
