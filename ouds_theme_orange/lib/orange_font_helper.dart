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

import 'package:flutter/material.dart';

/// Helper class to select the correct Helvetica Neue font family based on weight.
///
/// Since Flutter's FontLoader doesn't support weight specification for dynamically loaded fonts,
/// each weight is loaded as a separate font family. This helper maps FontWeight values
/// to the correct font family name.
///
/// ## Usage
///
/// ```dart
/// TextStyle(
///   fontFamily: OrangeFontHelper.getFontFamily(baseFontFamily, FontWeight.bold),
///   fontSize: 16,
/// )
/// ```
///
/// Or use the extension method:
/// ```dart
/// TextStyle(
///   fontFamily: 'Helvetica Neue Regular',
///   fontWeight: FontWeight.bold,
///   fontSize: 16,
/// ).withHelveticaWeight()
/// ```
///
/// ## Font Family Mapping
///
/// - **Light (300)**: "Helvetica Neue Arabic Light" or uses Regular for Latin
/// - **Regular (400)**: "Helvetica Neue Arabic" or "Helvetica Neue Regular"
/// - **Medium (500)**: Uses Regular for Arabic, "Helvetica Neue Medium" for Latin
/// - **SemiBold (600)**: Uses Bold variant
/// - **Bold (700)**: "Helvetica Neue Arabic Bold" or "Helvetica Neue Bold"
/// - **ExtraBold/Black (800-900)**: Uses Bold variant
class OrangeFontHelper {
  // Font family constants
  static const String _arabicLight = "Helvetica Neue Arabic Light";
  static const String _arabicRegular = "Helvetica Neue Arabic";
  static const String _arabicBold = "Helvetica Neue Arabic Bold";

  static const String _latinRegular = "Helvetica Neue Regular";
  static const String _latinMedium = "Helvetica Neue Medium";
  static const String _latinBold = "Helvetica Neue Bold";

  // Weight thresholds
  static const int _lightThreshold = 350;
  static const int _mediumThreshold = 450;
  static const int _boldThreshold = 600;

  /// Returns the appropriate font family name based on the base family and desired weight.
  ///
  /// [baseFontFamily] is the base font family name (e.g., "Helvetica Neue Arabic" or "Helvetica Neue Regular")
  /// [weight] is the desired font weight (default: FontWeight.w400)
  ///
  /// Returns the font family name with the appropriate weight suffix.
  static String getFontFamily(String baseFontFamily, [FontWeight? weight]) {
    final weightValue = (weight ?? FontWeight.w400).value;
    final isArabic = baseFontFamily.toLowerCase().contains('arabic');

    if (isArabic) {
      return _getArabicFontFamily(weightValue);
    }
    return _getLatinFontFamily(weightValue);
  }

  /// Returns the appropriate Arabic font family based on weight.
  static String _getArabicFontFamily(int weightValue) {
    if (weightValue <= _lightThreshold) return _arabicLight;
    if (weightValue >= _boldThreshold) return _arabicBold;
    return _arabicRegular;
  }

  /// Returns the appropriate Latin font family based on weight.
  static String _getLatinFontFamily(int weightValue) {
    if (weightValue >= _boldThreshold) return _latinBold;
    if (weightValue >= _mediumThreshold) return _latinMedium;
    return _latinRegular;
  }

  /// Returns the appropriate font family for TextStyle with automatic weight detection.
  ///
  /// This is a convenience method that extracts the weight from an existing TextStyle
  /// and returns the appropriate font family.
  ///
  /// ```dart
  /// final style = TextStyle(fontWeight: FontWeight.bold);
  /// final fontFamily = OrangeFontHelper.getFontFamilyFromStyle(baseFontFamily, style);
  /// ```
  static String getFontFamilyFromStyle(String baseFontFamily, TextStyle? style) {
    return getFontFamily(baseFontFamily, style?.fontWeight);
  }
}

/// Extension on TextStyle to automatically apply the correct Helvetica Neue font family
/// based on the font weight.
extension HelveticaNeueTextStyleExtension on TextStyle {
  /// Returns a copy of this TextStyle with the correct Helvetica Neue font family
  /// based on the current font weight.
  ///
  /// This method automatically selects the appropriate font family variant:
  /// - Light weight (300) → "Helvetica Neue Arabic Light" or "Helvetica Neue Regular"
  /// - Regular weight (400) → "Helvetica Neue Arabic" or "Helvetica Neue Regular"
  /// - Medium weight (500) → "Helvetica Neue Arabic" or "Helvetica Neue Medium"
  /// - Bold weight (700+) → "Helvetica Neue Arabic Bold" or "Helvetica Neue Bold"
  ///
  /// Example:
  /// ```dart
  /// TextStyle(
  ///   fontFamily: 'Helvetica Neue Regular',
  ///   fontWeight: FontWeight.bold,
  ///   fontSize: 16,
  /// ).withHelveticaWeight()
  /// // Returns TextStyle with fontFamily: 'Helvetica Neue Bold'
  /// ```
  TextStyle withHelveticaWeight() {
    final currentFamily = fontFamily ?? OrangeFontHelper._latinRegular;

    // Only apply transformation if it's a Helvetica Neue font
    if (!currentFamily.toLowerCase().contains('helvetica')) {
      return this;
    }

    final newFamily = OrangeFontHelper.getFontFamily(currentFamily, fontWeight);
    print(newFamily);
    return copyWith(fontFamily: newFamily);
  }
}
