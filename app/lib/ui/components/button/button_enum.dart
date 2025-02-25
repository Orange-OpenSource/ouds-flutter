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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';

/// Represents the hierarchy of an OUDS button.
enum ButtonsEnumHierarchy {
  Default,
  Strong,
  Minimal,
  Negative;

  static String enumName(BuildContext context) {
    return AppLocalizations.of(context)!.app_components_button_hierarchy_label;
  }
}

extension CustomElementHierarchy on ButtonsEnumHierarchy {
  String stringValue(BuildContext context) {
    switch (this) {
      case ButtonsEnumHierarchy.Default:
        return ButtonsEnumHierarchy.Default.toString().split('.').last;
      case ButtonsEnumHierarchy.Strong:
        return ButtonsEnumHierarchy.Strong.toString().split('.').last;
      case ButtonsEnumHierarchy.Minimal:
        return ButtonsEnumHierarchy.Minimal.toString().split('.').last;
      case ButtonsEnumHierarchy.Negative:
        return ButtonsEnumHierarchy.Negative.toString().split('.').last;
    }
  }
}

/// Represents the style of an OUDS button.
enum ButtonsEnumStyle {
  Default,
  Loading;

  static String enumName(BuildContext context) {
    return AppLocalizations.of(context)!.app_components_common_style_label;
  }
}

extension CustomElementStyle on ButtonsEnumStyle {
  String stringValue(BuildContext context) {
    switch (this) {
      case ButtonsEnumStyle.Default:
        return ButtonsEnumStyle.Default.toString().split('.').last;
      case ButtonsEnumStyle.Loading:
        return ButtonsEnumStyle.Loading.toString().split('.').last;
    }
  }
}

/// Represents the layout of an OUDS button.
enum ButtonsEnumLayout {
  TextOnly,
  IconAndText,
  IconOnly;

  static String enumName(BuildContext context) {
    return AppLocalizations.of(context)!.app_components_common_layout_label;
  }
}

extension CustomElementLayout on ButtonsEnumLayout {
  String stringValue(BuildContext context) {
    switch (this) {
      case ButtonsEnumLayout.TextOnly:
        return AppLocalizations.of(context)!
            .app_components_common_textOnlyLayout_label;
      case ButtonsEnumLayout.IconAndText:
        return AppLocalizations.of(context)!
            .app_components_common_iconAndTextLayout_label;
      case ButtonsEnumLayout.IconOnly:
        return AppLocalizations.of(context)!
            .app_components_button_iconOnlyLayout_label;
    }
  }
}
