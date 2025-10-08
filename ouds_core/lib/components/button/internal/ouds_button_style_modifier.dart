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
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/ouds_button_background_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_border_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/internal/ouds_button_foreground_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_padding_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsButtonStyleModifier {
  static ButtonStyle buildButtonStyle(
    BuildContext context, {
    required OudsButtonHierarchy hierarchy,
    required OudsButtonLayout layout,
    bool? border,
    OudsButtonControlState? buttonState,
  }) {
    return ButtonStyle(
      backgroundColor: OudsButtonBackgroundModifier.resolveBackgroundColor(context, hierarchy, buttonState),
      foregroundColor: OudsButtonForegroundModifier.resolveForegroundColor(context, hierarchy, buttonState),
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
            fontSize: OudsTheme.of(context).fontTokens.sizeLabelLarge,
            fontWeight: OudsTheme.of(context).fontTokens.weightLabelStrong,
            letterSpacing: OudsTheme.of(context).fontTokens.letterSpacingLabelLarge,
            fontFamily: OudsTheme.of(context).fontFamily,
            package: OudsTheme.of(context).packageName),
      ),
      side: OudsButtonBorderModifier.resolveBorderColor(context, hierarchy, buttonState),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: OudsButtonBorderModifier.getBorderRadius(context),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        OudsButtonPaddingModifier.getPadding(context, layout),
      ),
      minimumSize: WidgetStateProperty.all<Size>(
        Size(OudsTheme.of(context).componentsTokens(context).button.sizeMinWidth, OudsTheme.of(context).componentsTokens(context).button.sizeMinHeight),
      ),
      animationDuration: Duration.zero,
    );
  }
}
