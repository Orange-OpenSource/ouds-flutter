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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/control/ouds_control_item.dart';
import 'package:ouds_core/components/radio_button/ouds_radio_button.dart';

///
/// [OUDS Radio Button Design Guidelines](https://unified-design-system.orange.com/472794e18/p/90c467-radio-button)
///
/// The **Radio button item variant** can function as a simple input with a label, or it can be combined with optional elements such as helper text,
/// additional  a divider, an outlined, or an icon, allowing it to suit various use cases.
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
/// - [additionalLabel]: Optional strong accompanying text for the main label.
/// - [helperTitle]: Optional text displayed below the label.
/// - [icon]: Optional icon displayed in the item. By default, it has a trailing position. If [reversed] is set to `true`, it is displayed as a leading element.
/// - [outlined]: Outlined is designed to stand out and draw the user’s attention.
/// - [reversed]: When `false`, the checkbox has a leading position and the optional [icon] has a trailing position. Otherwise, it is reversed.
/// - [readOnly]: Controls the read only state of the radio button item. When `true` the item's radio button is disabled but the texts, the icon and the outlined remain in
///   enabled color. Note that if it is set to `true` and [enabled] is set to `false`, the checkbox item will be displayed in disabled state.
/// - [enabled]: Controls the enabled state of the checkbox item. When `false`, the checkbox, the texts and the optional icon are disabled, and the item
///   will not be clickable
/// - [divider]: Controls the display of a divider at the bottom of the checkbox item.
///
///
/// ## You can use [OudsRadioButtonItem] like this :
///
/// ### State enabled :
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
///     additionalLabel: null,
///     helperTitle: null,
///     reversed: false,
///     readOnly: false,
///     icon: null,
///     isError: false,
///     divider: true,
///     outlined: false
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/enabled.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/enabled_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
///
/// ### State disabled :
///
/// The radio button is non-interactive and grayed out to indicate it cannot be selected or changed.
/// The label and helper text are  muted.
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: null,
///     title: 'Label',
///     additionalLabel: null,
///     helperTitle: null,
///     reversed: false,
///     readOnly: false,
///     icon: null,
///     isError: false,
///     divider: true,
///     outlined: false,
///     enabled: false,
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/disabled.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/disabled_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
/// ### State Read Only :
///
/// The radio button is displayed in a specific state (selected or unselected), but the user cannot modify it with a label and helper text visible.
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: null,
///     title: 'Label',
///     additionalLabel: null,
///     helperTitle: null,
///     reversed: false,
///     readOnly: true,
///     icon: null,
///     isError: false,
///     divider: true,
///     outlined: false,
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/read_only.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/read_only_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
/// ### Outline :
///
/// 'false' : This is the default layout of the component.
/// 'true' :  Outlined radio buttons are designed to stand out and draw the user’s attention.
///     They are often used to emphasize significant or impactful options that require careful consideration in the interface.
///
///
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///         // Handle radio button change state.
///     },
///     title: 'Label',
///     additionalLabel: null,
///     helperTitle: null,
///     reversed: false,
///     readOnly: false,
///     icon: null,
///     isError: false,
///     divider: true,
///     outlined: true
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/outlined.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/outlined_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
/// ### Reverse :
///
/// 'false' This is the default layout of the component. From left to right, the order of the elements is as follows: radio button / text / icon.
/// 'true' As its name suggests, this layout is the reversed mirror of the "Default" template. From left to right, the order of the elements is as follows: icon / text / radio button.
///   This variant is necessary for RTL mode and certain mobile use cases.
///
///
///
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///         // Handle radio button change state.
///     },
///     title: 'Label',
///     additionalLabel: null,
///     helperTitle: null,
///     reversed: true,
///     readOnly: false,
///     icon: null,
///     isError: false,
///     divider: true,
///     outlined: true
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/reversed.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/reversed_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
///
/// ### Additional label :
///
/// It is possible to display or hide strong accompanying text for the main label.
///
///
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///         // Handle radio button change state.
///     },
///     title: 'Label',
///     additionalLabel: 'text',
///     helperTitle: null,
///     reversed: true,
///     readOnly: false,
///     icon: null,
///     isError: false,
///     divider: true,
///     outlined: true
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/addi.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/addi_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
/// ### Icon + outlined +  helper text + additional text + divider:
///
///
///
/// ```dart
///  OudsRadioButtonItem<RadioOption>(
///    value: true,
///    groupValue: true,
///    onChanged: (RadioOption? value) {
///         // Handle radio button change state.
///     },
///     title: 'Label',
///     additionalLabel: 'text',
///     helperTitle: 'helper',
///     reversed: false,
///     readOnly: false,
///     icon: 'assets/ic_heart.svg',
///     isError: false,
///     divider: true,
///     outlined: true
/// );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/all_options.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/radiobutton/all_options_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>

class OudsRadioButtonItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final String title;
  final String? additionalLabel;
  final String? helperTitle;
  final String? icon;
  final bool outlined;
  final bool reversed;
  final bool readOnly;
  final bool isError;
  final bool enabled;
  final bool divider;

  const OudsRadioButtonItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.additionalLabel,
    this.helperTitle,
    this.icon,
    this.outlined = false,
    this.reversed = false,
    this.readOnly = false,
    this.isError = false,
    this.enabled = true,
    this.divider = false,
  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: _selected,
      readOnly: readOnly,
      child: OudsControlItem(
        text: title,
        additionalText: additionalLabel,
        helperText: helperTitle,
        icon: icon,
        error: isError,
        readOnly: readOnly,
        errorComponentName: "OudsRadioButtonItem",
        divider: divider,
        outlined: _selected == true ? outlined : false,
        selected: outlined,
        reversed: reversed,
        onTap: onChanged != null ? () => onChanged!(value) : null,
        indicator: () => OudsRadioButton<T>(
          value: value,
          groupValue: groupValue,
          onChanged: !readOnly && onChanged != null ? onChanged : null,
          isError: isError,
        ),
      ),
    );
  }
}
