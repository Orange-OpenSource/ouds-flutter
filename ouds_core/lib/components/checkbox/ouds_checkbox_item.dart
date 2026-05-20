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

/// {@category Checkbox}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/checkbox/ouds_checkbox.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';

///
/// [OUDS Checkbox design guidelines](https://r.orange.fr/r/S-ouds-doc-checkbox)
///
/// **Reference design version : 2.4.0**
///
/// Checkbox item is a UI element that allows to select multiple options from a set of mutually non exclusive choices. Checkbox item covers a wider range of
/// contexts by allowing to toggle the visibility of additional text labels and icon assets.
///
/// The **checkbox item variant** can function as a simple input with a label, or it can be combined with optional elements such as helper text, a divider, or an icon,
/// allowing it to suit various use cases.
///
/// The OUDS checkbox item layout contains an [OudsCheckbox]. By clicking on a checkbox item, the user changes the checked state of its checkbox.
///
/// In most cases, OUDS checkbox items span the entire width of the screen. Thus an horizontal padding is applied to the content.
/// This behavior can be disabled by setting the [inverted] parameter to `true`.
///
/// If you want to use a standalone checkbox please use [OudsCheckbox].
///
/// If you need an indeterminate state for the item's checkbox, please use the [tristate] parameter.
///
/// - [value]: Controls checked state of the item's checkbox.
/// - [onChanged]:e Callback invoked on checkbox item click. If `null`, then this is passive and relies entirely on a higher-level component to control
///   the checked state.
/// - [title]: The main label of the checkbox item.
/// - [helperTitle]: Optional text displayed below the label.
/// - [icon]: Optional icon displayed in the item. By default, it has a trailing position. If [reversed] is set to `true`, it is displayed as a leading element.
/// - [reversed]: When `false`, the checkbox has a leading position and the optional [icon] has a trailing position. Otherwise, it is reversed.
/// - [readOnly]: Controls the read only state of the checkbox item. When `true` the item's checkbox is disabled but the texts and the icon remain in
///   enabled color. Note that if it is set to `true` and [enabled] is set to `false`, the checkbox item will be displayed in disabled state.
/// - [isError]: Controls the error state of the checkbox item.
/// - [enabled]: Controls the enabled state of the checkbox item. When `false`, the checkbox, the texts and the optional icon are disabled, and the item
///   will not be clickable
/// - [divider]: Controls the display of a divider at the bottom of the checkbox item.
/// - [tristate]: Controls the tristate behavior of the checkbox item.
/// - [constrainedMaxWidth]: When `true`, the item width is constrained to a maximum value defined by the design system.
///   When `false`, no specific width constraint is applied, allowing the component to size itself or follow external modifiers.
///   Defaults to `false`.
/// - [errorText]: Text shown below the checkbox item indicating an error state. Supports only strong text formatting using `**bold**`.
///   Rich text is supported only for error messages.
///
///
/// ### You can use [OudsCheckboxItem] component in your project, customizing parameters as needed :
///
///
/// **Ouds checkbox item with icon and helper text :**
///
/// It is possible to display or hide an icon. If displayed, this option includes functionality to choose any Solaris icon.
/// It is possible to display or hide accompanying text for the main label.
///
/// ```dart
/// OudsCheckboxItem(
///   value: isChecked,
///   title: 'Label',
///   helperTitle: 'Helper text',
///   reversed: false,
///   readOnly: false,
///   icon: 'assets/ic_heart/svg',
///   isError: false,
///   divider: true,
///   onChanged: (bool? value) {
///      setState(() {
///         isChecked = value;
///       });
///     },
/// );
/// ```
///
///

class OudsCheckboxItem extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String title;
  final String? helperTitle;
  final String? icon;
  final bool reversed;
  final bool readOnly;
  final bool isError;
  final String? errorText;
  final bool enabled;
  final bool divider;
  final bool tristate;
  final bool constrainedMaxWidth;

  const OudsCheckboxItem({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.helperTitle,
    this.icon,
    this.reversed = false,
    this.readOnly = false,
    this.isError = false,
    this.errorText,
    this.enabled = true,
    this.divider = false,
    this.tristate = false,
    this.constrainedMaxWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    /*final l10n = OudsLocalizations.of(context);

    String? semanticValue = value == true
        ? l10n?.core_checkbox_checked_a11y
        : value == null
            ? l10n?.core_checkbox_indeterminate_a11y
            : l10n?.core_checkbox_unchecked_a11y;

    // add “double tap to toggle”
    String toggleActionLabel = (onChanged != null && !readOnly) ? '${l10n?.core_checkbox_hint_a11y}' : '';
*/
    return OudsControlItem(
      text: title,
      description: helperTitle,
      icon: icon,
      error: isError,
      errorText: errorText,
      readOnly: readOnly,
      errorComponentName: "OudsCheckboxItem",
      componentType: OudsControlItemType.checkbox,
      divider: divider,
      constrainedMaxWidth: constrainedMaxWidth,
      reversed: reversed,
      onTap: onChanged != null
          ? () {
              bool? newValue;
              if (tristate) {
                if (value == true) {
                  newValue = null;
                } else if (value == null) {
                  newValue = false;
                } else {
                  newValue = true;
                }
              } else {
                newValue = !(value ?? false);
              }
              onChanged!(newValue);
            }
          : null,
      indicator: () => OudsCheckbox(
        value: value,
        onChanged: !readOnly && onChanged != null ? onChanged : null,
        isError: isError,
        tristate: tristate,
        readOnly: readOnly,
      ),
    );
  }
}
