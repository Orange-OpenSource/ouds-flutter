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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Helper class for selecting the correct Helvetica Neue font family based on weight.
///
/// Since Flutter's FontLoader doesn't support weight specification for dynamically loaded fonts,
/// each weight is loaded as a separate font family. This helper maps FontWeight values
/// to the correct font family name.
///
/// ## Font Family Mapping
///
/// **Arabic:**
/// - Light (w300): "HelveticaNeue-Arabic-Light"
/// - Regular (w400): "HelveticaNeue-Arabic"
/// - Bold (w700): "HelveticaNeue-Arabic-Bold"
///
/// **Latin:**
/// - Regular (w400): "HelveticaNeue"
/// - Medium (w500): "HelveticaNeue-Medium"
/// - Bold (w700): "HelveticaNeue-Bold"
///
/// ## Usage Example
///
/// ```dart
/// Text(
///   'Bold Text',
///   style: TextStyle(
///     fontFamily: OrangeFontHelper.getFontFamily(FontWeight.bold, isArabic: false),
///     fontSize: 16,
///   ),
/// )
/// ```
class OrangeFontHelper {
  // Arabic font families
  static const String _arabicLight = "HelveticaNeue-Arabic-Light";
  static const String _arabicRegular = "HelveticaNeue-Arabic";
  static const String _arabicBold = "HelveticaNeue-Arabic-Bold";

  // Latin font families
  static const String _latinRegular = "HelveticaNeue";
  static const String _latinMedium = "HelveticaNeue-Medium";
  static const String _latinBold = "HelveticaNeue-Bold";

  /// Returns the appropriate font family name based on weight and locale.
  ///
  /// [weight] - The desired font weight (default: w400)
  /// [isArabic] - Whether the text is in Arabic (default: false)
  ///
  /// Returns the font family name matching the weight and locale.
  static String getFontFamily({
    FontWeight weight = FontWeight.w400,
    bool isArabic = false,
  }) {
    if (isArabic) {
      return _getArabicFontFamily(weight);
    }
    return _getLatinFontFamily(weight);
  }

  /// Returns the default font family for the current locale.
  ///
  /// [isArabic] - Whether the text is in Arabic
  static String getDefaultFontFamily({bool isArabic = false}) {
    return isArabic ? _arabicRegular : _latinRegular;
  }

  /// Returns the appropriate Arabic font family based on weight.
  static String _getArabicFontFamily(FontWeight weight) {
    if (weight.value <= 350) return _arabicLight;
    if (weight.value >= 600) return _arabicBold;
    return _arabicRegular;
  }

  /// Returns the appropriate Latin font family based on weight.
  static String _getLatinFontFamily(FontWeight weight) {
    if (weight.value >= 600) return _latinBold;
    if (weight.value >= 450) return _latinMedium;
    return _latinRegular;
  }
}

/// Extension on TextStyle to automatically apply the correct font family based on weight.
extension OrangeFontStyleExtension on TextStyle {
  /// Returns a copy of this TextStyle with the correct Helvetica Neue font family
  /// based on the current font weight and locale.
  TextStyle withOrangeFont() {
    final isArabic = PlatformDispatcher.instance.locale.languageCode == 'ar';
    final weight = fontWeight ?? FontWeight.w400;
    return copyWith(
      fontFamily: OrangeFontHelper.getFontFamily(
        weight: weight,
        isArabic: isArabic,
      ),
    );
  }
}
