/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

/// @nodoc
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A lightweight markdown span builder for Flutter `RichText`.
///
/// Supported syntax:
/// - `**bold**`
/// - `__**underline bold**__`
/// - `[link](https://example.com)`
///
/// This is not a full markdown parser. It is intended for simple styling
/// and inline links in lightweight text content.
class MarkdownSpanBuilder {
  /// Builds an [InlineSpan] from plain text supporting only bold markdown.
  ///
  /// Supported syntax:
  /// - `**bold**`
  ///
  /// Any text outside markdown markers is preserved as-is.
  ///
  /// Parameters:
  /// - [text]: The source text to parse.
  /// - [baseStyle]: The default style applied to all text.
  ///
  /// Returns:
  /// A tree of [InlineSpan] that can be used in `Text.rich` or `RichText`.
  static InlineSpan buildBoldOnly(String text, {required TextStyle baseStyle}) {
    final spans = <InlineSpan>[];

    final regex = RegExp(r'(\*\*.*?\*\*)');

    int currentPosition = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > currentPosition) {
        spans.add(
          TextSpan(
            text: text.substring(currentPosition, match.start),
            style: baseStyle,
          ),
        );
      }

      final matchText = match.group(0)!;

      spans.add(
        TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: baseStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      );

      currentPosition = match.end;
    }

    if (currentPosition < text.length) {
      spans.add(
        TextSpan(text: text.substring(currentPosition), style: baseStyle),
      );
    }

    return TextSpan(style: baseStyle, children: spans);
  }

  /// Builds an [InlineSpan] supporting bold text, underline-bold text, and links.
  ///
  /// Supported syntax:
  /// - `**bold**`
  /// - `__**underline bold**__`
  /// - `[link](https://example.com)`
  ///
  /// Link text is rendered with an underline style and can trigger [onLinkTap]
  /// when tapped.
  ///
  /// Parameters:
  /// - [context]: Used to access theme typography tokens.
  /// - [text]: The source text to parse.
  /// - [baseStyle]: The default style applied to non-markdown text.
  /// - [onLinkTap]: Optional callback invoked when a link is tapped.
  ///
  /// Returns:
  /// A tree of [InlineSpan] that can be used in `Text.rich` or `RichText`.
  ///
  /// Note:
  /// This function only parses and exposes links through [onLinkTap].
  /// The caller is responsible for handling link opening behavior
  /// (for example with `url_launcher` or an in-app WebView).
  ///
  /// Example:
  /// onLinkTap: (link) async {
  ///   await launchUrl(Uri.parse(link));
  /// },
  ///
  static InlineSpan buildRichText(
    BuildContext context,
    String text, {
    required TextStyle baseStyle,
    void Function(String url)? onLinkTap,
  }) {
    final theme = OudsTheme.of(context);
    final spans = <InlineSpan>[];

    final regex = RegExp(
      r'(__\*\*.*?\*\*__)|' // underline bold
      r'(\*\*.*?\*\*)|' // bold
      r'(\[.*?\]\(.*?\))', // link
    );

    int currentPosition = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > currentPosition) {
        spans.add(
          TextSpan(
            text: text.substring(currentPosition, match.start),
            style: baseStyle,
          ),
        );
      }

      final matchText = match.group(0)!;

      // Underline + Bold
      if (matchText.startsWith('__**')) {
        spans.add(
          TextSpan(
            text: matchText.substring(4, matchText.length - 4),
            style: baseStyle.copyWith(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        );
      }
      // Bold
      else if (matchText.startsWith('**')) {
        spans.add(
          TextSpan(
            text: matchText.substring(2, matchText.length - 2),
            style: baseStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      }
      // Link
      else if (matchText.startsWith('[')) {
        final linkMatch = RegExp(r'\[(.*?)\]\((.*?)\)').firstMatch(matchText);

        if (linkMatch != null) {
          final linkText = linkMatch.group(1)!;
          final url = linkMatch.group(2)!;

          spans.add(
            TextSpan(
              text: linkText,
              style: theme.typographyTokens
                  .typeLabelStrongMedium(context)
                  .copyWith(
                    decoration: TextDecoration.underline,
                    color: baseStyle.color,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onLinkTap?.call(url);
                },
            ),
          );
        }
      }

      currentPosition = match.end;
    }

    if (currentPosition < text.length) {
      spans.add(
        TextSpan(text: text.substring(currentPosition), style: baseStyle),
      );
    }

    return TextSpan(style: baseStyle, children: spans);
  }
}
