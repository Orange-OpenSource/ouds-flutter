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

/// The emphasis level shared by [OudsBodyText] and [OudsLabelText].
enum OudsTextWeight { defaultWeight, moderate, strong }

/// A builder used to compose an [OudsAnnotatedText] for any typography `.rich` constructor
/// ([OudsDisplayText.rich], [OudsHeadingText.rich], [OudsBodyText.rich], [OudsLabelText.rich]),
/// letting you color only part of the text.
///
/// This is the recommended way to color part of a block of text, as it automatically manages the
/// color scoping through a stack: [withColor] pushes a color resolver before running its callback
/// and pops it once the callback returns, so nested colored blocks are restored correctly.
///
/// Use [buildOudsAnnotatedText] to create an [OudsAnnotatedText] from a builder block; see its
/// documentation for a usage example.
class OudsAnnotatedTextBuilder {
  final List<OudsAnnotatedTextSegment> _segments = [];
  final List<Color? Function(BuildContext context)> _colorResolverStack = [];

  /// Appends [text], applying the current color resolver if present.
  ///
  /// Supports `**bold**` and `[link](https://example.com)` syntax.
  void append(String text) {
    final colorResolver = _colorResolverStack.isEmpty
        ? null
        : _colorResolverStack.last;
    _segments.add(OudsAnnotatedTextSegment(text, colorResolver));
  }

  /// Applies [colorResolver] to text appended in [block], then restores the previous resolver.
  ///
  /// The resolver runs when the text is rendered, using the consuming widget's context.
  R withColor<R>(
    Color? Function(BuildContext context) colorResolver,
    R Function() block,
  ) {
    _colorResolverStack.add(colorResolver);
    try {
      return block();
    } finally {
      _colorResolverStack.removeLast();
    }
  }
}

/// A single run of text within an [OudsAnnotatedText], optionally colored via [colorResolver].
class OudsAnnotatedTextSegment {
  const OudsAnnotatedTextSegment(this.text, [this.colorResolver]);

  /// The text of this segment.
  final String text;

  /// Resolves this segment's color from a [BuildContext]. Called lazily by
  /// [OudsAnnotatedText.resolveSpans], from the consuming widget's own `build()` method.
  final Color? Function(BuildContext context)? colorResolver;
}

/// An immutable, annotated text value produced by [buildOudsAnnotatedText], used to color part of
/// a typography widget via its `.rich` constructor (e.g. [OudsHeadingText.rich]).
class OudsAnnotatedText {
  const OudsAnnotatedText._(this._segments);

  final List<OudsAnnotatedTextSegment> _segments;

  /// The plain, uncolored concatenation of every segment's text.
  String get plainText => _segments.map((segment) => segment.text).join();

  /// Resolves segment colors using the consuming widget's context.
  List<InlineSpan> resolveSpans(BuildContext context) {
    return _segments.map((segment) {
      final color = segment.colorResolver?.call(context);
      return TextSpan(
        text: segment.text,
        style: color == null ? null : TextStyle(color: color),
      );
    }).toList();
  }
}

/// Builds annotated text for use with a typography `.rich` constructor.
///
/// Colors are resolved from the consuming widget's context, so they follow the active theme.
///
/// Example:
/// ```dart
/// OudsHeadingText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Heading with ');
///     builder.withColor(
///       (context) => OudsTheme.of(context).colorScheme(context).contentBrandPrimary,
///       () => builder.append('colored text'),
///     );
///   }),
/// )
/// ```
OudsAnnotatedText buildOudsAnnotatedText(
  void Function(OudsAnnotatedTextBuilder builder) block,
) {
  final builder = OudsAnnotatedTextBuilder();
  block(builder);
  return OudsAnnotatedText._(builder._segments);
}
