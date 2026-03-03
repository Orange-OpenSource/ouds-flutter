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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ouds_theme_orange/orange_font_family.dart';
import 'package:path_provider/path_provider.dart';

/// A service for managing Orange brand fonts (Helvetica Neue) in Flutter applications.
///
/// This service handles the complete lifecycle of Orange brand fonts:
/// - Downloads fonts from Orange's CDN
/// - Caches fonts locally for offline use
/// - Loads fonts into the Flutter engine
/// - Provides fallback to system fonts when necessary
///
/// ## Font Selection Logic
///
/// The service automatically detects the device locale and loads either
/// the Arabic or Latin variant of Helvetica Neue:
/// - **Arabic locale** (`ar`): Loads Helvetica Neue Arabic
/// - **Other locales**: Loads Helvetica Neue Latin
///
/// ## Caching Strategy
///
/// 1. Checks the local application documents directory for cached fonts.
/// 2. Downloads from CDN if not cached.
/// 3. Stores fonts locally for future use.
/// 4. Uses cached fonts for subsequent loads, enabling offline use.
///
/// ## Error Handling
///
/// The service never throws exceptions. Instead, it returns a fallback font:
/// - **Android**: Roboto
/// - **iOS**: SFPro Display
///
/// Note: The first run requires an internet connection to download fonts.
/// Subsequent runs work offline using cached fonts.
///
class OrangeFontService {
  /// All font files are downloaded from this CDN endpoint.
  static const _cdnBaseUrl = "https://mastermedia.dam-broadcast.com";

  /// Loads the appropriate Orange font family based on device locale.
  ///
  /// This method automatically detects the device locale and loads either
  /// the Arabic or Latin variant of Helvetica Neue.
  ///
  /// ## Locale Detection
  ///
  /// - **Arabic** (`ar`): Loads [OrangeDownloadableFont.helveticaArabicRegular],
  ///   [OrangeDownloadableFont.helveticaArabicLight] and [OrangeDownloadableFont.helveticaArabicBold]
  /// - **All others**: Loads [OrangeDownloadableFont.helveticaLatinRegular],
  ///   [OrangeDownloadableFont.helveticaLatinMedium] and [OrangeDownloadableFont.helveticaLatinBold]
  ///
  /// ## Return Value
  ///
  /// Returns a [Future] that completes with:
  /// - The font family name (e.g., "Helvetica Neue") if loading succeeds
  /// - A platform-specific fallback font name if loading fails:
  ///   - "Roboto" on Android
  ///   - "SFProDisplay" on iOS
  ///
  /// ## Network Requirements
  ///
  /// - First run requires internet connection to download fonts
  /// - Subsequent runs work offline using cached fonts
  ///
  static Future<String> loadFontFamily() async {
    // Load each font weight as a separate family since FontLoader doesn't support weight specification
    final fontConfig = [
      // Arabic fonts - each weight as separate family
      OrangeFontFamily(
        familyName: "Helvetica Neue Arabic Light",
        asset: OrangeDownloadableFont.helveticaArabicLight.cdnFile,
        fontWeight: FontWeight.w300,
        script: OrangeFontScript.arabic,
      ),
      OrangeFontFamily(
        familyName: "Helvetica Neue Arabic",
        asset: OrangeDownloadableFont.helveticaArabicRegular.cdnFile,
        fontWeight: FontWeight.w400,
        script: OrangeFontScript.arabic
      ),
      OrangeFontFamily(
        familyName: "Helvetica Neue Arabic Bold",
        asset: OrangeDownloadableFont.helveticaArabicBold.cdnFile,
        fontWeight: FontWeight.bold,
        script: OrangeFontScript.arabic
      ),
      // Latin fonts - each weight as separate family
      OrangeFontFamily(
        familyName: "Helvetica Neue Regular",
        asset: OrangeDownloadableFont.helveticaLatinRegular.cdnFile,
        fontWeight: FontWeight.normal,
        script: OrangeFontScript.latin
      ),
      OrangeFontFamily(
        familyName: "Helvetica Neue Medium",
        asset: OrangeDownloadableFont.helveticaLatinMedium.cdnFile,
        fontWeight: FontWeight.w500,
        script: OrangeFontScript.latin
      ),
      OrangeFontFamily(
        familyName: "Helvetica Neue Bold",
        asset: OrangeDownloadableFont.helveticaLatinBold.cdnFile,
        fontWeight: FontWeight.bold,
        script: OrangeFontScript.latin
      ),
    ];

    return await _loadFont(fontConfig);
  }

