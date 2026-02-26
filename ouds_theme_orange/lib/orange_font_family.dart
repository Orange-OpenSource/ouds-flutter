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
import 'package:ouds_theme_orange/orange_font_service.dart';

/// A utility class for dynamically loading custom font families at runtime.
///
/// This class provides functionality to load font assets.
///
/// **Parameters:**
/// -[familyName]: The name identifier for this font family.
///   This name will be used to reference the font in [TextStyle.fontFamily].
/// -[assets]: List of asset paths pointing to the font files.
///   Each path should point to a valid font file (TTF) in the application's assets.
///   Multiple files can represent different weights and styles of the same font family.
///
/// **Usage example:**
///
/// ```dart
///   final orangeFontFamily = await OrangeFontFamily.getFontFamily(
///     fontConfigs: [
///       OrangeFontFamily(
///         familyName: "HelveticaNeueArabic",
///         assets: [
///           "assets/fonts/helvetica_neue_arabic_bold.ttf",
///           "assets/fonts/helvetica_neue_arabic_light.ttf",
///           "assets/fonts/helvetica_neue_arabic_roman.ttf",
///         ]
///       ),
///       OrangeFontFamily(
///           familyName: "HelveticaNeueLatin",
///           assets: [
///             "assets/fonts/helvetica_neue_latin_bold.ttf",
///             "assets/fonts/helvetica_neue_latin_medium.ttf",
///             "assets/fonts/helvetica_neue_latin_roman.ttf",
///           ]
///       )
///     ],
///   );
/// ```
/// Make sure to include the assets/fonts/ directory in your pubspec.yaml file under the assets section, like this:
///
/// ```yaml
/// flutter:
///   assets:
///     - assets/fonts/
/// ```
class OrangeFontFamily {
  final String familyName;
  final List<String> assets;

  const OrangeFontFamily({
    required this.familyName,
    required this.assets,
  });

  /// Retrieves the appropriate font family name based on the device's locale and optional font configurations.
  ///
  /// It then determines the current device locale and returns the font family name suitable for the language:
  /// - Returns the Arabic font family if the locale is Arabic.
  /// - Returns the Latin font family otherwise.
  ///
  /// ## Parameters
  /// - [fontConfigs] (optional): A list of [OrangeFontFamily] objects representing custom font configurations.
  ///   If null, the method defaults to downloading and caching the font family via [OrangeFontService.loadFontFamily()].
  ///
  /// ## Returns
  /// - A [Future] that completes with the font family name (String?) appropriate for the current locale.
  /// - Returns `null` if no font family could be determined or loaded.
  ///
  /// ## Usage
  /// Call this method during app initialization or before rendering text to dynamically select the font family
  /// based on locale and custom configurations.
  static Future<String?> getFontFamily({
    List<OrangeFontFamily>? fontConfigs,
  }) async {

    if(fontConfigs == null){
      return OrangeFontService.loadFontFamily();
    }

    final loadedFamilies = <String, String>{}; // Map: language -> fontFamily

    for (final config in fontConfigs) {
      await _loadFontConfig(config);
      // Store loaded font with its language identifier
      // Assuming font has a language property or you can determine it from familyName
      if (config.familyName.toLowerCase().contains('arabic')) {
        loadedFamilies['ar'] = config.familyName;
      } else {
        loadedFamilies['latin'] = config.familyName;
      }
    }

    final locale = PlatformDispatcher.instance.locale;
    bool isArabic = locale.languageCode == "ar";
    // Return appropriate font based on locale
    final localizedFontFamily = isArabic
        ? loadedFamilies['ar']
        : loadedFamilies['latin'];

    return localizedFontFamily;
  }


  /// Loads a single font configuration into the Flutter engine.
  ///
  /// This private method handles the actual loading process:
  /// 1. Creates a [FontLoader] with the specified family name
  /// 2. Loads each font asset from the bundle
  /// 3. Converts the data to the required format
  /// 4. Registers the fonts with the engine
  ///
  /// Throws an exception if any asset path is invalid or the font
  /// data cannot be loaded.
  static Future<void> _loadFontConfig(OrangeFontFamily config) async {
    final fontLoader = ui.FontLoader(config.familyName);

    for (final asset in config.assets) {
      final data = await ui.rootBundle.load(asset);
      fontLoader.addFont(Future.value(data.buffer.asByteData()));
    }

    await fontLoader.load();
  }
}

///An enumeration of all available Orange brand fonts with their CDN file references.
enum OrangeDownloadableFont {
  helveticaLatinRegular("pm_12751_491_491559-ngke9h7d3m-HelveticaNeue-Roman.ttf"),
  helveticaLatinMedium("pm_12751_491_491556-bd333uw5x5-HelveticaNeue-Medium.ttf"),
  helveticaLatinBold("pm_12751_491_491553-29arstkwm3-HelveticaNeue-Bold.ttf"),
  helveticaArabicLight("pm_12751_502_502368-657u3r24tf-HelveticaNeueW20-Arabic-45Light.ttf"),
  helveticaArabicRegular("pm_12751_502_502371-4jrbp3k3ec-HelveticaNeueW20-Arabic-55Roman.ttf"),
  helveticaArabicBold("pm_12751_502_502374-hak4nhssgj-HelveticaNeueW20-Arabic-75Bold.ttf");

  final String cdnFile;

  const OrangeDownloadableFont(this.cdnFile);

}