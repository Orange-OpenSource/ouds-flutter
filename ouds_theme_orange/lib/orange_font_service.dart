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
    final fontConfig =   [
      OrangeFontFamily(
             familyName: "Helvetica Neue Arabic",
             assets: [
               OrangeDownloadableFont.helveticaArabicLight.cdnFile,
               OrangeDownloadableFont.helveticaArabicRegular.cdnFile,
               OrangeDownloadableFont.helveticaArabicBold.cdnFile,
             ]
           ),
      OrangeFontFamily(
               familyName: "Helvetica Neue",
               assets: [
                 OrangeDownloadableFont.helveticaLatinRegular.cdnFile,
                 OrangeDownloadableFont.helveticaLatinMedium.cdnFile,
                 OrangeDownloadableFont.helveticaLatinBold.cdnFile,
    ]
    )
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
  ///   - `assets`: List of CDN file paths for the font files.
  ///
  /// ## Returns
  /// - A [Future] that completes with the font family name (String) suitable for the current locale.
  /// - If loading fails, returns a fallback font name:
  ///   - "Roboto" on Android
  ///   - "SFProDisplay" on iOS
  ///
  /// ## Error Handling
  /// - Catches all exceptions during font loading and caching processes.
  /// - Logs errors to the console and continues with the next font.
  /// - Ensures the method does not throw exceptions, providing a fallback font instead.
  ///
  /// ## Network Request
  ///
  /// Downloads from: `{_cdnBaseUrl}/{font.cdnFile}`
  ///
  static Future<String> _loadFont(List<OrangeFontFamily> fontsFamily) async {
    final loadedFamilies = <String, String>{}; // Map: language -> fontFamily

    for (final font in fontsFamily) {
      final cdnFontFamily = font.familyName;
      final cdnFilesName = font.assets;  // List of font files

      try {
        final loader = FontLoader(cdnFontFamily);

        // Loop through all font files
        for (final cdnFileName in cdnFilesName) {
          final dir = await getApplicationDocumentsDirectory();
          final file = File("${dir.path}/$cdnFileName");

          Uint8List bytes;

          // Check if file exists locally
          if (await file.exists()) {
            bytes = await file.readAsBytes();
          } else {
            // Download from CDN
            final response = await http.get(Uri.parse("$_cdnBaseUrl/$cdnFileName"));
            if (response.statusCode != 200) {
              throw Exception("CDN font download failed for $cdnFileName");
            }
            bytes = response.bodyBytes;
            // Save to local cache
            await file.writeAsBytes(bytes);
          }

          // Add file to loader
          loader.addFont(Future.value(ByteData.view(bytes.buffer)));
        }

        // Load all font files
        await loader.load();

        // Store loaded font with its language identifier
        // Assuming font has a language property or you can determine it from familyName
        if (font.familyName.toLowerCase().contains('arabic')) {
          loadedFamilies['ar'] = font.familyName;
        } else {
          loadedFamilies['latin'] = font.familyName;
        }

      } catch (e) {
        // On error, continue with next font
        print("Error loading font $cdnFontFamily: $e");
        continue;
      }
    }

    // Get current locale
    final locale = PlatformDispatcher.instance.locale;
    final isArabic = locale.languageCode == "ar";

    // Return appropriate font based on locale
    final localizedFontFamily = isArabic
        ? loadedFamilies['ar']
        : loadedFamilies['latin'];

    // Return localized font or fallback
    return localizedFontFamily ?? _getFallback();
  }

  /// Returns the platform-specific fallback font family name.
  static String _getFallback() {
    return defaultTargetPlatform == TargetPlatform.android ? "Roboto" : "SFProDisplay";
  }

}