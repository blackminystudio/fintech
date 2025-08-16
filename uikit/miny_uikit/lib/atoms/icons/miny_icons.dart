import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class IconPack {
  const IconPack({required this.outline, required this.filled});
  final IconData outline;
  final IconData filled;
}

class MinyIcons {
  const MinyIcons._();
  static const home = IconPack(filled: Iconsax.home_15, outline: Iconsax.home);
  static const scan = IconPack(filled: Iconsax.scan5, outline: Iconsax.scan);
  static const document = IconPack(
    filled: Iconsax.document_text5,
    outline: Iconsax.document_text_1,
  );
  static const bank = IconPack(filled: Iconsax.bank5, outline: Iconsax.bank);

  static const all = <IconPack>[document, home, scan, bank];
  static final names = <IconPack, String>{
    document: 'Document',
    home: 'Home',
    scan: 'Scan',
    bank: 'My Bank',
  };
}
