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
import 'package:ouds_core/components/utilities/markdown_span_builder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The available sizes for [OudsBodyText].
enum OudsBodyTextSize { large, medium, small }

// TODO Add design guideline link when available
/// **Reference design version : 1.0.0**
///
/// Body styles are designed for everyday text content such as paragraphs, descriptions, and informational messages. They prioritize readability and provide
/// a comfortable reading experience across all screen sizes. Multiple size options allow content importance to be expressed while maintaining consistency.
/// Their typography automatically scales across breakpoints to support responsive layouts.
///
/// ```dart
/// OudsBodyText(
///   text: 'Body copy',
///   size: OudsBodyTextSize.medium
///   )
/// ```
///
/// A color override can be provided when the default theme color is not suitable, for example when
/// the text is displayed on a colored surface:
///
/// ```dart
/// OudsBodyText(
///   text: 'Body',
///   size: OudsBodyTextSize.medium,
///   color: OudsTheme.of(context).colorScheme(context).contentDefault,
/// )
/// ```
///
/// This widget also accepts lightweight rich text: `**bold**`, `__**underline bold**__` and
/// `[link](https://example.com)` are supported directly in [text], and a `.rich` constructor
/// ([OudsBodyText.rich]) is exposed to color only part of the text. Build the `.rich`
/// constructor's `text` argument with [buildOudsAnnotatedText].
///
/// ```dart
/// OudsBodyText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Body with ');
///     builder.withColor(color, () => builder.append('colored text'));
///   }),
/// )
/// ```
///
/// Use [onLinkTap] to handle taps on markdown-style links (`[label](url)`) embedded in [text]:
///
/// ```dart
/// OudsBodyText(
///   text: 'Read our [privacy policy](https://example.com/privacy) for more details.',
///   onLinkTap: (url) {
///     // Open the URL, e.g. via url_launcher.
///   },
/// )
/// ```
class OudsBodyText extends StatelessWidget {
  /// The text to display. Empty when built via [OudsBodyText.rich].
  final String text;

  /// An optional color override. When null, the theme's `contentDefault` color is used.
  final Color? color;

  /// The size of the body text, see [OudsBodyTextSize]. Defaults to [OudsBodyTextSize.medium].
  final OudsBodyTextSize size;

  /// The emphasis level of the body text, see [OudsTextWeight].
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

  /// When set (via [OudsBodyText.rich]), builds the content from these annotated spans instead
  /// of the plain [text].
  final OudsAnnotatedText? _annotatedText;

  /// Callback invoked when a `[link](url)` inside [text] or the annotated text is tapped.
  final void Function(String url)? onLinkTap;

  /// Creates an [OudsBodyText].
  const OudsBodyText({
    super.key,
    required this.text,
    this.color,
    this.size = OudsBodyTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : _annotatedText = null,
       onLinkTap = null;

  /// Creates an [OudsBodyText] whose content is composed of multiple spans, some of which can be
  /// colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color part
  /// of the text, e.g. to highlight a word or phrase.
  const OudsBodyText.rich({
    super.key,
    required OudsAnnotatedText text,
    this.color,
    this.size = OudsBodyTextSize.medium,
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
          case OudsBodyTextSize.large:
            return typography.typeBodyDefaultLarge(context);
          case OudsBodyTextSize.medium:
            return typography.typeBodyDefaultMedium(context);
          case OudsBodyTextSize.small:
            return typography.typeBodyDefaultSmall(context);
        }
      case OudsTextWeight.moderate:
        switch (size) {
          case OudsBodyTextSize.large:
            return typography.typeBodyModerateLarge(context);
          case OudsBodyTextSize.medium:
            return typography.typeBodyModerateMedium(context);
          case OudsBodyTextSize.small:
            return typography.typeBodyModerateSmall(context);
        }
      case OudsTextWeight.strong:
        switch (size) {
          case OudsBodyTextSize.large:
            return typography.typeBodyStrongLarge(context);
          case OudsBodyTextSize.medium:
            return typography.typeBodyStrongMedium(context);
          case OudsBodyTextSize.small:
            return typography.typeBodyStrongSmall(context);
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
        maxWidth: typographySizeModifier.getBodyWidthMaxSize(size),
      ),
      child: textWidget,
    );
  }
}
