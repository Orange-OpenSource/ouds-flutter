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

/// @nodoc
library ouds_internal;

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/config/ouds_theme_config_model.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTagControlBorderModifier {
  final BuildContext context;

  OudsTagControlBorderModifier(this.context);

  /// Static method to get the border radius for a tag based on the border parameter.
  /// Returns a [BorderRadius] object with the appropriate radius value.
  static BorderRadius getBorderRadius(BuildContext context) {
    final tag = OudsTheme.of(context).componentsTokens(context).tag;
    final tagRounded = OudsThemeConfigModel.of(context)?.tag?.rounded ?? false;
    switch (tagRounded) {
      case true:
        return BorderRadius.circular(tag.borderRadius);
      case false:
        return BorderRadius.circular(OudsTheme.of(context).borderTokens.radiusNone);
    }
  }

}
