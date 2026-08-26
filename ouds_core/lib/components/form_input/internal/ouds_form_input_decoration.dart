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
/// {@category Text input}
/// {@category Phone number input}
library;

import 'dart:ui';

/// Configuration for a leading (prefix) icon in a text input.
///
/// Provides properties to customize the icon and its tinting behavior.
///
/// Parameters:
/// - [icon]: The name or path of the SVG asset to display.
/// - [tinted]: When `true` (default), the icon is colored with the theme's foreground color.
///   When `false`, the icon displays with its original colors (useful for multi-color icons).
///   Note: Untinted icons must ensure sufficient contrast with the background for accessibility.
class OudsTextInputPrefixIcon {
  /// The name or path of the SVG asset to display.
  final String icon;

  /// Controls whether the icon should be tinted with the theme color.
  /// Defaults to `true`.
  final bool tinted;

  const OudsTextInputPrefixIcon({required this.icon, this.tinted = true});
}

/// Configuration for a trailing (suffix) icon button in a text input.
///
/// Provides properties to customize the icon, its tinting behavior, and the press callback.
///
/// Parameters:
/// - [icon]: The name or path of the SVG asset to display.
/// - [tinted]: When `true` (default), the icon is colored with the theme's foreground color.
///   When `false`, the icon displays with its original colors (useful for multi-color icons).
///   Note: Untinted icons must ensure sufficient contrast with the background for accessibility.
/// - [onPressed]: Callback invoked when the icon button is pressed. If `null`, the button is disabled.
class OudsTextInputSuffixIconButton {
  /// The name or path of the SVG asset to display.
  final String icon;

  /// Controls whether the icon should be tinted with the theme color.
  /// Defaults to `true`.
  final bool tinted;

  /// Callback invoked when the icon button is pressed.
  /// If `null`, tapping the suffix icon will have no effect.
  final VoidCallback? onPressed;

  const OudsTextInputSuffixIconButton({
    required this.icon,
    this.tinted = true,
    this.onPressed,
  });
}

/// A circular loading indicator displayed in the text input.
///
/// @param progress The loading progress, where 0.0 represents no progress and 1.0 represents full progress.
///   Values outside of this range are coerced into the range.
///   Set this value to `null` to display a circular indeterminate progress indicator.
class OudsTextInputLoader {
  /// The progress value for determinate loading (0.0 to 1.0).
  /// If null, shows an indeterminate progress indicator.
  final double? progress;

  const OudsTextInputLoader({this.progress});

  /// Returns true if loading is active.
  bool get isLoading => progress != null;
}

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
    super.hasPrefix,
    super.suffix,
    super.errorText,
    super.loader,
    super.outlined = false,
    super.constrainedMaxWidth = false,
  });
}

/// Configuration for decorating the [OudsTextField] and [OudsPhoneNumberInput] widgets.
///
/// Provides properties to customize labels, hints, icons, helper and error texts,
/// loading states, and styling.
///
/// Parameters:
///
/// - [labelText]: The main label text displayed above or inside the input field.
///
/// - [helperText]: Additional information displayed below the input, often used to guide or assist the user.
///   Supports strong text formatting using `**bold**`.
///   Hyperlinks are not supported in helper text. Use the dedicated helper link component instead.
///
/// - [hintText]: A short placeholder or hint shown inside the input when empty,
///   describing the expected input.
///
/// - [suffixIcon]: An [OudsTextInputSuffixIconButton] displayed at the end of the input field,
///   commonly used for actions like clearing or toggling visibility.
///   Use [OudsTextInputSuffixIconButton] with [OudsTextInputSuffixIconButton.icon] to specify the icon,
///   [OudsTextInputSuffixIconButton.tinted] to control tinting (default: true),
///   and [OudsTextInputSuffixIconButton.onPressed] to handle press events.
///
/// - [prefixIcon]: An [OudsTextInputPrefixIcon] displayed at the start of the input field,
///   typically to indicate the type or purpose of input.
///   Use [OudsTextInputPrefixIcon.icon] to specify the icon and
///   [OudsTextInputPrefixIcon.tinted] to control tinting (default: true).
///
/// - [prefix]: A string displayed before the user's input, usually static text or units.
///
/// - [suffix]: A string displayed after the user's input, often used for units or context.
///
/// - [errorText]: Text shown below the input indicating an error state or invalid input.
///   Supports strong text formatting using `**bold**`.
///
/// - [loader]: An [OudsTextInputLoader] instance to display a loading indicator inside the input.
///   Use [OudsTextInputLoader] with optional [progress] value (0.0 to 1.0) for determinate loading,
///   or without progress for indeterminate loading. Use `null` to disable the loader.
///
/// - [outlined]: A boolean that determines if the input uses an outlined style or not.
///
/// - [constrainedMaxWidth]: When `true`, the item width is constrained to a maximum value defined by the design system.
///   When `false`, no specific width constraint is applied, allowing the component to size itself or follow external modifiers.
///   Defaults to `false`.
///
class OudsFormInputDecoration {
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final OudsTextInputSuffixIconButton? suffixIcon;
  final OudsTextInputPrefixIcon? prefixIcon;
  final String? prefix;
  final bool hasPrefix;
  final String? suffix;
  final String? errorText;
  final OudsTextInputLoader? loader;
  final bool? outlined;
  final bool constrainedMaxWidth;

  const OudsFormInputDecoration({
    this.labelText,
    this.helperText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.hasPrefix = false,
    this.suffix,
    this.errorText,
    this.loader,
    this.outlined = false,
    this.constrainedMaxWidth = false,
  });
}
