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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the tick color for the OudsTextInput/ OudsPinCodeInput based on its state and error status.
class OudsTextInputTextColorModifier {
  final BuildContext context;

  OudsTextInputTextColorModifier(this.context);

  /// Gets the text color based on the control state and error status.
  Color getTextColor(OudsTextInputControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return colorsScheme(context).actionNegativeEnabled; // Color for enabled state with error
        case OudsTextInputControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true"); // Handle disabled state
        case OudsTextInputControlState.hovered:
          return colorsScheme(context).actionNegativeHover; // Color for hovered state with error
        case OudsTextInputControlState.pressed:
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsTextInputControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true"); // Handle readOnly state
        case OudsTextInputControlState.loading:
          throw StateError("Color not allowed for Loading state when error is true");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return colorsScheme(context).contentMuted; // Color for selected state
        case OudsTextInputControlState.disabled:
          return colorsScheme(context).actionDisabled; // Color for disabled state
        case OudsTextInputControlState.hovered:
          return colorsScheme(context).contentMuted; // Color for hovered state
        case OudsTextInputControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for pressed state
        case OudsTextInputControlState.focused:
          return colorsScheme(context).contentMuted; // Color for focused state
        case OudsTextInputControlState.readOnly:
          return colorsScheme(context).contentMuted; // Color for readOnly state
        case OudsTextInputControlState.loading:
          return colorsScheme(context).contentMuted; // Color for selected state
      }
    }
  }

  /// Gets the helper text color based on the control state status.
  Color getHelperTextColor(OudsTextInputControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return colorsScheme(context).contentStatusNegative; // Color for enabled state with error
        case OudsTextInputControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true"); // Handle disabled state
        case OudsTextInputControlState.hovered:
          return colorsScheme(context).contentStatusNegative; // Color for hovered state with error
        case OudsTextInputControlState.pressed:
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return colorsScheme(context).contentStatusNegative; // Color for focused state with error
        case OudsTextInputControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true"); // Handle readOnly state
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return colorsScheme(context).contentMuted; // Color for selected state
        case OudsTextInputControlState.disabled:
          return colorsScheme(context).contentMuted; // Color for disabled state
        case OudsTextInputControlState.hovered:
          return colorsScheme(context).contentMuted; // Color for hovered state
        case OudsTextInputControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for pressed state
        case OudsTextInputControlState.focused:
          return colorsScheme(context).contentMuted; // Color for focused state
        case OudsTextInputControlState.readOnly:
          return colorsScheme(context).contentMuted; // Color for readOnly state
        case OudsTextInputControlState.loading:
          return colorsScheme(context).contentMuted; // Color for selected state
      }
    }
  }

  /// Gets the suffix/prefix text color based on the control state status.
  Color getSuffixPrefixTextColor(OudsTextInputControlState state) {
    final colorsScheme = OudsTheme.of(context).colorScheme;
    switch (state) {
      case OudsTextInputControlState.enabled:
        return colorsScheme(context).contentMuted; // Color for selected state
      case OudsTextInputControlState.disabled:
        return colorsScheme(context).actionDisabled; // Color for disabled state
      case OudsTextInputControlState.hovered:
        return colorsScheme(context).contentMuted; // Color for hovered state
      case OudsTextInputControlState.pressed:
        return colorsScheme(context).contentMuted; // Color for pressed state
      case OudsTextInputControlState.focused:
        return colorsScheme(context).contentMuted; // Color for focused state
      case OudsTextInputControlState.readOnly:
        return colorsScheme(context).contentMuted; // Color for readOnly state
      case OudsTextInputControlState.loading:
        return colorsScheme(context).contentMuted; // Color for selected state
    }
  }

  /// Gets the hint text color (placeholder) based on the control state status.
  Color getHintTextColor(OudsTextInputControlState state) {
    final theme = OudsTheme.of(context);

    switch (state) {
      case OudsTextInputControlState.enabled:
        return theme.colorScheme(context).contentMuted;
      case OudsTextInputControlState.disabled:
        return theme.colorScheme(context).actionDisabled;
      case OudsTextInputControlState.hovered:
        return theme.colorScheme(context).contentMuted;
      case OudsTextInputControlState.pressed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OudsTextInputControlState.focused:
        return theme.colorScheme(context).contentMuted;
      case OudsTextInputControlState.readOnly:
        return theme.colorScheme(context).contentMuted;
      case OudsTextInputControlState.loading:
        throw StateError("Empty status (hint) for Loading state is not relevant");
    }
  }

  /// Gets the cursor text color based on the control state status.
  Color getCursorTextColor(OudsTextInputControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsTextInputControlState.disabled:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsTextInputControlState.hovered:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsTextInputControlState.pressed:
          throw UnimplementedError();
        case OudsTextInputControlState.focused:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsTextInputControlState.readOnly:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsTextInputControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsTextInputControlState.enabled:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsTextInputControlState.disabled:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsTextInputControlState.hovered:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsTextInputControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsTextInputControlState.focused:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsTextInputControlState.readOnly:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsTextInputControlState.loading:
          return colorsScheme(context).contentDefault; // Color for focused state
      }
    }
  }

  // todo (should create a new class for pin code or create a controller for both text input and pin code input components)
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
