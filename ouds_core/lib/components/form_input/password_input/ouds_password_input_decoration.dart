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

import 'package:ouds_core/components/form_input/internal/ouds_form_input_enum.dart';

/// Configuration for decorating the [OudsTextInput] widget.
///
/// Provides properties to customize labels, hints, icons, helper and error texts,
/// loading states, and styling.
///
/// Parameters:
///
/// - [labelText]: The main label text displayed above or inside the input field.
///
/// - [helperText]: Additional information displayed below the input,
///   often used to guide or assist the user.
///
/// - [hintText]: A short placeholder or hint shown inside the input when empty,
///   describing the expected input.
///
/// - [suffixIcon]: A boolean indicating whether to display an icon at the end of the input field.
///   When true, displays an `OudsButton` icon for toggling password visibility.
///
/// - [prefixIcon]: A boolean indicating whether to display a lock icon at the start of the input field.
///   When true, displays a lock icon.
///
/// - [prefix]: A string displayed before the user's input, usually static text or units.
///
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
///
/// - [loader]: When true, displays a loading indicator inside the input.
///
/// - [style]: The visual style of the input, e.g., default or alternative styles.
class OudsPasswordInputDecoration {
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final bool? suffixIcon;
  final bool? prefixIcon;
  final String? prefix;
  final String? errorText;
  final bool? loader;
  final OudsFormFieldsStyle? style;

  const OudsPasswordInputDecoration({
    this.labelText,
    this.helperText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.errorText,
    this.loader,
    this.style = OudsFormFieldsStyle.defaultStyle,
  });
}
