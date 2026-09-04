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
import 'package:ouds_core/components/typography/ouds_annotated_text.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/utilities/markdown_span_builder.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

// TODO Add design guideline link when available
///
/// **Reference design version : 1.0.0**
///
/// Typography establishes the type scale used to structure content and hierarchy across the app.
/// [OudsTypography] is the common base of the five typographic families, each implemented as a
/// dedicated widget:
/// - [OudsBodyText]
/// - [OudsCodeText]
/// - [OudsDisplayText]
/// - [OudsHeadingText]
/// - [OudsLabelText]
///
///
/// Every variant shares the same common parameters ([text], [color]) plus a [size] parameter typed with the enum dedicated to that family
/// ([OudsDisplayTextSize], [OudsHeadingTextSize], [OudsBodyTextSize], [OudsLabelTextSize] or [OudsCodeTextSize]).
/// [OudsBodyText] and [OudsLabelText] also expose a [weight] parameter ([OudsTextWeight])
/// to select the default, moderate or strong emphasis level.
///
/// Use these widgets instead of a plain [Text] with a hardcoded [TextStyle] so the text always
/// renders with the token defined by the active theme.
///
/// ```dart
/// OudsHeadingText(
///   text: 'Section title',
///   size: OudsHeadingTextSize.large,
/// )
/// ```
///
/// A color override can be provided when the default theme color is not suitable, for example when
/// the text is displayed on a colored surface:
///
/// ```dart
/// OudsCodeText(
///   text: 'const x = 1;',
///   size: OudsCodeTextSize.medium,
///   color: OudsTheme.of(context).colorScheme(context).contentDefault,
/// )
/// ```
///
/// Every variant also accepts lightweight rich text: `**bold**`, `__**underline bold**__` and
/// `[link](https://example.com)` are supported directly in [text], and each variant exposes a
/// `.rich` constructor (e.g. [OudsHeadingText.rich]) to color only part of the text. Build the
/// `.rich` constructor's `text` argument with [buildOudsAnnotatedText]. This is available regardless of the size, theme or the heading marker.
///
/// ```dart
/// OudsHeadingText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Heading with ');
///     builder.withColor(color, () => builder.append('colored text'));
///   }),
/// )
/// ```
abstract class OudsTypography extends StatelessWidget {
  /// The text to display. Empty when built via a `.rich` constructor, see [OudsTypography.rich].
  final String text;

  /// An optional color override. When null, the theme's `contentDefault` color is used.
  final Color? color;

  /// When set (via a `.rich` constructor), builds the content from these annotated spans instead
  /// of the plain [text].
  final OudsAnnotatedText? _annotatedText;

  /// Creates an [OudsTypography].
  const OudsTypography({super.key, required this.text, this.color})
    : _annotatedText = null;

  /// Creates an [OudsTypography] whose content is composed of multiple spans, some of which can be
  /// colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color part
  /// of the text, e.g. to highlight a word or phrase.
  const OudsTypography.rich({
    super.key,
    this.color,
    required OudsAnnotatedText text,
  }) : text = '',
       _annotatedText = text;

  /// Returns the [TextStyle] associated with this variant's `size` in the active theme.
  @protected
  TextStyle textStyle(BuildContext context);

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

    return Text.rich(
      TextSpan(
        style: style.copyWith(color: resolvedColor),
        children: children,
      ),
    );
  }
}

/// The available sizes for [OudsDisplayText].
enum OudsDisplayTextSize { large, medium, small }

/// Display styles are intended for high-impact content such as landing pages, marketing campaigns, and key messages. Their large type sizes help capture
/// attention and establish strong visual emphasis.
/// Variants automatically adapt across breakpoints to maintain a consistent visual hierarchy on every screen size.
/// Use them sparingly to preserve their impact and effectiveness.
///
/// **Reference design version : 1.0.0**
///
/// ```dart
/// OudsDisplayText(
///   text: 'Welcome',
///   size: OudsDisplayTextSize.large
/// )
/// ```
class OudsDisplayText extends OudsTypography {
  /// The size of the display text, see [OudsDisplayTextSize]. Defaults to [OudsDisplayTextSize.large].
  final OudsDisplayTextSize size;

  /// Creates an [OudsDisplayText].
  const OudsDisplayText({
    super.key,
    required super.text,
    super.color,
    this.size = OudsDisplayTextSize.large,
  });

  /// Creates an [OudsDisplayText] whose content is composed of multiple spans, some of which can
  /// be colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color
  /// part of the text, e.g. to highlight a word or phrase.
  const OudsDisplayText.rich({
    super.key,
    super.color,
    this.size = OudsDisplayTextSize.large,
    required super.text,
  }) : super.rich();

  @override
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
}

/// The available sizes for [OudsHeadingText].
enum OudsHeadingTextSize { xLarge, large, medium, small }

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
class OudsHeadingText extends OudsTypography {
  /// The size of the heading text, see [OudsHeadingTextSize]. Defaults to [OudsHeadingTextSize.large].
  final OudsHeadingTextSize size;

  /// marker Controls the brand-colored marker display below the heading large text [OudsHeadingTextSize.large]
  /// It enhances its visual emphasis and reinforce
  /// information hierarchy. This optional decorative element helps highlight important sections and improve content scanability.
  /// Use it selectively to maintain its impact and avoid visual clutter.
  /// Note: If the current theme doesn't allow marker for heading large texts, this parameter is ignored.
  final bool marker;

