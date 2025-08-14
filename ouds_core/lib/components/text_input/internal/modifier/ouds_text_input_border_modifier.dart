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
import 'package:ouds_core/components/text_input/internal/ouds_text_input_control_state.dart';
import 'package:ouds_core/components/text_input/ouds_text_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the border color for the OudsChip based on its state and selection
class OudsTextInputBorderModifier {
  final BuildContext context;

  OudsTextInputBorderModifier(this.context);

  /// Gets the borderSide based on the chip state and whether it is selected
  Border getBorder(OudsTextInputControlState state, [bool isError = false, OudsTextInputStyle? style]) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);
    final defaultStyle = style == OudsTextInputStyle.defaultStyle;

    if (isError) {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return Border(
            bottom: BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
            top: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
            left: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
            right: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
          );
        case OudsTextInputControlState.disabled:
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsTextInputControlState.hovered:
          return Border(
            bottom: BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
            top: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
            left: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
            right: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
          );
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return Border(
            bottom: BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
            top: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
            left: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
            right: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
          );
        case OudsTextInputControlState.readOnly:
          throw UnimplementedError("Error status for Read only state is not relevant");
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsTextInputControlState.disabled:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsTextInputControlState.hovered:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsTextInputControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsTextInputControlState.readOnly:
          return Border(
            bottom: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
            top: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
            left: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
            right: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
          );
        case OudsTextInputControlState.loading:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
      }
    }
  }

  /// Returns a [BorderSide] based on the given [OudsTextInputControlState].
  ///
  /// Uses [OudsTheme] to pick the border color and width for each state:
  /// - enabled → `colorBorderEnabled`, `borderWidthDefault`
  /// - disabled → `actionDisabled`, `borderWidthDefault`
  /// - hovered → `colorBorderHover`, `borderWidthDefault`
  /// - pressed → not implemented (throws [UnimplementedError])
  /// - focused → `colorBorderFocus`, `borderWidthFocus`
  /// - readOnly → `borderMuted`, `borderWidthDefault`
  /// - loading → `colorBorderLoading`, `borderWidthDefault`
  BorderSide getBorderSideByState(OudsTextInputControlState state) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    switch (state) {
      case OudsTextInputControlState.enabled:
        return BorderSide(color: textInput.colorBorderEnabled, width: textInput.borderWidthDefault);
      case OudsTextInputControlState.disabled:
        return BorderSide(color: theme.colorScheme(context).actionDisabled, width: textInput.borderWidthDefault);
      case OudsTextInputControlState.hovered:
        return BorderSide(color: textInput.colorBorderHover, width: textInput.borderWidthDefault);
      case OudsTextInputControlState.pressed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OudsTextInputControlState.focused:
        return BorderSide(color: textInput.colorBorderFocus, width: textInput.borderWidthFocus);
      case OudsTextInputControlState.readOnly:
        return BorderSide(color: theme.colorScheme(context).borderMuted, width: textInput.borderWidthDefault);
      case OudsTextInputControlState.loading:
        return BorderSide(color: textInput.colorBorderLoading, width: textInput.borderWidthDefault);
    }
  }

  /// Static method to get the border radius for a button based on the border parameter.
  /// Returns a [BorderRadius] object with the appropriate radius value.
  BorderRadius getBorderRadius(BuildContext context, bool? border) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    switch (border!) {
      case true:
        return BorderRadius.circular(textInput.borderRadiusRounded);
      case false:
        return BorderRadius.circular(textInput.borderRadiusDefault);
    }
  }
}
