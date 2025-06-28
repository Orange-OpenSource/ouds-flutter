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

/// Represents the layout of an OUDS chip.
enum ChipEnumLayout {
  textOnly,
  iconAndText,
  iconOnly;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}

extension CustomElementLayout on ChipEnumLayout {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case ChipEnumLayout.textOnly:
        return l10n.app_components_common_textOnlyLayout_label;
      case ChipEnumLayout.iconAndText:
        return l10n.app_components_common_iconAndTextLayout_label;
      case ChipEnumLayout.iconOnly:
        return l10n.app_components_button_iconOnlyLayout_label;
    }
  }
}
