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

/// The available sizes for [OudsDisplayText].
enum OudsDisplayTextSize { large, medium, small }

// TODO Add design guideline link when available
/// **Reference design version : 1.0.0**
///
/// Display styles are intended for high-impact content such as landing pages, marketing campaigns, and key messages. Their large type sizes help capture
/// attention and establish strong visual emphasis.
/// Variants automatically adapt across breakpoints to maintain a consistent visual hierarchy on every screen size.
/// Use them sparingly to preserve their impact and effectiveness.
///
/// Use this widget instead of a plain [Text] with a hardcoded [TextStyle] so the text always
/// renders with the token defined by the active theme.
///
/// ```dart
/// OudsDisplayText(
///   text: 'Welcome',
///   size: OudsDisplayTextSize.large
/// )
/// ```
///
/// A color override can be provided when the default theme color is not suitable, for example when
/// the text is displayed on a colored surface:
///
/// ```dart
/// OudsDisplayText(
///   text: 'Welcome',
///   size: OudsDisplayTextSize.large,
///   color: OudsTheme.of(context).colorScheme(context).contentDefault,
/// )
/// ```
///
/// This widget also accepts lightweight rich text: `**bold**`, `__**underline bold**__` and
/// `[link](https://example.com)` are supported directly in [text], and a `.rich` constructor
/// ([OudsDisplayText.rich]) is exposed to color only part of the text. Build the `.rich`
/// constructor's `text` argument with [buildOudsAnnotatedText].
///
/// ```dart
/// OudsDisplayText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Welcome ');
///     builder.withColor(color, () => builder.append('back'));
///   }),
/// )
/// ```
///
/// Note: `[link](https://example.com)` is rendered (underlined) but the tap is not handled by this
/// widget.
class OudsDisplayText extends StatelessWidget {
  /// The text to display. Empty when built via [OudsDisplayText.rich].
  final String text;

  /// An optional color override. When null, the theme's `contentDefault` color is used.
  final Color? color;

  /// The size of the display text, see [OudsDisplayTextSize]. Defaults to [OudsDisplayTextSize.large].
  final OudsDisplayTextSize size;

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

  /// When set (via [OudsDisplayText.rich]), builds the content from these annotated spans instead
  /// of the plain [text].
  final OudsAnnotatedText? _annotatedText;

  /// Creates an [OudsDisplayText].
  const OudsDisplayText({
    super.key,
    required this.text,
    this.color,
    this.size = OudsDisplayTextSize.large,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : _annotatedText = null;

  /// Creates an [OudsDisplayText] whose content is composed of multiple spans, some of which can
  /// be colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color
  /// part of the text, e.g. to highlight a word or phrase.
  const OudsDisplayText.rich({
    super.key,
    required OudsAnnotatedText text,
    this.color,
    this.size = OudsDisplayTextSize.large,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : text = '',
       _annotatedText = text;

  /// Returns the [TextStyle] associated with [size] in the active theme.
  @protected
  TextStyle textStyle(BuildContext context) {
    final typography = OudsTheme.of(context).typographyTokens;
    switch (size) {
      case OudsDisplayTextSize.large:
        return typography.typeDisplayLarge(context);
      case OudsDisplayTextSize.medium:
        return typography.typeDisplayMedium(context);
      case OudsDisplayTextSize.small:
        return typography.typeDisplaySmall(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = textStyle(context);
    final resolvedColor =
        color ?? OudsTheme.of(context).colorScheme(context).contentDefault;
    final annotatedText = _annotatedText;

    // Every span (or the plain text) is run through the markdown span builder so bold, underline
    // bold and links are always supported, whether the text is plain or annotated with colors.
    final List<InlineSpan> children;
    if (annotatedText != null) {
      children = annotatedText.spans.map((span) {
        final segmentColor = span.style?.color ?? resolvedColor;
        return MarkdownSpanBuilder.buildRichText(
          context,
          span.toPlainText(),
          baseStyle: style.copyWith(color: segmentColor),
        );
      }).toList();
    } else {
      children = [
        MarkdownSpanBuilder.buildRichText(
          context,
          text,
          baseStyle: style.copyWith(color: resolvedColor),
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
        maxWidth: typographySizeModifier.getDisplayWidthMaxSize(size),
      ),
      child: textWidget,
    );
  }
}
