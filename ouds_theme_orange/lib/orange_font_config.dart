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


import 'package:flutter/services.dart' as ui;

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
///   final orangeFontFamily = await OrangeFontService.getFontFamily(
///     fontConfigs: [
///       FontConfig(
///         familyName: "HelveticaNeueArabic",
///         assets: [
///           "fonts/helvetica_neue_arabic_bold.ttf",
///           "fonts/helvetica_neue_arabic_light.ttf",
///           "fonts/helvetica_neue_arabic_roman.ttf",
///         ]
///       ),
///       FontConfig(
///           familyName: "HelveticaNeueLatin",
///           assets: [
///             "fonts/helvetica_neue_latin_bold.ttf",
///             "fonts/helvetica_neue_latin_medium.ttf",
///             "fonts/helvetica_neue_latin_roman.ttf",
///           ]
///       )
///     ],
///   );
/// ```
class OrangeFontFamily {
  final String familyName;
  final List<String> assets;

  const OrangeFontFamily({
    required this.familyName,
    required this.assets,
  });

  /// Loads multiple font families asynchronously.
  ///
  /// Takes a list of [OrangeFontFamily] configurations and loads each one
  /// into the Flutter engine, making them available for use in the app.
  ///
  /// Returns a [Future] that completes with:
  /// - `null` if [fontConfigs] is null
  /// - A list of successfully loaded font family names
  ///
  static Future<List<String>?> getFontFamily({
    List<OrangeFontFamily>? fontConfigs,
  }) async {

    if(fontConfigs == null) return null;

    final loadedFamilies = <String>[];

    for (final config in fontConfigs) {
      await _loadFontConfig(config);
      loadedFamilies.add(config.familyName);
    }

    return loadedFamilies;

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
  helveticaLatinRegular("helvetica_latin_regular",
      "pm_12751_491_491559-ngke9h7d3m-HelveticaNeue-Roman.ttf"),
  helveticaLatinMedium("helvetica_latin_medium",
      "pm_12751_491_491556-bd333uw5x5-HelveticaNeue-Medium.ttf"),
  helveticaLatinBold("helvetica_latin_bold",
      "pm_12751_491_491553-29arstkwm3-HelveticaNeue-Bold.ttf"),
  helveticaArabicLight("helvetica_arabic_light",
      "pm_12751_502_502368-657u3r24tf-HelveticaNeueW20-Arabic-45Light.ttf"),
  helveticaArabicRegular("helvetica_arabic_regular",
      "pm_12751_502_502371-4jrbp3k3ec-HelveticaNeueW20-Arabic-55Roman.ttf"),
  helveticaArabicBold("helvetica_arabic_bold",
      "pm_12751_502_502374-hak4nhssgj-HelveticaNeueW20-Arabic-75Bold.ttf");

  final String family;
  final String cdnFile;

  const OrangeDownloadableFont(this.family, this.cdnFile);

}