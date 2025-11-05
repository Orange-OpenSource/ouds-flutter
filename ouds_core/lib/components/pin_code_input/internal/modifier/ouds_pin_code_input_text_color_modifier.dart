/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */
/// @nodoc
library;

import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the tick color for the OudsPinCodeInput based on its state and error status.
class OudsPinCodeInputTextColorModifier {
  final BuildContext context;

  OudsPinCodeInputTextColorModifier(this.context);

  /// Gets the cursor text color based on the control error status.
  Color getPinCodeCursorColor(bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme(context);
    if (error) {
      return colorsScheme.actionNegativePressed;
    } else {
      return colorsScheme.contentDefault;
    }
  }

  /// Gets the helper text for pin code input color based on the error state
  Color getPinCodeHelperTextColor(bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme(context);
    if (error) {
      return colorsScheme.contentStatusNegative;
    } else {
      return colorsScheme.contentMuted;
    }
  }
}