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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/form_input/internal/ouds_form_input_control_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A class that provides the tick color for the OudsTextInput based on its state and error status.
class OudsFormFieldsTextColorModifier {
  final BuildContext context;

  OudsFormFieldsTextColorModifier(this.context);

  Color getTextPasswordColor(OudsFormFieldsControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).contentDefault; // Color for enabled state with error
        case OudsFormFieldsControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true"); // Handle disabled state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).contentDefault; // Color for hovered state with error
        case OudsFormFieldsControlState.pressed:
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).contentDefault; // Color for focused state with error
        case OudsFormFieldsControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true"); // Handle readOnly state
        case OudsFormFieldsControlState.loading:
          throw StateError("Color not allowed for Loading state when error is true");
      }
    } else {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).contentMuted; // Color for selected state
        case OudsFormFieldsControlState.disabled:
          return colorsScheme(context).actionDisabled; // Color for disabled state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).contentMuted; // Color for hovered state
        case OudsFormFieldsControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for pressed state
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).contentMuted; // Color for focused state
        case OudsFormFieldsControlState.readOnly:
          return colorsScheme(context).contentMuted; // Color for readOnly state
        case OudsFormFieldsControlState.loading:
          return colorsScheme(context).contentMuted; // Color for selected state
      }
    }
  }

  /// Gets the text color based on the control state and error status.
  Color getTextColor(OudsFormFieldsControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).actionNegativeEnabled; // Color for enabled state with error
        case OudsFormFieldsControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true"); // Handle disabled state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).actionNegativeHover; // Color for hovered state with error
        case OudsFormFieldsControlState.pressed:
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsFormFieldsControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true"); // Handle readOnly state
        case OudsFormFieldsControlState.loading:
          throw StateError("Color not allowed for Loading state when error is true");
      }
    } else {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).contentMuted; // Color for selected state
        case OudsFormFieldsControlState.disabled:
          return colorsScheme(context).actionDisabled; // Color for disabled state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).contentMuted; // Color for hovered state
        case OudsFormFieldsControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for pressed state
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).contentMuted; // Color for focused state
        case OudsFormFieldsControlState.readOnly:
          return colorsScheme(context).contentMuted; // Color for readOnly state
        case OudsFormFieldsControlState.loading:
          return colorsScheme(context).contentMuted; // Color for selected state
      }
    }
  }

  /// Gets the helper text color based on the control state status.
  Color getHelperTextColor(OudsFormFieldsControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).contentStatusNegative; // Color for enabled state with error
        case OudsFormFieldsControlState.disabled:
          throw StateError("Color not allowed for disabled state when error is true"); // Handle disabled state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).contentStatusNegative; // Color for hovered state with error
        case OudsFormFieldsControlState.pressed:
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).contentStatusNegative; // Color for focused state with error
        case OudsFormFieldsControlState.readOnly:
          throw StateError("Color not allowed for readOnly state when error is true"); // Handle readOnly state
        case OudsFormFieldsControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).contentMuted; // Color for selected state
        case OudsFormFieldsControlState.disabled:
          return colorsScheme(context).contentMuted; // Color for disabled state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).contentMuted; // Color for hovered state
        case OudsFormFieldsControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for pressed state
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).contentMuted; // Color for focused state
        case OudsFormFieldsControlState.readOnly:
          return colorsScheme(context).contentMuted; // Color for readOnly state
        case OudsFormFieldsControlState.loading:
          return colorsScheme(context).contentMuted; // Color for selected state
      }
    }
  }

  /// Gets the suffix/prefix text color based on the control state status.
  Color getSuffixPrefixTextColor(OudsFormFieldsControlState state) {
    final colorsScheme = OudsTheme.of(context).colorScheme;
    switch (state) {
      case OudsFormFieldsControlState.enabled:
        return colorsScheme(context).contentMuted; // Color for selected state
      case OudsFormFieldsControlState.disabled:
        return colorsScheme(context).actionDisabled; // Color for disabled state
      case OudsFormFieldsControlState.hovered:
        return colorsScheme(context).contentMuted; // Color for hovered state
      case OudsFormFieldsControlState.pressed:
        return colorsScheme(context).contentMuted; // Color for pressed state
      case OudsFormFieldsControlState.focused:
        return colorsScheme(context).contentMuted; // Color for focused state
      case OudsFormFieldsControlState.readOnly:
        return colorsScheme(context).contentMuted; // Color for readOnly state
      case OudsFormFieldsControlState.loading:
        return colorsScheme(context).contentMuted; // Color for selected state
    }
  }

  /// Gets the hint text color (placeholder) based on the control state status.
  Color getHintTextColor(OudsFormFieldsControlState state) {
    final theme = OudsTheme.of(context);

    switch (state) {
      case OudsFormFieldsControlState.enabled:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.disabled:
        return theme.colorScheme(context).actionDisabled;
      case OudsFormFieldsControlState.hovered:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.pressed:
        // TODO: Handle this case.
        throw UnimplementedError();
      case OudsFormFieldsControlState.focused:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.readOnly:
        return theme.colorScheme(context).contentMuted;
      case OudsFormFieldsControlState.loading:
        return theme.colorScheme(context).contentMuted;
    }
  }

  /// Gets the cursor text color based on the control state status.
  Color getCursorTextColor(OudsFormFieldsControlState state, bool error) {
    final colorsScheme = OudsTheme.of(context).colorScheme;

    if (error) {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsFormFieldsControlState.disabled:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsFormFieldsControlState.pressed:
          throw UnimplementedError();
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsFormFieldsControlState.readOnly:
          return colorsScheme(context).actionNegativePressed; // Color for focused state with error
        case OudsFormFieldsControlState.loading:
          throw UnimplementedError("Error status for Loading state is not relevant");
      }
    } else {
      switch (state) {
        case OudsFormFieldsControlState.enabled:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsFormFieldsControlState.disabled:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsFormFieldsControlState.hovered:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsFormFieldsControlState.pressed:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsFormFieldsControlState.focused:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsFormFieldsControlState.readOnly:
          return colorsScheme(context).contentDefault; // Color for focused state
        case OudsFormFieldsControlState.loading:
          return colorsScheme(context).contentDefault; // Color for focused state
      }
    }
  }
}
