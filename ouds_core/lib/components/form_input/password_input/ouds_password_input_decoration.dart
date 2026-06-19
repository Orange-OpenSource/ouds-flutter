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

/// {@category Password input}
library;

/// Configuration for decorating the [OudsPasswordInput] widget.
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
/// - [prefixIcon]: A boolean indicating whether to display a lock icon at the start of the input field.
///   When true, displays a lock icon.
///
/// - [prefix]: A string displayed before the user's input, usually static text or units.
///
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
///
/// - [loader]: When true, displays a loading indicator inside the input.
///
/// - [constrainedMaxWidth]: When `true`, the item width is constrained to a maximum value defined by the design system.
///   When `false`, no specific width constraint is applied, allowing the component to size itself or follow external modifiers.
///   Defaults to `false`.
///

class OudsPasswordInputDecoration {
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final bool? prefixIcon;
  final String? prefix;
  final String? errorText;
  final bool? loader;
  final bool? outlined;
  final bool constrainedMaxWidth;

  const OudsPasswordInputDecoration({
    this.labelText,
    this.helperText,
    this.hintText,
    this.prefixIcon,
    this.prefix,
    this.errorText,
    this.loader,
    this.outlined = false,
    this.constrainedMaxWidth = false,
  });
}
