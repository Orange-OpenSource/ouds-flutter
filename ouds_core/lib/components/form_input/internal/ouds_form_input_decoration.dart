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

import 'dart:ui';

/// Alias class for [OudsFormInputDecoration].
///
/// This class provides a shorter and more convenient name, [OudsInputDecoration],
/// which internally extends [OudsFormInputDecoration]. It inherits all properties and behaviors,
/// allowing you to use [OudsInputDecoration] as a drop-in replacement for [OudsFormInputDecoration].
class OudsInputDecoration extends OudsFormInputDecoration {
  /// Creates an instance of [OudsInputDecoration], which is an alias for [OudsFormInputDecoration].
  ///
  /// All parameters are forwarded to the superclass [OudsFormInputDecoration].
  ///
  /// [labelText], [helperText], etc., are optional and default to null.
  OudsInputDecoration({
    super.labelText,
    super.helperText,
    super.hintText,
    super.suffixIcon,
    super.prefixIcon,
    super.prefix,
    super.suffix,
    super.errorText,
    super.loader,
    super.outlined = null,
    super.onSuffixPressed,
  });
}

/// Configuration for decorating the [OudsformInput] widget.
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
/// - [suffixIcon]: A widget displayed at the end of the input field,
///   commonly used for actions like clearing or toggling visibility.
///
/// - [onSuffixPressed]: - Assign a function to handle specific actions, that is invoked when the [suffixIcon] is pressed.
///                      - If `null`, tapping the suffix icon will have no effect.
///
/// - [prefixIcon]: The name or path of an icon displayed at the start of the input field,
///   typically to indicate the type or purpose of input.
///
/// - [prefix]: A string displayed before the user's input, usually static text or units.
///
/// - [suffix]: A string displayed after the user's input, often used for units or context.
///
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
///
/// - [loader]: When true, displays a loading indicator inside the input.
///
/// - [outlined]: A boolean that determines if the input uses an outlined style or not.
///

class OudsFormInputDecoration {
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final String? suffixIcon;
  final String? prefixIcon;
  final String? prefix;
  final String? suffix;
  final String? errorText;
  final bool? loader;
  final bool? outlined;
  final VoidCallback? onSuffixPressed;

  const OudsFormInputDecoration({
    this.labelText,
    this.helperText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.errorText,
    this.loader,
    this.outlined = false,
    this.onSuffixPressed,
  });
}
