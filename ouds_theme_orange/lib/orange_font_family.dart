/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

/// Orange brand font family configuration.
///
/// This class configures Helvetica Neue fonts for both Latin and Arabic scripts.
///
/// ## Usage
///
/// ```dart
/// // CDN mode - automatic loading
/// final fontFamily = await OrangeFontProvider.loadFromCdn();
/// OrangeTheme(fontFamily)
///
/// // Assets mode - manual configuration
/// final orangeFontFamily = OrangeFontFamily(
///   latin: OrangeHelveticaNeueLatin.bundled(
///     regularFontRes: "fonts/helvetica_neue_latin_roman.ttf",
///     mediumFontRes: "fonts/helvetica_neue_latin_medium.ttf",
///     boldFontRes: "fonts/helvetica_neue_latin_bold.ttf",
///   ),
///   arabic: OrangeHelveticaNeueArabic.bundled(
///     lightFontRes: "fonts/helvetica_neue_arabic_light.ttf",
///     regularFontRes: "fonts/helvetica_neue_arabic_roman.ttf",
///     boldFontRes: "fonts/helvetica_neue_arabic_bold.ttf",
///   ),
/// );
/// final fontFamily = await OrangeFontProvider.loadFromAssets(orangeFontFamily);
/// OrangeTheme(fontFamily)
/// ```
class OrangeFontFamily {
  final OrangeHelveticaNeueLatin latin;
  final OrangeHelveticaNeueArabic arabic;

  const OrangeFontFamily({
    required this.latin,
    required this.arabic,
  });
}

/// Latin font configuration (Helvetica Neue).
class OrangeHelveticaNeueLatin {
  final String? regularFontRes;
  final String? mediumFontRes;
  final String? boldFontRes;

  const OrangeHelveticaNeueLatin._({
    this.regularFontRes,
    this.mediumFontRes,
    this.boldFontRes,
  });

  /// Create bundled Arabic fonts configuration.
  ///
  /// Example:
  /// ```dart
  /// OrangeHelveticaNeueLatin.bundled(
  ///   regularFontRes: "fonts/helvetica_neue_latin_roman.ttf",
  ///   mediumFontRes: "fonts/helvetica_neue_latin_medium.ttf",
  ///   boldFontRes: "fonts/helvetica_neue_latin_bold.ttf",
  /// )
  /// ```
  const OrangeHelveticaNeueLatin.bundled({
    required String regularFontRes,
    required String mediumFontRes,
    required String boldFontRes,
  }) : this._(
          regularFontRes: regularFontRes,
          mediumFontRes: mediumFontRes,
          boldFontRes: boldFontRes,
        );
}

/// Arabic font configuration (Helvetica Neue Arabic).
class OrangeHelveticaNeueArabic {
  final String? lightFontRes;
  final String? regularFontRes;
  final String? boldFontRes;

  const OrangeHelveticaNeueArabic._({
    this.lightFontRes,
    this.regularFontRes,
    this.boldFontRes,
  });

  /// Create bundled Arabic fonts configuration.
  ///
  /// Example:
  /// ```dart
  /// OrangeHelveticaNeueArabic.bundled(
  ///   lightFontRes: "fonts/helvetica_neue_arabic_light.ttf",
  ///   regularFontRes: "fonts/helvetica_neue_arabic_roman.ttf",
  ///   boldFontRes: "fonts/helvetica_neue_arabic_bold.ttf",
  /// )
  /// ```
  const OrangeHelveticaNeueArabic.bundled({
    required String lightFontRes,
    required String regularFontRes,
    required String boldFontRes,
  }) : this._(
          lightFontRes: lightFontRes,
          regularFontRes: regularFontRes,
          boldFontRes: boldFontRes,
        );
}
