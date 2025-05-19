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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/button_background_modifier.dart';
import 'package:ouds_core/components/button/internal/button_border_modifier.dart';
import 'package:ouds_core/components/button/internal/button_foreground_modifier.dart';
import 'package:ouds_core/components/button/internal/button_padding_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class ButtonStyleModifier {
  static ButtonStyle buildButtonStyle(
    BuildContext context, {
    required OudsButtonHierarchy hierarchy,
    required OudsButtonLayout layout,
    OudsButtonStyle? style,
  }) {
    double iconSize;
    if (layout == OudsButtonLayout.iconOnly) {
      iconSize = OudsTheme.of(context).componentsTokens(context).button.sizeIconOnly;
    } else if (layout == OudsButtonLayout.iconAndText) {
      iconSize = OudsTheme.of(context).componentsTokens(context).button.sizeIcon;
    } else {
      iconSize = 0.0;
    }

    return ButtonStyle(
      backgroundColor: ButtonBackgroundModifier.resolveBackgroundColor(context, hierarchy, style),
      foregroundColor: ButtonForegroundModifier.resolveForegroundColor(context, hierarchy, style),
      iconColor: ButtonForegroundModifier.resolveForegroundColor(context, hierarchy, style),
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      iconSize: WidgetStateProperty.all<double>(iconSize),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
            fontSize: OudsTheme.of(context).fontTokens.sizeLabelLarge,
            fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
            letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelLarge,
            fontFamily: OudsTheme.of(context).fontFamily,
            package: OudsTheme.of(context).packageName),
      ),
      side: ButtonBorderModifier.resolveBorderColor(context, hierarchy, style),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OudsTheme.of(context).componentsTokens(context).button.borderRadius),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        ButtonPaddingModifier.getPadding(context, layout),
      ),
      minimumSize: WidgetStateProperty.all<Size>(
        Size(OudsTheme.of(context).componentsTokens(context).button.sizeMinWidth, OudsTheme.of(context).componentsTokens(context).button.sizeMinHeight),
      ),
      animationDuration: Duration.zero,
    );
  }
}
