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
    required OudsButtonAppearance appearance,
    required OudsButtonLayout layout,
    OudsButtonControlState? buttonState,
  }) {
    return ButtonStyle(
      backgroundColor: OudsButtonBackgroundModifier.resolveBackgroundColor(context, appearance, buttonState),
      foregroundColor: OudsButtonForegroundModifier.resolveForegroundColor(context, appearance, buttonState),
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      textStyle: WidgetStateProperty.all<TextStyle>(
        OudsTheme.of(context).typographyTokens.typeLabelStrongLarge(context),
      ),
      side: OudsButtonBorderModifier.resolveBorderColor(context, appearance, buttonState),
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
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,// this added to eliminate the white space between container and outlined button in orange compact in focus state
      animationDuration: Duration.zero,
    );
  }
}
