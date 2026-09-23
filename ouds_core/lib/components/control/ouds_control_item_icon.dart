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

/// {@category Checkbox}
/// {@category Radio button}
/// {@category Switch}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox_item.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button_item.dart';

///
/// An icon in a control item like [OudsCheckboxItem] or [OudsRadioButtonItem].
///
class OudsControlItemIcon {
  /// The path to the custom SVG asset for the icon.
  final String icon;

  ///  Controls whether the icon should be tinted with the theme color. Defaults to `true`.
  ///  When set to `false`, the icon is displayed with its original colors (e.g., for multi-color icons).
  ///   Note that untinted icons must ensure sufficient contrast with the background for accessibility reasons.
  final bool tinted;

  /// The background color to apply behind the icon.
  ///
  /// Only applicable when [tinted] is `false`. When [tinted] is `true`,
  /// this parameter is ignored and the theme's default background color is used instead.
  final Color backgroundColor;

  const OudsControlItemIcon(
      this.icon, {
        this.tinted = true,
        this.backgroundColor = Colors.transparent,
      });
}