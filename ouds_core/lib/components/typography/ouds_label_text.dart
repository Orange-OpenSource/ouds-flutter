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

/// {@category Typography}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/typography/internal/ouds_typography_size_modifier.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/typography/ouds_body_text.dart'
    show OudsTextWeight;
import 'package:ouds_core/components/utilities/markdown_span_builder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The available sizes for [OudsLabelText].
enum OudsLabelTextSize { xLarge, large, medium, small }

// TODO Add design guideline link when available
/// **Reference design version : 1.0.0**
///
/// Label styles are intended for compact interface elements such as buttons, form fields, badges, and other small components.
/// Unlike other typography categories, they are not responsive and maintain a fixed size across all breakpoints. This ensures visual consistency and
/// predictable behavior within space-constrained UI elements. Labels should be preferred whenever content is displayed within small components.
///
/// ```dart
/// OudsLabelText(
///   text: 'Submit',
///   size: OudsLabelTextSize.medium,
///   weight: OudsTextWeight.strong,
/// )
/// ```
///
/// A color override can be provided when the default theme color is not suitable, for example when
/// the text is displayed on a colored surface:
///
/// ```dart
/// OudsLabelText(
///   text: 'Submit',
///   size: OudsLabelTextSize.medium,
///   color: OudsTheme.of(context).colorScheme(context).contentDefault,
/// )
/// ```
///
/// This widget also accepts lightweight rich text: `**bold**`, `__**underline bold**__` and
/// `[link](https://example.com)` are supported directly in [text], and a `.rich` constructor
/// ([OudsLabelText.rich]) is exposed to color only part of the text. Build the `.rich`
/// constructor's `text` argument with [buildOudsAnnotatedText].
///
/// ```dart
/// OudsLabelText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Submit ');
///     builder.withColor(color, () => builder.append('now'));
///   }),
/// )
/// ```
///
/// Use [onLinkTap] to handle taps on markdown-style links (`[label](url)`) embedded in [text]:
///
/// ```dart
/// OudsLabelText(
///   text: 'See [terms and conditions](https://example.com/terms)',
///   size: OudsLabelTextSize.medium,
///   onLinkTap: (url) {
///     // Open the URL, e.g. via url_launcher.
///   },
/// )
/// ```
class OudsLabelText extends StatelessWidget {
  /// The text to display. Empty when built via [OudsLabelText.rich].
  final String text;

  /// An optional color override. When null, the theme's `contentDefault` color is used.
  final Color? color;

  /// The size of the label text, see [OudsLabelTextSize]. Defaults to [OudsLabelTextSize.medium].
  final OudsLabelTextSize size;

  /// The emphasis level of the label text, see [OudsTextWeight].
  /// Defaults to [OudsTextWeight.defaultWeight].
  final OudsTextWeight weight;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according to [overflow] and
  /// [softWrap].
  final int? maxLines;

  /// Alignment of the text within the lines of the paragraph. See [TextAlign].
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks. If false, the glyphs in the
  /// text will be positioned as if there was unlimited horizontal space. If [softWrap] is false,
  /// [overflow] and [TextAlign] may have unexpected effects.
  final bool? softWrap;

  /// When set (via [OudsLabelText.rich]), builds the content from these annotated spans instead
  /// of the plain [text].
  final OudsAnnotatedText? _annotatedText;

  /// Callback invoked when a `[link](url)` inside [text] or the annotated text is tapped.
  final void Function(String url)? onLinkTap;

  /// Creates an [OudsLabelText].
  const OudsLabelText({
    super.key,
    required this.text,
    this.color,
    this.size = OudsLabelTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : _annotatedText = null,
       onLinkTap = null;

  /// Creates an [OudsLabelText] whose content is composed of multiple spans, some of which can be
  /// colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color part
  /// of the text, e.g. to highlight a word or phrase.
  const OudsLabelText.rich({
    super.key,
    required OudsAnnotatedText text,
    this.color,
    this.size = OudsLabelTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
    this.onLinkTap,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : text = '',
       _annotatedText = text;

  /// Returns the [TextStyle] associated with [size] and [weight] in the active theme.
  @protected
  TextStyle textStyle(BuildContext context) {
    final typography = OudsTheme.of(context).typographyTokens;
    switch (weight) {
      case OudsTextWeight.defaultWeight:
        switch (size) {
          case OudsLabelTextSize.xLarge:
            return typography.typeLabelDefaultXLarge(context);
          case OudsLabelTextSize.large:
            return typography.typeLabelDefaultLarge(context);
          case OudsLabelTextSize.medium:
            return typography.typeLabelDefaultMedium(context);
          case OudsLabelTextSize.small:
            return typography.typeLabelDefaultSmall(context);
        }
      case OudsTextWeight.moderate:
        switch (size) {
          case OudsLabelTextSize.xLarge:
            return typography.typeLabelModerateXLarge(context);
          case OudsLabelTextSize.large:
            return typography.typeLabelModerateLarge(context);
          case OudsLabelTextSize.medium:
            return typography.typeLabelModerateMedium(context);
          case OudsLabelTextSize.small:
            return typography.typeLabelModerateSmall(context);
        }
      case OudsTextWeight.strong:
        switch (size) {
          case OudsLabelTextSize.xLarge:
            return typography.typeLabelStrongXLarge(context);
          case OudsLabelTextSize.large:
            return typography.typeLabelStrongLarge(context);
          case OudsLabelTextSize.medium:
            return typography.typeLabelStrongMedium(context);
          case OudsLabelTextSize.small:
            return typography.typeLabelStrongSmall(context);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = textStyle(context);
    final resolvedColor =
        color ?? OudsTheme.of(context).colorScheme(context).contentDefault;
    final annotatedText = _annotatedText;

    final List<InlineSpan> children;
    // Every span (or the plain text) is run through the markdown span builder so bold, underline
    // bold and links are always supported, whether the text is plain or annotated with colors.
    if (annotatedText != null) {
      children = annotatedText.spans.map((span) {
        final segmentColor = span.style?.color ?? resolvedColor;
        return MarkdownSpanBuilder.buildRichText(
          context,
          span.toPlainText(),
          baseStyle: style.copyWith(color: segmentColor),
          onLinkTap: onLinkTap,
        );
      }).toList();
    } else {
      children = [
        MarkdownSpanBuilder.buildRichText(
          context,
          text,
          baseStyle: style.copyWith(color: resolvedColor),
          onLinkTap: onLinkTap,
        ),
      ];
    }

    final textWidget = Text.rich(
      TextSpan(
        style: style.copyWith(color: resolvedColor),
        children: children,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );

    final typographySizeModifier = OudsTypographySizeModifier(context);
    return Container(
      constraints: BoxConstraints(
        maxWidth: typographySizeModifier.getLabelWidthMaxSize(size),
      ),
      child: textWidget,
    );
  }
}
