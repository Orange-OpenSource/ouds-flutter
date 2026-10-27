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
import 'package:ouds_core/components/typography/ouds_body_text.dart';
import 'package:ouds_core/components/typography/ouds_display_text.dart';
import 'package:ouds_core/components/typography/ouds_heading_text.dart';
import 'package:ouds_core/components/typography/ouds_label_text.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/color/ouds_color_scheme.dart';

/// The typography family showcased by the typography demo/customization screens.
enum TypographyVariant { display, heading, body, label, code }

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
      return throw UnimplementedError("Error typography color is not relevant");
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

/// A single run of text within the "annotated text" demo sample, optionally colored by a
/// semantic color token name resolved via [resolveAnnotatedTextSegmentColor].
class AnnotatedTextSegment {
  const AnnotatedTextSegment(this.text, [this.colorTokenName]);

  final String text;
  final String? colorTokenName;
}

/// Parses an annotated text string in format: "text [colored:token] text"
/// Returns a list of AnnotatedTextSegment with plain text and colored segments.
List<AnnotatedTextSegment> _parseAnnotatedText(String text) {
  final segments = <AnnotatedTextSegment>[];
  final pattern = RegExp(r'\[([^\]:]+):([^\]]+)\]');
  int lastEnd = 0;

  for (final match in pattern.allMatches(text)) {
    // Add plain text before the match
    if (match.start > lastEnd) {
      segments.add(AnnotatedTextSegment(text.substring(lastEnd, match.start)));
    }
    // Add colored segment
    segments.add(AnnotatedTextSegment(match.group(1)!, match.group(2)));
    lastEnd = match.end;
  }

  // Add remaining text after last match
  if (lastEnd < text.length) {
    segments.add(AnnotatedTextSegment(text.substring(lastEnd)));
  }

  return segments;
}

/// Returns the sample sentence (as a list of colored/plain [AnnotatedTextSegment]) showcased by
/// the "annotated text" demo toggle for the given [variant].
List<AnnotatedTextSegment> annotatedTextSegmentsFor(
  BuildContext context,
  TypographyVariant variant,
) {
  final l10n = context.l10n;
  switch (variant) {
    case TypographyVariant.display:
    case TypographyVariant.heading:
      final text = variant == TypographyVariant.display
          ? l10n.app_components_typography_headingAndDisplayText_annotatedText_text
          : l10n.app_components_typography_headingAndDisplayText_annotatedText_text;
      return _parseAnnotatedText(text);
    case TypographyVariant.body:
    case TypographyVariant.label:
      return _parseAnnotatedText(
        l10n.app_components_typography_bodyAndLabelText_annotatedText_text,
      );
    case TypographyVariant.code:
      return const [
        AnnotatedTextSegment('import ', 'contentStatusPositive'),
        AnnotatedTextSegment(
          "'package:flutter/material.dart'",
          'contentStatusPositive',
        ),
        AnnotatedTextSegment(';\n\n'),
        AnnotatedTextSegment('void ', 'contentStatusInfo'),
        AnnotatedTextSegment('main() {\n  runApp('),
        AnnotatedTextSegment('const ', 'contentStatusInfo'),
        AnnotatedTextSegment('MyApp());\n}'),
      ];
  }
}

/// Resolves [colorTokenName] (as used by [annotatedTextSegmentsFor]) to the actual [Color]
/// defined by the active [colorScheme]. Returns `null` when [colorTokenName] is `null`, so the
/// component falls back to its own default color.
Color? resolveAnnotatedTextSegmentColor(
  OudsColorScheme colorScheme,
  String? colorTokenName,
) {
  switch (colorTokenName) {
    case 'contentBrandPrimary':
      return colorScheme.contentBrandPrimary;
    case 'contentStatusPositive':
      return colorScheme.contentStatusPositive;
    case 'contentStatusInfo':
      return colorScheme.contentStatusInfo;
    default:
      return null;
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
    case TypographyVariant.code:
      throw UnimplementedError('no size param for TypographyVariant.code.');
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
    case TypographyVariant.code:
      throw UnimplementedError('no size param for TypographyVariant.code.');
  }
}

/// Whether the given [variant] exposes a `weight` (default, moderate, strong) parameter.
bool hasWeightFor(TypographyVariant variant) =>
    variant == TypographyVariant.body || variant == TypographyVariant.label;

/// Returns the typography widget class name matching the given [variant] (e.g. `OudsDisplayText`).
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
    case TypographyVariant.code:
      return 'OudsCodeText';
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
    case TypographyVariant.code:
      throw UnimplementedError('no size param for TypographyVariant.code.');
  }
}
