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

import 'dart:ui';
import 'package:flutter/services.dart' as ui;
import 'package:ouds_theme_orange/orange_font_helper.dart';
import 'package:ouds_theme_orange/orange_font_service.dart';

/// An enumeration of font scripts.
enum OrangeFontScript {
  latin,
  arabic,
}

/// A utility class for dynamically loading custom font families at runtime.
///
/// This class provides functionality to load font assets.
class OrangeFontFamily {
  final String familyName;
  final String asset;
  final FontWeight fontWeight;
  final OrangeFontScript script;

  const OrangeFontFamily({
    required this.familyName,
    required this.asset,
    required this.fontWeight,
    this.script = OrangeFontScript.latin,
  });

  /// Loads fonts and determines the appropriate base font family for the device's locale.
  ///
  /// This method supports two modes of operation for loading fonts:
  ///
  /// 1.  **Local Asset Loading**: If a `fontConfigs` list is provided, the method
  ///     loads each specified font from the application's assets. It then
  ///     inspects the device's locale to select the appropriate script (e.g.,
  ///     Arabic or Latin) and returns the name of the regular-weight font family
  ///     for that script.
  ///
  /// 2.  **Remote CDN Loading**: If `fontConfigs` is `null`, the method delegates
  ///     to [OrangeFontService.loadFontFamily] to download and cache the default
  ///     Orange fonts from a CDN.
  ///
  /// After the fonts are loaded (either locally or remotely), the [OrangeFontHelper]
  /// is configured to enable dynamic font selection based on `FontWeight`.
  ///
  /// ## Parameters
  /// - [fontConfigs]: An optional list of [OrangeFontFamily] objects that
  ///   define fonts to be loaded from local assets. If `null`, fonts will be
  ///   downloaded from the network.
  ///
  /// ## Returns
  /// A [Future] that completes with the base font family name (`String`)
  /// appropriate for the current locale, or `null` if no suitable font
  /// could be determined or loaded.
  ///
  /// ## Usage example:
  ///
  /// ```dart
  ///   // This example loads fonts from local assets.
  ///   final orangeFontFamily = await OrangeFontFamily.getFontFamily(
  ///     fontConfigs: [
  ///       OrangeFontFamily(
  ///         familyName: "Helvetica Neue Arabic",
  ///         asset: "assets/fonts/helvetica_neue_arabic.ttf",
  ///         fontWeight: FontWeight.w400,
  ///         script: OrangeFontScript.arabic,
  ///       ),
  ///       OrangeFontFamily(
  ///         familyName: "Helvetica Neue Arabic Bold",
  ///         asset: "assets/fonts/helvetica_neue_arabic_bold.ttf",
  ///         fontWeight: FontWeight.w700,
  ///         script: OrangeFontScript.arabic,
  ///       ),
  ///       OrangeFontFamily(
  ///           familyName: "Helvetica Neue Regular",
  ///           asset: "assets/fonts/helvetica_neue_latin_roman.ttf",
  ///           fontWeight: FontWeight.w400,
  ///           script: OrangeFontScript.latin,
  ///       ),
  ///       OrangeFontFamily(
  ///           familyName: "Helvetica Neue Medium",
  ///           asset: "assets/fonts/helvetica_neue_latin_medium.ttf",
  ///           fontWeight: FontWeight.w500,
  ///           script: OrangeFontScript.latin,
  ///       )
  ///     ],
  ///   );
  /// ```
  static Future<String?> getFontFamily({
    List<OrangeFontFamily>? fontConfigs,
  }) async {
    if (fontConfigs == null) {
      return OrangeFontService.loadFontFamily();
    }

    /// Configures custom font family names.
    OrangeFontHelper.configure(fontConfigs);

    for (final config in fontConfigs) {
      await _loadFontConfig(config);
    }

    final locale = PlatformDispatcher.instance.locale;
    final isArabic = locale.languageCode == "ar";
    final targetScript = isArabic ? OrangeFontScript.arabic : OrangeFontScript.latin;

    // Find the "regular" font for the target script to return as the base family.
    try {
      final regularFont = fontConfigs.firstWhere(
        (f) => f.script == targetScript && f.fontWeight == FontWeight.w400,
      );
      return regularFont.familyName;
    } catch (e) {
      // Fallback: return the first available font for that script.
      try {
        final fallbackFont =
            fontConfigs.firstWhere((f) => f.script == targetScript);
        return fallbackFont.familyName;
      } catch (e) {
        // Further fallback: return the first font in the list.
        return fontConfigs.isNotEmpty ? fontConfigs.first.familyName : null;
      }
    }
  }

  /// Loads a single font configuration into the Flutter engine.
  static Future<void> _loadFontConfig(OrangeFontFamily config) async {
    final fontLoader = ui.FontLoader(config.familyName);
    final data = await ui.rootBundle.load(config.asset);
    fontLoader.addFont(Future.value(data.buffer.asByteData()));
    await fontLoader.load();
  }
}

///An enumeration of all available Orange brand fonts with their CDN file references.
enum OrangeDownloadableFont {
  helveticaLatinRegular("pm_12751_491_491559-ngke9h7d3m-HelveticaNeue-Roman.ttf"),
  helveticaLatinMedium("pm_12751_491_491556-bd333uw5x5-HelveticaNeue-Medium.ttf"),
  helveticaLatinBold("pm_12751_491_491553-29arstkwm3-HelveticaNeue-Bold.ttf"),
  helveticaArabicLight(
      "pm_12751_502_502368-657u3r24tf-HelveticaNeueW20-Arabic-45Light.ttf"),
  helveticaArabicRegular(
      "pm_12751_502_502371-4jrbp3k3ec-HelveticaNeueW20-Arabic-55Roman.ttf"),
  helveticaArabicBold(
      "pm_12751_502_502374-hak4nhssgj-HelveticaNeueW20-Arabic-75Bold.ttf");

  final String cdnFile;

  const OrangeDownloadableFont(this.cdnFile);
}