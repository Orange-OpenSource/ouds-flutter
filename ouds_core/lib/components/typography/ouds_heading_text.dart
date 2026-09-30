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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/typography/internal/ouds_typography_size_modifier.dart';
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/utilities/markdown_span_builder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The available sizes for [OudsHeadingText].
enum OudsHeadingTextSize { xLarge, large, medium, small }

// TODO Add design guideline link when available
/// **Reference design version : 1.1.0**
///
/// Heading styles are used to structure content and define the hierarchy of information within an interface.
/// Available in multiple sizes, they help users quickly understand the organization of a page or section.
/// Their size automatically adjusts across breakpoints to ensure optimal readability on all devices.
/// Headings serve as the primary entry point for visual navigation.
///
/// When [size] is [OudsHeadingTextSize.large] and [marker] is `true` (and the active theme supports
/// it, see [OudsTypographyTokens.headingLargeMarker]), a small rectangular marker is displayed under
/// the text, using the theme's `contentBrandPrimary` color. The marker follows these rules
/// independently of the text content: it is shown the same way whether the text is plain, colored,
/// bold or contains a link.
///
/// ```dart
/// OudsHeadingText(
///   text: 'Section title',
///   size: OudsHeadingTextSize.large
///   )
/// ```
///
/// A color override can be provided when the default theme color is not suitable, for example when
/// the text is displayed on a colored surface:
///
/// ```dart
/// OudsHeadingText(
///   text: 'Section title',
///   size: OudsHeadingTextSize.large,
///   color: OudsTheme.of(context).colorScheme(context).contentDefault,
/// )
/// ```
///
/// This widget also accepts lightweight rich text: `**bold**`, `__**underline bold**__` and
/// `[link](https://example.com)` are supported directly in [text], and a `.rich` constructor
/// ([OudsHeadingText.rich]) is exposed to color only part of the text. Build the `.rich`
/// constructor's `text` argument with [buildOudsAnnotatedText].
///
/// ```dart
/// OudsHeadingText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Heading with ');
///     builder.withColor(color, () => builder.append('colored text'));
///   }),
/// )
/// ```
///
/// Note: `[link](https://example.com)` is rendered (underlined) but the tap is not handled by this
/// widget.
class OudsHeadingText extends StatelessWidget {
  /// The text to display. Empty when built via [OudsHeadingText.rich].
  final String text;

  /// An optional color override. When null, the theme's `contentDefault` color is used.
  final Color? color;

  /// The size of the heading text, see [OudsHeadingTextSize]. Defaults to [OudsHeadingTextSize.large].
  final OudsHeadingTextSize size;

  /// marker Controls the brand-colored marker display below the heading large text [OudsHeadingTextSize.large]
  /// It enhances its visual emphasis and reinforce
  /// information hierarchy. This optional decorative element helps highlight important sections and improve content scanability.
  /// Use it selectively to maintain its impact and avoid visual clutter.
  /// Note: If the current theme doesn't allow marker for heading large texts, this parameter is ignored.
  final bool marker;

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

  /// When set (via [OudsHeadingText.rich]), builds the content from these annotated spans instead
  /// of the plain [text].
  final OudsAnnotatedText? _annotatedText;

  /// Creates an [OudsHeadingText].
  const OudsHeadingText({
    super.key,
    required this.text,
    this.color,
    this.size = OudsHeadingTextSize.large,
    this.marker = true,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
  }) : _annotatedText = null;

  /// Creates an [OudsHeadingText] whose content is composed of multiple spans, some of which can
  /// be colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color
  /// part of the heading text, e.g. to highlight a word or phrase.
  const OudsHeadingText.rich({
    super.key,
    required OudsAnnotatedText text,
    this.color,
    this.size = OudsHeadingTextSize.large,
    this.marker = true,
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
      case OudsHeadingTextSize.xLarge:
        return typography.typeHeadingXLarge(context);
      case OudsHeadingTextSize.large:
        return typography.typeHeadingLarge(context);
      case OudsHeadingTextSize.medium:
        return typography.typeHeadingMedium(context);
      case OudsHeadingTextSize.small:
        return typography.typeHeadingSmall(context);
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

    final textContent = Text.rich(
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
    final typographyTokens = OudsTheme.of(
      context,
    ).componentsTokens(context).typography;

    final textWidget = Container(
      constraints: BoxConstraints(
        maxWidth: typographySizeModifier.getHeadingWidthMaxSize(size),
      ),
      child: textContent,
    );

    // The marker follows its own rules, independent of the text content (plain, colored, bold or
    // linked): it only depends on `marker`, `size` and the theme's support for it.
    if (!marker ||
        size != OudsHeadingTextSize.large ||
        !typographyTokens.headingLargeMarker) {
      return textWidget;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textWidget,
        SvgPicture.asset(
          excludeFromSemantics: true,
          package: OudsTheme.of(context).packageName,
          AppAssets.icons.componentTypographyHeadingMarker,
          fit: BoxFit.contain,
          matchTextDirection: true,
          colorFilter: ColorFilter.mode(
            typographyTokens.colorContentMarker,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
