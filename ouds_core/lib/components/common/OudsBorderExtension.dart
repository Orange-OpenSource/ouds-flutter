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

/// OudsBorderSemanticToken
library;

import 'package:flutter/cupertino.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';

///
/// An extension OudsBorderSemanticToken has been added to centralize border creation.
///
extension OudsBorderSemanticToken on OudsBorderSemanticTokens {

  /// use:
  /// ```dart
  /// OudsTheme.of(context).borderTokens.borderAll(width, color)
  /// ```
  /// instead of using
  /// ```dart
  /// Border.all()
  /// ```
  /// directly.
  /// This ensures that widthNone correctly results in no border (instead of a thin visible line).
  ///
  /// Returns `null` if [width] equals [widthNone],
  /// otherwise returns a standard [Border].
  Border? borderAll({
    required double width,
    required Color color,
    BorderStyle? style,
  }) {

    if (width == widthNone) return null;

    return Border.all(
      color: color,
      width: width,
      style: style ?? BorderStyle.solid,
    );
  }

}
