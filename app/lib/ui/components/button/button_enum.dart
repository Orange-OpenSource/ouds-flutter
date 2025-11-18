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

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';

/// Represents the appearance of an OUDS button.
enum ButtonEnumAppearance {
  defaultAppearance,
  strong,
  brand,
  minimal,
  negative;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_appearance_label;
  }
}

extension CustomElementAppearance on ButtonEnumAppearance {
  String stringValue(BuildContext context) {
    switch (this) {
      case ButtonEnumAppearance.defaultAppearance:
        return capitalizeEnumValue(ButtonEnumAppearance.defaultAppearance);
      case ButtonEnumAppearance.strong:
        return capitalizeEnumValue(ButtonEnumAppearance.strong);
      case ButtonEnumAppearance.brand:
        return capitalizeEnumValue(ButtonEnumAppearance.brand);
      case ButtonEnumAppearance.minimal:
        return capitalizeEnumValue(ButtonEnumAppearance.minimal);
      case ButtonEnumAppearance.negative:
        return capitalizeEnumValue(ButtonEnumAppearance.negative);
    }
  }
}

/// Represents the layout of an OUDS button.
enum ButtonEnumLayout {
  textOnly,
  iconAndText,
  iconOnly;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_layout_label;
  }
}

extension CustomElementLayout on ButtonEnumLayout {
  String stringValue(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case ButtonEnumLayout.textOnly:
        return l10n.app_components_common_textOnlyLayout_label;
      case ButtonEnumLayout.iconAndText:
        return l10n.app_components_common_iconAndTextLayout_label;
      case ButtonEnumLayout.iconOnly:
        return l10n.app_components_common_iconOnlyLayout_label;
    }
  }
}
