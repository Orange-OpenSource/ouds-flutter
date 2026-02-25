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
import 'package:ouds_theme_orange/orange_font_config.dart';
import 'package:path_provider/path_provider.dart';

/// A service for managing Orange brand fonts (Helvetica Neue) in Flutter applications.
///
/// This service handles the complete lifecycle of Orange brand fonts:
/// - Downloads fonts from Orange's CDN
/// - Caches fonts locally for offline use
/// - Loads fonts into the Flutter engine
/// - Provides fallback to system fonts when necessary
///
/// ## Usage
///
/// Load the appropriate Orange font at app startup:
///
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   final fontFamily = await OrangeFontService.loadFontFamily();
///
///   runApp(MyApp(fontFamily: fontFamily));
/// }
/// ```
///
/// ## Font Selection Logic
///
/// The service automatically selects the appropriate font variant:
/// - **Arabic locale** (`ar`): Loads Helvetica Neue Arabic
/// - **Other locales**: Loads Helvetica Neue Latin
///
/// ## Caching Strategy
///
/// 1. First check: Local application documents directory
/// 2. If not found: Download from CDN
/// 3. Save to local cache for future use
/// 4. On error: Fall back to system fonts
///
/// ## Error Handling
///
/// The service never throws exceptions. Instead, it returns a fallback font:
/// - **Android**: Roboto
/// - **iOS**: SFPro Display
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
  /// - The font family name (e.g., "HelveticaNeue") if loading succeeds
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
    final locale = PlatformDispatcher.instance.locale;
    bool isArabic = locale.languageCode == "ar";
    final font = isArabic
        ? OrangeDownloadableFont.helveticaArabicRegular
        : OrangeDownloadableFont.helveticaLatinRegular;
    return await _loadFont(font);
  }



  /// Loads a font from CDN with local caching support.
  ///
  /// This private method implements the complete font loading workflow:
  ///
  /// ## Loading Process
  ///
  /// 1. **Check local cache**: Looks for font file in app documents directory
  /// 2. **Load from cache**: If found, reads bytes from local file
  /// 3. **Download from CDN**: If not cached, downloads from [_cdnBaseUrl]
  /// 4. **Save to cache**: Stores downloaded font for future use
  /// 5. **Register font**: Loads font into Flutter engine using [FontLoader]
  /// 6. **Return family name**: Returns the font family identifier
  ///
  /// ## Parameters
  ///
  /// - [font]: The [OrangeDownloadableFont] configuration containing:
  ///   - `family`: Font family name for registration
  ///   - `cdnFile`: CDN path to the font file
  ///
  /// ## Return Value
  ///
  /// Returns a [Future] that completes with:
  /// - The font family name if all steps succeed
  /// - A platform-specific fallback font if any step fails
  ///
  /// ## Error Handling
  ///
  /// Catches all exceptions and returns [_getFallback] instead of throwing.
  /// Possible error scenarios:
  /// - Network unavailable during download
  /// - CDN returns non-200 status code
  /// - File system errors during caching
  /// - Font data corruption
  ///
  /// ## Storage Location
  ///
  /// Fonts are stored at: `{ApplicationDocumentsDirectory}/{fontFamily}`
  ///
  /// Example: `/data/user/0/com.example.app/app_flutter/HelveticaNeue`
  ///
  /// ## Network Request
  ///
  /// Downloads from: `{_cdnBaseUrl}/{font.cdnFile}`
  ///
  static Future<String> _loadFont(OrangeDownloadableFont font) async {
    final cdnFont = font.family;
    final cdnFileName = font.cdnFile;

    try {
      //Checks if font file exists in local application documents directory
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$cdnFont");

      Uint8List bytes;
      //If exists, loads from local cache
      if (await file.exists()) {
        bytes = await file.readAsBytes();
      } else {
        //If not, downloads from CDN
        final response = await http.get(Uri.parse("$_cdnBaseUrl/$cdnFileName"));
        if (response.statusCode != 200) throw Exception("CDN font download failed");
        bytes = response.bodyBytes;
        //Saves downloaded font to local cache
        await file.writeAsBytes(bytes);
      }
      //Registers font with FontLoader
      final loader = FontLoader(font.family);
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
      await loader.load();
      //Returns font family name on success
      return font.family;
    } catch (_) {
      //returns platform fallback on any error
      return _getFallback();
    }
  }

  /// Returns the platform-specific fallback font family name.
  static String _getFallback() {
    return defaultTargetPlatform == TargetPlatform.android ? "Roboto" : "SFProDisplay";
  }

}