  /// Creates an [OudsHeadingText].
  const OudsHeadingText({
    super.key,
    required super.text,
    super.color,
    this.size = OudsHeadingTextSize.large,
    this.marker = true,
  });

  /// Creates an [OudsHeadingText] whose content is composed of multiple spans, some of which can
  /// be colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color
  /// part of the heading text, e.g. to highlight a word or phrase.
  const OudsHeadingText.rich({
    super.key,
    super.color,
    this.size = OudsHeadingTextSize.large,
    this.marker = true,
    required super.text,
  }) : super.rich();

  @override
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
    final textWidget = super.build(context);

    final typographyTokens = OudsTheme.of(
      context,
    ).componentsTokens(context).typography;

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
        Padding(
          padding: EdgeInsets.only(
            top: typographyTokens.spacePaddingBlockTopHeadingLargeMarker,
            bottom: typographyTokens.spacePaddingBlockBottomHeadingLargeMarker,
          ),
          child: SvgPicture.asset(
            excludeFromSemantics: true,
            package: OudsTheme.of(context).packageName,
            AppAssets.icons.componentTypographyHeadingMarker,
            fit: BoxFit.contain,
            matchTextDirection: true,
            colorFilter: ColorFilter.mode(
              OudsTheme.of(context).colorScheme(context).contentBrandPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}

/// The emphasis level shared by [OudsBodyText] and [OudsLabelText].
enum OudsTextWeight { defaultWeight, moderate, strong }

/// The available sizes for [OudsBodyText].
enum OudsBodyTextSize { large, medium, small }

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
class OudsBodyText extends OudsTypography {
  /// The size of the body text, see [OudsBodyTextSize]. Defaults to [OudsBodyTextSize.medium].
  final OudsBodyTextSize size;

  /// The emphasis level of the body text, see [OudsTextWeight].
  /// Defaults to [OudsTextWeight.defaultWeight].
  final OudsTextWeight weight;

  /// Creates an [OudsBodyText].
  const OudsBodyText({
    super.key,
    required super.text,
    super.color,
    this.size = OudsBodyTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
  });

  /// Creates an [OudsBodyText] whose content is composed of multiple spans, some of which can be
  /// colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color part
  /// of the text, e.g. to highlight a word or phrase.
  const OudsBodyText.rich({
    super.key,
    super.color,
    this.size = OudsBodyTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
    required super.text,
  }) : super.rich();

  @override
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
}

/// The available sizes for [OudsLabelText].
enum OudsLabelTextSize { xLarge, large, medium, small }

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
class OudsLabelText extends OudsTypography {
  /// The size of the label text, see [OudsLabelTextSize]. Defaults to [OudsLabelTextSize.medium].
  final OudsLabelTextSize size;

  /// The emphasis level of the label text, see [OudsTextWeight].
  /// Defaults to [OudsTextWeight.defaultWeight].
  final OudsTextWeight weight;

  /// Creates an [OudsLabelText].
  const OudsLabelText({
    super.key,
    required super.text,
    super.color,
    this.size = OudsLabelTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
  });

  /// Creates an [OudsLabelText] whose content is composed of multiple spans, some of which can be
  /// colored independently of the others. Build [text] with [buildOudsAnnotatedText] to color part
  /// of the text, e.g. to highlight a word or phrase.
  const OudsLabelText.rich({
    super.key,
    super.color,
    this.size = OudsLabelTextSize.medium,
    this.weight = OudsTextWeight.defaultWeight,
    required super.text,
  }) : super.rich();

  @override
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
}

/*
/// The available sizes for [OudsCodeText].
enum OudsCodeTextSize { large, medium, small }

///  The Code style is dedicated to technical content such as code snippets, commands, system values, and identifiers. It uses a monospace typeface to preserve character alignment and improve readability of structured content.
///  Available in a single size, it provides a consistent presentation of technical information throughout the product.
///  Its use should be limited to content that requires an accurate code-like representation.
///
/// ```dart
/// OudsCodeText(text: 'const x = 1;', size: OudsCodeSize.medium)
/// ```
class OudsCodeText extends OudsTypography {
  /// The size of the code text, see [OudsCodeTextSize]. Defaults to [OudsCodeTextSize.medium].
  final OudsCodeTextSize size;

  /// Creates an [OudsCodeText].
  const OudsCodeText({
    super.key,
    required super.text,
    super.color,
    this.size = OudsCodeTextSize.medium,
  });

  @override
  TextStyle textStyle(BuildContext context) {
    final typography = OudsTheme.of(context).typographyTokens;
    const fontFamilyFallback = ['Courier', 'monospace'];
    switch (size) {
      case OudsCodeTextSize.large:
        return typography
            .typeBodyDefaultLarge(context)
            .copyWith(
              fontFamily: 'monospace',
              fontFamilyFallback: fontFamilyFallback,
            );
      case OudsCodeTextSize.medium:
        return typography
            .typeBodyDefaultMedium(context)
            .copyWith(
              fontFamily: 'monospace',
              fontFamilyFallback: fontFamilyFallback,
            );
      case OudsCodeTextSize.small:
        return typography
            .typeBodyDefaultSmall(context)
            .copyWith(
              fontFamily: 'monospace',
              fontFamilyFallback: fontFamilyFallback,
            );
    }
  }
}

 */
