import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Represents the layout of an OUDS TextInput.
enum TextInputEnumLayout {
  textOnly,
  iconAndText,
  iconOnly;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}

extension CustomElementLayout on TextInputEnumLayout {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case TextInputEnumLayout.textOnly:
        return l10n.app_components_common_textOnlyLayout_label;
      case TextInputEnumLayout.iconAndText:
        return l10n.app_components_common_iconAndTextLayout_label;
      case TextInputEnumLayout.iconOnly:
        return l10n.app_components_button_iconOnlyLayout_label;
    }
  }
}
