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
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization.dart';
import 'package:ouds_flutter_demo/ui/components/button/button_customization_utils.dart';

/// Generates Flutter code snippets for the [OudsNavigationButton] component
/// based on the current [ButtonCustomizationState].
///
/// Used by [NavigationButtonDemoScreen] to display a live code preview that
/// reflects the user's customization choices (layout, appearance, loader,
/// full-width, enabled state, colored box).
///
/// Example output for a "next" navigation button:
/// ```dart
/// OudsNavigationButton(
///   label: "Next step",
///   layout: OudsNavigationButtonLayout.next,
///   appearance: OudsNavigationButtonAppearance.defaultAppearance,
///   onPressed: () {},
/// );
/// ```
class NavigationButtonCodeGenerator {
  /// Generates the complete code string for [OudsNavigationButton] based on
  /// the current customization state read from [context].
  ///
  /// Returns an empty string if no customization state is found.
  static String updateCode(BuildContext context) {
    final ButtonCustomizationState? customizationState = ButtonCustomization.of(
      context,
    );
    if (customizationState == null) return '';

    final OudsNavigationButtonLayout layout =
        ButtonCustomizationUtils.getNavigationLayout(
          customizationState.selectedChevron,
        );

    final OudsNavigationButtonAppearance appearance =
        ButtonCustomizationUtils.getNavigationAppearance(
          customizationState.selectedNavigationAppearance,
        );

    final String? label = customizationState.navigationTextValue.isNotEmpty
        ? customizationState.navigationTextValue
        : null;

    final String layoutStr = layout.toString();
    final String appearanceStr = appearance.toString();

    final String labelLine = label != null ? '\nlabel: "$label",' : '';
    final String loaderLine = _loaderCodeModifier(customizationState);
    final String fullWidthLine = _fullWidthCodeModifier(customizationState);
    final String onPressedLine = _disableCode(customizationState);
    final String coloredBoxPrefix = _coloredBoxPrefix(customizationState);
    final String coloredBoxSuffix = _coloredBoxSuffix(customizationState);

    return '''${coloredBoxPrefix}OudsNavigationButton($labelLine
layout: $layoutStr,
appearance: $appearanceStr,$fullWidthLine$loaderLine
$onPressedLine$coloredBoxSuffix''';
  }

  /// Returns the `loader:` line when the loader is enabled.
  static String _loaderCodeModifier(ButtonCustomizationState state) {
    return state.hasLoader ? '\nloader: Loader(progress: null),' : '';
  }

  /// Returns the `isFullWidth:` line when full-width is enabled.
  static String _fullWidthCodeModifier(ButtonCustomizationState state) {
    return state.hasFullWidth ? '\nisFullWidth: true,' : '';
  }

  /// Returns the `onPressed:` line with enabled or disabled callback.
  ///
  /// Also closes the widget with the appropriate parenthesis depending on
  /// whether a colored box wrapper is present.
  static String _disableCode(ButtonCustomizationState state) {
    final String end = state.hasOnColoredBox ? ' ),\n);' : ');';
    final String callback = state.hasEnabled == true ? '() {}' : 'null';
    return 'onPressed: $callback,\n$end';
  }

  /// Returns the `OudsColoredBox(` opening wrapper when the colored box is enabled.
  static String _coloredBoxPrefix(ButtonCustomizationState state) {
    if (state.hasOnColoredBox) {
      return 'OudsColoredBox(\ncolor: OudsColoredBoxColor.brandPrimary,\nchild: ';
    }
    return '';
  }

  /// Returns an empty string (closing is handled inside [_disableCode]).
  static String _coloredBoxSuffix(ButtonCustomizationState state) => '';
}
