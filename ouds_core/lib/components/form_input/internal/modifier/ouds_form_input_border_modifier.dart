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
import 'package:ouds_core/components/form_input/internal/ouds_form_input_control_state.dart';
import 'package:ouds_core/components/form_input/ouds_text_input.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the border color for the OudsTextInput based on its state and selection
class OudsFormFieldsBorderModifier {
  final BuildContext context;

  OudsFormFieldsBorderModifier(this.context);

  /// Gets the borderSide based on the text input state and whether it is selected
  Border getBorder(OudsFormFieldsControlState state, [bool isError = false, OudsFormFieldsStyle? style]) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);
    final defaultStyle = style == OudsFormFieldsStyle.defaultStyle;

    if (isError) {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return Border(
            bottom: BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
            top: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
            left: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
            right: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeEnabled, width: textInput.borderWidthDefault),
          );
        case OudsFormFieldsControlState.disabled:
          throw UnimplementedError("Error status for Disabled state is not relevant");
        case OudsFormFieldsControlState.hovered:
          return Border(
            bottom: BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
            top: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
            left: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
            right: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativeHover, width: textInput.borderWidthDefault),
          );
        case OudsFormFieldsControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return Border(
            bottom: BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
            top: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
            left: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
            right: defaultStyle ? BorderSide.none : BorderSide(color: theme.colorScheme(context).actionNegativePressed, width: textInput.borderWidthFocus),
          );
        case OudsFormFieldsControlState.readOnly:
          throw UnimplementedError("Error status for Read only state is not relevant");
        case OudsFormFieldsControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsFormFieldsControlState.disabled:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsFormFieldsControlState.hovered:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsFormFieldsControlState.pressed:
          // TODO: Handle this case.
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return Border(
            bottom: getBorderSideByState(state),
            top: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            left: defaultStyle ? BorderSide.none : getBorderSideByState(state),
            right: defaultStyle ? BorderSide.none : getBorderSideByState(state),
          );
        case OudsFormFieldsControlState.readOnly:
          return Border(
            bottom: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
            top: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
            left: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
            right: defaultStyle ? getBorderSideByState(state) : BorderSide.none,
          );
        case OudsFormFieldsControlState.loading:
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
  BorderSide getBorderSideByState(OudsFormFieldsControlState state) {
    final textInput = OudsTheme.of(context).componentsTokens(context).textInput;
    final theme = OudsTheme.of(context);

    switch (state) {
      case OudsFormFieldsControlState.enabled:
        return BorderSide(color: textInput.colorBorderEnabled, width: textInput.borderWidthDefault);
      case OudsFormFieldsControlState.disabled:
        return BorderSide(color: theme.colorScheme(context).actionDisabled, width: textInput.borderWidthDefault);
      case OudsFormFieldsControlState.hovered:
        return BorderSide(color: textInput.colorBorderHover, width: textInput.borderWidthDefault);
      case OudsFormFieldsControlState.pressed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OudsFormFieldsControlState.focused:
        return BorderSide(color: textInput.colorBorderFocus, width: textInput.borderWidthFocus);
      case OudsFormFieldsControlState.readOnly:
        return BorderSide(color: theme.colorScheme(context).borderMuted, width: textInput.borderWidthDefault);
      case OudsFormFieldsControlState.loading:
        return BorderSide(color: textInput.colorBorderLoading, width: textInput.borderWidthDefault);
    }
  }

  /// Static method to get the border radius for a text input based on the border parameter.
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
