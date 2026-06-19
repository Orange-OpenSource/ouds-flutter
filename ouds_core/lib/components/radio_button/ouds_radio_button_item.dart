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

/// {@category Radio button}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button.dart';

///
/// [OUDS Radio Button Design Guidelines](https://r.orange.fr/r/S-ouds-doc-radio-button)
///
/// **Reference design version : 1.4.0**
///
/// Radio button item is a UI element that allows to select a single option from a set of mutually exclusive choices.
/// Radio button item covers a wider range of contexts by allowing to toggle the visibility of additional text labels and icon assets.
///
/// The OUDS Radio button item layout contains an [OudsRadioButton]. By clicking on a radiobutton item, the user changes the checked state of its radio button.
///
/// If you want to use a standalone radio button please use [OudsRadioButton].
///
/// Parameters:
/// - [value] The value represented by this radio button. Used to determine selection.
/// - [groupValue] The currently selected value in the radio button group.
/// This radio button is considered selected if [value] == [groupValue].
/// - [onChanged] Callback triggered when the user selects this radio button. If `null`, the radio button is disabled and non-interactive.
/// - [isError] Indicates whether the radio button is in an error state.
/// - [title]: The main label of the radio button item.
/// - [extraLabelText]: Optional strong accompanying text for the main label.
/// - [helperTitle]: Optional text displayed below the label.
/// - [icon]: Optional icon displayed in the item. By default, it has a trailing position. If [reversed] is set to `true`, it is displayed as a leading element.
/// - [outlined]: Outlined is designed to stand out and draw the user’s attention.
/// - [reversed]: When `false`, the checkbox has a leading position and the optional [icon] has a trailing position. Otherwise, it is reversed.
/// - [readOnly]: Controls the read only state of the radio button item. When `true` the item's radio button is disabled but the texts, the icon and the outlined remain in
///   enabled color. Note that if it is set to `true` and [enabled] is set to `false`, the checkbox item will be displayed in disabled state.
/// - [enabled]: Controls the enabled state of the checkbox item. When `false`, the checkbox, the texts and the optional icon are disabled, and the item
///   will not be clickable
/// - [divider]: Controls the display of a [OudsDivider] at the bottom of the checkbox item.
/// - [constrainedMaxWidth]: When `true`, the item width is constrained to a maximum value defined by the design system.
///   When `false`, no specific width constraint is applied, allowing the component to size itself or follow external modifiers.
///   Defaults to `false`.
/// - [errorText]: Text shown below the radio button item indicating an error state. Supports only strong text formatting using `**bold**`.
///   Rich text is supported only for error messages.
///
///
/// ### You can use [OudsRadioButtonItem] component in your project, customizing parameters as needed :
///
/// **State enabled :**
///
/// The default active state where the radio button is functional and selectable.
/// It may show an unselected or selected style, with a label and helper text visible.
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///         // Handle radio button change state.
///     },
///     title: 'Label',
///     extraLabelText: 'Extra label',
///     helperTitle: 'Helper text',
///     reversed: false,
///     readOnly: false,
///     icon: 'assets/ic_heart.svg',
///     isError: false,
///     divider: true,
///     outlined: false
/// );
/// ```
///

class OudsRadioButtonItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? extraLabelText;
  final String? helperTitle;
  final String? icon;
  final bool outlined;
  final bool reversed;
  final bool readOnly;
  final bool isError;
  final String? errorText;
  final bool enabled;
  final bool divider;
  final bool constrainedMaxWidth;

  const OudsRadioButtonItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.extraLabelText,
    this.helperTitle,
    this.icon,
    this.outlined = false,
    this.reversed = false,
    this.readOnly = false,
    this.isError = false,
    this.errorText,
    this.enabled = true,
    this.divider = false,
    this.constrainedMaxWidth = false,
  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      readOnly: readOnly,
      child: OudsControlItem(
        text: title,
        extraLabelText: extraLabelText,
        description: helperTitle,
        icon: icon,
        error: isError,
        errorText: errorText,
        readOnly: readOnly,
        errorComponentName: "OudsRadioButtonItem",
        componentType: OudsControlItemType.radio,
        divider: divider,
        constrainedMaxWidth: constrainedMaxWidth,
        outlined: _selected == true ? outlined : false,
        selected: outlined,
        reversed: reversed,
        onTap: onChanged != null ? () => onChanged!(value) : null,
        indicator: () => OudsRadioButton<T>(
          value: value,
          groupValue: groupValue,
          onChanged: !readOnly && onChanged != null ? onChanged : null,
          isError: isError,
          readOnly: readOnly,
        ),
      ),
    );
  }
}
