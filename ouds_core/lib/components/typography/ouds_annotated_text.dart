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

/// A builder used to compose an [OudsAnnotatedText] for any typography `.rich` constructor
/// ([OudsDisplayText.rich], [OudsHeadingText.rich], [OudsBodyText.rich], [OudsLabelText.rich]),
/// letting you color only part of the text.
///
/// This is the recommended way to color part of a block of text, as it automatically manages the
/// color scoping through a stack: [withColor] pushes a color before running its callback and pops
/// it once the callback returns, so nested colored blocks are restored correctly.
///
/// Use [buildOudsAnnotatedText] to create an [OudsAnnotatedText] from a builder block; see its
/// documentation for a usage example.
class OudsAnnotatedTextBuilder {
  final List<InlineSpan> _spans = [];
  final List<Color> _colorStack = [];

  /// Appends [text], using the color currently on top of the color stack (if any).
  ///
  /// [text] also supports the lightweight markdown syntax handled by every typography widget:
  /// `**bold**`, `__**underline bold**__` and `[link](https://example.com)`.
  void append(String text) {
    final color = _colorStack.isEmpty ? null : _colorStack.last;
    _spans.add(
      TextSpan(
        text: text,
        style: color == null ? null : TextStyle(color: color),
      ),
    );
  }

  /// Pushes [color], runs [block], then restores the previous color once [block] completes (even
  /// if it throws) — scoping [color] to every [append] call made inside [block].
  R withColor<R>(Color color, R Function() block) {
    _colorStack.add(color);
    try {
      return block();
    } finally {
      _colorStack.removeLast();
    }
  }
}

/// An immutable, annotated text value produced by [buildOudsAnnotatedText], used to color part of
/// a typography widget via its `.rich` constructor (e.g. [OudsHeadingText.rich]).
class OudsAnnotatedText {
  const OudsAnnotatedText._(this.spans);

  final List<InlineSpan> spans;

  /// The plain, uncolored concatenation of every span's text.
  String get plainText => spans.map((span) => span.toPlainText()).join();
}

/// Builds an [OudsAnnotatedText] value that can be passed as the `text` parameter of any
/// typography `.rich` constructor (e.g. [OudsHeadingText.rich]) to color part of the text.
///
/// Example:
/// ```dart
/// OudsHeadingText.rich(
///   text: buildOudsAnnotatedText((builder) {
///     builder.append('Heading with ');
///     builder.withColor(color, () => builder.append('colored text'));
///   }),
/// )
/// ```
OudsAnnotatedText buildOudsAnnotatedText(
  void Function(OudsAnnotatedTextBuilder builder) block,
) {
  final builder = OudsAnnotatedTextBuilder();
  block(builder);
  return OudsAnnotatedText._(builder._spans);
}
