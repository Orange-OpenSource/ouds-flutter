import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';

/// Represents the layout of an OUDS link.
enum LinkEnumLayout {
  textOnly,
  textAndIcon,
  next,
  back;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}
extension CustomElementLayout on LinkEnumLayout {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case LinkEnumLayout.textOnly:
        return l10n.app_components_common_textOnlyLayout_label;
      case LinkEnumLayout.textAndIcon:
        return l10n.app_components_common_iconAndTextLayout_label;
      case LinkEnumLayout.next:
        return l10n.app_components_link_nextLayout_label;
      case LinkEnumLayout.back:
        return l10n.app_components_link_backLayout_label;
    }
  }
}

/// Represents the size of an OUDS Link.
enum LinkEnumSize {
  defaultSize,
  small;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_size_label;
  }

}
extension CustomElementSize on LinkEnumSize {
  String stringValue(BuildContext context) {

    switch (this) {
      case LinkEnumSize.defaultSize:
        return capitalizeEnumValue(LinkEnumSize.defaultSize);
      case LinkEnumSize.small:
        return capitalizeEnumValue(LinkEnumSize.small);

    }
  }
}