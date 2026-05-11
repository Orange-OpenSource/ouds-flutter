import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';

enum StatusEnum {
  neutral,
  accent,
  positive,
  info,
  warning,
  negative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_status_label;
  }
}

extension CustomElementStatus on StatusEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case StatusEnum.neutral:
        return capitalizeEnumValue(StatusEnum.neutral);
      case StatusEnum.accent:
        return capitalizeEnumValue(StatusEnum.accent);
      case StatusEnum.positive:
        return capitalizeEnumValue(StatusEnum.positive);
      case StatusEnum.info:
        return capitalizeEnumValue(StatusEnum.info);
      case StatusEnum.warning:
        return capitalizeEnumValue(StatusEnum.warning);
      case StatusEnum.negative:
        return capitalizeEnumValue(StatusEnum.negative);
    }
  }
}
