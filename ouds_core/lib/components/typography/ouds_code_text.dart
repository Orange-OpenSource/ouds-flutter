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
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/utilities/markdown_span_builder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

// TODO Add design guideline link when available
/// **Reference design version : 1.0.0**
///
///  The Code style is dedicated to technical content such as code snippets, commands, system values, and identifiers. It uses a monospace typeface to preserve character alignment and improve readability of structured content.
///  Available in a single size, it provides a consistent presentation of technical information throughout the product.
///  Its use should be limited to content that requires an accurate code-like representation.
///
/// ```dart
/// OudsCodeText(text: 'const x = 1;')
/// ```
///
/// A color override can be provided when the default theme color is not suitable, for example when
/// the text is displayed on a colored surface:
///
/// ```dart
/// OudsCodeText(
///   text: 'const x = 1;',
///   color: OudsTheme.of(context).colorScheme(context).contentDefault,
/// )
/// ```
///
/// This widget also accepts lightweight rich text: `**bold**`, `__**underline bold**__` and
/// `[link](https://example.com)` are supported directly in [text], and a `.rich` constructor
/// ([OudsCodeText.rich]) is exposed to color only part of the text. Build the `.rich`
/// constructor's `text` argument with [buildOudsAnnotatedText].
///
/// ```dart
/// OudsCodeText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('const x = ');
///     builder.withColor(color, () => builder.append('1;'));
///   }),
/// )
/// ```
///
/// Note: `[link](https://example.com)` is rendered (underlined) but the tap is not handled by this
/// widget.
class OudsCodeText extends StatelessWidget {
  /// The text to display. Empty when built via [OudsCodeText.rich].
  final String text;

  /// An optional color override. When null, the theme's `contentDefault` color is used.
  final Color? color;

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

  /// When set (via [OudsCodeText.rich]), builds the content from these annotated spans instead
  /// of the plain [text].
  final OudsAnnotatedText? _annotatedText;

  /// Creates an [OudsCodeText].
  const OudsCodeText({super.key, required this.text, this.color})
    : maxLines = null,
      textAlign = null,
      overflow = null,
      softWrap = null,
      _annotatedText = null;

  /// Creates an [OudsCodeText] whose content is composed of multiple spans, some of which can be
  /// colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color part
  /// of the text, e.g. to highlight a word or phrase.
  const OudsCodeText.rich({
    super.key,
    this.color,
    required OudsAnnotatedText text,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : text = '',
       _annotatedText = text;

  /// Returns the [TextStyle] used to render the code text in the active theme.
  @protected
  TextStyle textStyle(BuildContext context) {
    return OudsTheme.of(context).typographyTokens.typeCodeMedium(context);
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

    return Text.rich(
      TextSpan(
        style: style.copyWith(color: resolvedColor),
        children: children,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