  /// Loads a list of font families from CDN with local caching support.
  ///
  /// This method attempts to load each font family specified in the [fontsFamily] list.
  /// For each font family:
  /// - Checks if the font files are already cached locally.
  /// - Downloads missing font files from the CDN if necessary.
  /// - Saves downloaded files to local cache for future use.
  /// - Loads the font files into the Flutter engine using [FontLoader].
  /// - Stores the font family name associated with its language (Arabic or Latin).
  ///
  /// The method then determines the current device locale and returns the font family
  /// name appropriate for the language:
  /// - Returns the Arabic font family if the locale is Arabic.
  /// - Returns the Latin font family otherwise.
  /// - If no font could be loaded, returns a platform-specific fallback font.
  ///
  /// ## Parameters
  /// - [fontsFamily]: A list of [OrangeFontFamily] objects, each containing:
  ///   - `familyName`: The font family name to register.
  ///   - `asset`: The CDN file path for the font file.
  ///
  /// ## Returns
  /// - A [Future] that completes with the font family name (String) suitable for the current locale.
  /// - If loading fails, returns a fallback font name:
  ///   - "Roboto" on Android
  ///   - "SFProDisplay" on iOS
  ///
  /// ## Error Handling
  /// - Catches all exceptions during font loading and caching processes.
  /// - Silently continues with the next font if one fails to load.
  /// - Ensures the method does not throw exceptions, providing a fallback font instead.
  ///
  /// ## Network Request
  ///
  /// Downloads from: `{_cdnBaseUrl}/{font.cdnFile}`
  ///
  static Future<String> _loadFont(List<OrangeFontFamily> fontsFamily) async {
    const arabicLocale = 'ar';
    const latinLocale = 'latin';

    final loadedFamilies = <String, String>{}; // Map: language -> fontFamily

    for (final font in fontsFamily) {
      try {
        await _loadSingleFont(font, loadedFamilies);
      } catch (e) {
        // Silently continue with next font on error
        continue;
      }
    }

    // Get current locale and return appropriate font
    final isArabic = PlatformDispatcher.instance.locale.languageCode == arabicLocale;
    final localizedFontFamily = isArabic ? loadedFamilies[arabicLocale] : loadedFamilies[latinLocale];

    return localizedFontFamily ?? _getFallback();
  }

  /// Loads a single font family and registers it in the loaded families map.
  static Future<void> _loadSingleFont(OrangeFontFamily font, Map<String, String> loadedFamilies) async {
    final loader = FontLoader(font.familyName);

    // Load font file for this family
    final bytes = await _getFontBytes(font.asset);
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));

    await loader.load();

    // Store ONLY the Regular variant as the default font family for each language
    _registerFontFamily(font.familyName, loadedFamilies);
  }

  /// Retrieves font bytes from local cache or downloads from CDN.
  static Future<Uint8List> _getFontBytes(String cdnFileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$cdnFileName");

    // Return cached file if exists
    if (await file.exists()) {
      return await file.readAsBytes();
    }

    // Download from CDN
    final response = await http.get(Uri.parse("$_cdnBaseUrl/$cdnFileName"));
    if (response.statusCode != 200) {
      throw Exception("CDN font download failed for $cdnFileName with status ${response.statusCode}");
    }

    final bytes = response.bodyBytes;

    // Save to local cache
    await file.writeAsBytes(bytes);

    return bytes;
  }

  /// Registers a font family in the loaded families map.
  /// Only stores the Regular variant as the default for each language.
  static void _registerFontFamily(String familyName, Map<String, String> loadedFamilies) {
    final lowerName = familyName.toLowerCase();

    if (lowerName.contains('arabic')) {
      // For Arabic: only store "Helvetica Neue Arabic" (without Light/Bold suffix)
      if (!lowerName.contains('light') && !lowerName.contains('bold')) {
        loadedFamilies['ar'] = familyName;
      }
    } else if (lowerName.contains('regular')) {
      // For Latin: only store "Helvetica Neue Regular"
      loadedFamilies['latin'] = familyName;
    }
  }

  /// Returns the platform-specific fallback font family name.
  static String _getFallback() {
    return defaultTargetPlatform == TargetPlatform.android ? "Roboto" : "SFProDisplay";
  }
}
