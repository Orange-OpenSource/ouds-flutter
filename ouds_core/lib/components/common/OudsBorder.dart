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

/// OudsBorder
library;

import 'package:flutter/cupertino.dart';

/// Returns [this] if it is not equal to 0.0, otherwise returns `null`.
extension DpExtension on double {
  double? takeUnlessHairline() {
    return this == 0.0 ? null : this;
  }
}

class OudsBorder  {

  /// use:
  /// ```dart
  /// OudsBorder().borderAll(width, color)
  /// ```
  /// instead of using
  /// ```dart
  /// Border.all()
  /// ```
  /// directly.
  ///
  /// Creates a uniform border with the specified width, color, and style.
  /// If the width matches the "Hairline" value (0.0), the function returns null,
  /// which can be used to avoid applying a border.
  ///
  /// - [width]: The width of the border. If this value is considered "Hairline," no border is created.
  /// - [color]: The color of the border.
  /// - [style]: The style of the border (default: BorderStyle.solid).
  ///
  /// Returns an instance of [Border] if the width is not "Hairline"; otherwise, returns null.
  ///
  Border? borderAll({
    required double width,
    required Color color,
    BorderStyle? style,
  }) {

    final widthNone = width.takeUnlessHairline();
    if (widthNone == null) return null;

    return Border.all(
      color: color,
      width: width,
      style: style ?? BorderStyle.solid,
    );
  }
}