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
import 'package:ouds_core/components/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The typography family showcased by the typography demo/customization screens.
enum TypographyVariant { display, heading, body, label /*code*/ }

/// The color options exposed by the typography customization screen. [defaultColor] lets the
/// component fall back to the theme's default content color (no override).
enum TypographyEnumColor {
  defaultColor,
  brandPrimary,
  onBrandPrimary,
  statusPositive,
  statusNegative,
}

/// Resolves a [TypographyEnumColor] to the actual [Color] defined by the active theme.
/// Returns `null` for [TypographyEnumColor.defaultColor] so the component uses its own default.
Color? resolveTypographyColor(BuildContext context, TypographyEnumColor color) {
  final colorScheme = OudsTheme.of(context).colorScheme(context);
  switch (color) {
    case TypographyEnumColor.defaultColor:
      return null;
    case TypographyEnumColor.brandPrimary:
      return colorScheme.contentBrandPrimary;
    case TypographyEnumColor.onBrandPrimary:
      return colorScheme.contentOnBrandPrimary;
    case TypographyEnumColor.statusPositive:
      return colorScheme.contentStatusPositive;
    case TypographyEnumColor.statusNegative:
      return colorScheme.contentStatusNegative;
  }
}

/// Formats an enum value name (e.g. `defaultXLarge`) into a human readable, sentence-case label
/// (e.g. `Default x large`). `defaultWeight` and `defaultColor` are special-cased to `Default`.
extension TypographySizeFormattedName on Enum {
  String get formattedName {
    if (name == 'defaultWeight' || name == 'defaultColor') return 'Default';
    final words = name.split(RegExp(r'(?=\p{Lu})', unicode: true));
    final joined = words.map((w) => w.toLowerCase()).join(' ').trim();
    return joined[0].toUpperCase() + joined.substring(1);
  }
}

/// Returns the list of available sizes for the given [variant].
List<Object> sizesFor(TypographyVariant variant) {
  switch (variant) {
    case TypographyVariant.display:
      return OudsDisplayTextSize.values;
    case TypographyVariant.heading:
      return OudsHeadingTextSize.values;
    case TypographyVariant.body:
      return OudsBodyTextSize.values;
    case TypographyVariant.label:
      return OudsLabelTextSize.values;
    //case TypographyVariant.code:return OudsCodeTextSize.values;
  }
}

/// Returns the default size used to preview the given [variant].
Object defaultSizeFor(TypographyVariant variant) {
  switch (variant) {
    case TypographyVariant.display:
      return OudsDisplayTextSize.large;
    case TypographyVariant.heading:
      return OudsHeadingTextSize.xLarge;
    case TypographyVariant.body:
      return OudsBodyTextSize.large;
    case TypographyVariant.label:
      return OudsLabelTextSize.xLarge;
    // case TypographyVariant.code:return OudsCodeTextSize.medium;
  }
}

/// Whether the given [variant] exposes a `weight` (default, moderate, strong) parameter.
bool hasWeightFor(TypographyVariant variant) =>
    variant == TypographyVariant.body || variant == TypographyVariant.label;

/// Returns the [OudsTypography] subclass name matching the given [variant].
String classNameFor(TypographyVariant variant) {
  switch (variant) {
    case TypographyVariant.display:
      return 'OudsDisplayText';
    case TypographyVariant.heading:
      return 'OudsHeadingText';
    case TypographyVariant.body:
      return 'OudsBodyText';
    case TypographyVariant.label:
      return 'OudsLabelText';
    // case TypographyVariant.code:return 'OudsCodeText';
  }
}

/// Returns the size enum type name matching the given [variant].
String sizeEnumNameFor(TypographyVariant variant) {
  switch (variant) {
    case TypographyVariant.display:
      return 'OudsDisplayTextSize';
    case TypographyVariant.heading:
      return 'OudsHeadingTextSize';
    case TypographyVariant.body:
      return 'OudsBodyTextSize';
    case TypographyVariant.label:
      return 'OudsLabelTextSize';
    //case TypographyVariant.code:return 'OudsCodeTextSize';
  }
}
