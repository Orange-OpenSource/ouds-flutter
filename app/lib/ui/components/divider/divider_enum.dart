import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Represents the color of an OUDS divider.
enum DividerEnumColor {
  defaultColor,
  muted,
  emphasized,
  brandPrimary,
  onBrandPrimary,
  alwaysBlack,
  alwaysOnBlack,
  alwaysWhite,
  alwaysOnWhite;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_color_label;
  }
}

extension FormattedName on Enum {
  String get formattedName {
    if (name == 'defaultColor') return 'Default';
    final words = name.split(RegExp(r'(?=\p{Lu})', unicode: true));
    final joined = words.map((w) => w.toLowerCase()).join(' ').trim();
    return joined[0].toUpperCase() + joined.substring(1);
  }
}
