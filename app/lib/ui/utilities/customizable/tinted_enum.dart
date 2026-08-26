//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';

/// Represents whether an icon should be displayed tinted (single color, following
/// the theme color) or untinted (original, potentially multi-color, asset colors).
///
/// Shared between components exposing a `tinted` customization option, such as
/// [OudsButton] and [OudsLink].
enum TintedEnum {
  tinted,
  untinted;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_tinted_tech;
  }
}

extension CustomElementTinted on TintedEnum {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case TintedEnum.tinted:
        return l10n.app_components_common_tinted_label;
      case TintedEnum.untinted:
        return l10n.app_components_common_untinted_label;
    }
  }
}
