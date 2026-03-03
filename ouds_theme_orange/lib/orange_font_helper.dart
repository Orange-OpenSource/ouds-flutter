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
import 'package:ouds_theme_orange/orange_font_family.dart';

/// Helper class to select the correct font family based on weight and script.
///
/// Since Flutter's FontLoader doesn't support weight specification for dynamically loaded fonts,
/// each weight is loaded as a separate font family. This helper maps FontWeight values
/// to the correct font family name.
class OrangeFontHelper {
  // Default configuration (can be overridden)
  static List<OrangeFontFamily>? _fontConfigs;

  /// Configures custom font family names.
  static void configure(List<OrangeFontFamily> config) {
    _fontConfigs = config;
  }

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

  /// Finds the font name in the config for a given weight and script.
  static String? _findFontInConfig(int weightValue, OrangeFontScript script) {
    if (_fontConfigs == null || _fontConfigs!.isEmpty) return null;

    // Find the best matching font in the configuration
    OrangeFontFamily? bestMatch;

    for (final font in _fontConfigs!) {
      if (font.script == script) {
        if (bestMatch == null) {
          bestMatch = font;
        } else {
          final currentWeight = font.fontWeight.value;
          final bestMatchWeight = bestMatch.fontWeight.value;

          // Check if the current font is a better match
          if ((currentWeight - weightValue).abs() <
              (bestMatchWeight - weightValue).abs()) {
            bestMatch = font;
          }
        }
      }
    }

    return bestMatch?.familyName;
  }

  /// Returns the appropriate font family name based on the base family and desired weight.
  ///
  /// [baseFontFamily] is the base font family name (e.g., "Helvetica Neue Arabic" or "Helvetica Neue Regular")
  /// [weight] is the desired font weight (default: FontWeight.w400)
  ///
  /// Returns the font family name with the appropriate weight suffix.
  static String getFontFamily(String baseFontFamily, [FontWeight? weight]) {
    final weightValue = (weight ?? FontWeight.w400).value;
    final isArabic = baseFontFamily.toLowerCase().contains('arabic');
    final script = isArabic ? OrangeFontScript.arabic : OrangeFontScript.latin;

    // Try to find in the custom config first
    final configFont = _findFontInConfig(weightValue, script);
    if (configFont != null) return configFont;

    // Fallback to default logic
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

  /// Returns the default Regular font family name from the config.
  static String getDefaultFontFamily() {
    if (_fontConfigs == null || _fontConfigs!.isEmpty) {
      return _latinRegular;
    }

    // Look for a regular/normal font
    try {
      final regularFont = _fontConfigs!.firstWhere((font) =>
          font.script == OrangeFontScript.latin &&
          font.fontWeight == FontWeight.w400);
      return regularFont.familyName;
    } catch (e) {
      // If not found, return the first non-Arabic font
      try {
        final fallbackFont = _fontConfigs!
            .firstWhere((font) => font.script == OrangeFontScript.latin);
        return fallbackFont.familyName;
      } catch (e) {
        // If still no match, return the first font in the list
        return _fontConfigs!.first.familyName;
      }
    }
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
  static String getFontFamilyFromStyle(
      String baseFontFamily, TextStyle? style) {
    return getFontFamily(baseFontFamily, style?.fontWeight);
  }
}

/// Extension on TextStyle to automatically apply the correct font family
/// based on the font weight.
extension OrangeTextStyleExtension on TextStyle {
  /// Returns a copy of this TextStyle with the correct font family
  /// based on the current font weight.
  TextStyle withHelveticaWeight() {
    final currentFamily = fontFamily ?? OrangeFontHelper.getDefaultFontFamily();
    final newFamily =
        OrangeFontHelper.getFontFamily(currentFamily, fontWeight);
    return copyWith(fontFamily: newFamily);
  }
}
