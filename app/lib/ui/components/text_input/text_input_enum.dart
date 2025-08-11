import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Represents the style of an OUDS TextInput.
enum TextInputEnumStyle {
  defaultStyle,
  alternative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}

extension CustomElementLayout on TextInputEnumStyle {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case TextInputEnumStyle.defaultStyle:
        return "Default";
      case TextInputEnumStyle.alternative:
        return "Alternative";
    }
  }
}
