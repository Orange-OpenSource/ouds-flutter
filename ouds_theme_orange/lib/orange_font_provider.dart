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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ouds_theme_orange/orange_font_family.dart';
import 'package:ouds_theme_orange/orange_font_helper.dart';
import 'package:path_provider/path_provider.dart';

/// Provider for loading Orange brand fonts (Helvetica Neue).
///
/// ## Three Loading Modes:
///
/// ### 1. CDN Mode (Automatic - Blocking)
/// Downloads fonts from CDN, applies weights automatically:
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   final fontFamily = await OrangeFontProvider.loadFromCdn();
///   runApp(MyApp(theme: OrangeTheme(fontFamily)));
/// }
/// ```
///
/// ### 2. Assets Mode (Manual Configuration - Blocking)
/// User specifies asset paths manually:
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   final orangeFontFamily = OrangeFontFamily(
///     latin: OrangeHelveticaNeueLatin.bundled(
///       regularFontRes: "fonts/helvetica_neue_latin_roman.ttf",
///       mediumFontRes: "fonts/helvetica_neue_latin_medium.ttf",
///       boldFontRes: "fonts/helvetica_neue_latin_bold.ttf",
///     ),
///     arabic: OrangeHelveticaNeueArabic.bundled(
///       lightFontRes: "fonts/helvetica_neue_arabic_light.ttf",
///       regularFontRes: "fonts/helvetica_neue_arabic_roman.ttf",
///       boldFontRes: "fonts/helvetica_neue_arabic_bold.ttf",
///     ),
///   );
///   final fontFamily = await OrangeFontProvider.loadFromAssets(orangeFontFamily);
///   runApp(MyApp(theme: OrangeTheme(fontFamily)));
/// }
/// ```
///
/// ### 3. Service Mode (Non-Blocking - Recommended)
/// Use `OrangeFontService` for background loading without blocking app startup:
/// ```dart
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   OrangeFontService.instance.loadFromCdn();
///   runApp(MyApp());  // Starts immediately
/// }
/// ```
class OrangeFontProvider {
  /// CDN base URL for font downloads
  static const _cdnBaseUrl = "https://mastermedia.dam-broadcast.com";

  /// Loads Orange fonts from CDN based on device locale.
  ///
  /// **CDN Mode - Automatic**: Downloads fonts from CDN and applies weights automatically.
  /// No configuration needed - fileName and weights are managed internally.
  ///
  /// Automatically loads:
  /// - Arabic locale (`ar`): Helvetica Neue Arabic (Light, Regular, Bold)
  /// - Other locales: Helvetica Neue Latin (Regular, Medium, Bold)
  ///
  /// Returns the font family name or fallback font if loading fails.
  static Future<String> loadFromCdn() async {
    final isArabic = PlatformDispatcher.instance.locale.languageCode == 'ar';
    final variants = isArabic ? _OrangeFontVariant.arabicVariants : _OrangeFontVariant.latinVariants;

    return await _loadFromCdn(variants);
  }

  /// Loads Orange fonts from user-specified assets.
  ///
  /// **Assets Mode - Manual Configuration**:
  /// User must specify asset paths for each font weight.
  ///
  /// Example:
  /// ```dart
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
  /// ```
  ///
  /// Returns the font family name or fallback font if loading fails.
  static Future<String> loadFromAssets(OrangeFontFamily fontFamily) async {
    final isArabic = PlatformDispatcher.instance.locale.languageCode == 'ar';
    return await _loadFromAssets(fontFamily, isArabic);
  }

  /// CDN Loading Logic: Uses private fileName with automatic weight management.
  static Future<String> _loadFromCdn(List<_OrangeFontVariant> variants) async {
    try {
      for (final variant in variants) {
        final loader = FontLoader(variant.familyName);
        final bytes = await _getFontBytesFromCdn(variant.fileName);
        loader.addFont(Future.value(ByteData.view(bytes.buffer)));
        await loader.load();

        /*if (kDebugMode) {
          print('✅ Loaded ${variant.familyName} (weight: ${variant.fontWeight.value}) from CDN');
        }*/
      }

      final isArabic = PlatformDispatcher.instance.locale.languageCode == 'ar';
      return OrangeFontHelper.getDefaultFontFamily(isArabic: isArabic);
    } catch (e) {
      /* if (kDebugMode) {
        print('❌ Failed to load fonts from CDN: $e');
      }*/
      return _getFallbackFont();
    }
  }

  /// Assets Loading Logic: Uses user-specified asset paths.
  static Future<String> _loadFromAssets(
    OrangeFontFamily fontFamily,
    bool isArabic,
  ) async {
    try {
      if (isArabic) {
        // Load Arabic fonts
        if (fontFamily.arabic.lightFontRes != null) {
          await _loadSingleFont(
            "HelveticaNeue-Arabic-Light",
            fontFamily.arabic.lightFontRes!,
            FontWeight.w300,
          );
        }
        if (fontFamily.arabic.regularFontRes != null) {
          await _loadSingleFont(
            "HelveticaNeue-Arabic",
            fontFamily.arabic.regularFontRes!,
            FontWeight.w400,
          );
        }
        if (fontFamily.arabic.boldFontRes != null) {
          await _loadSingleFont(
            "HelveticaNeue-Arabic-Bold",
            fontFamily.arabic.boldFontRes!,
            FontWeight.w700,
          );
        }
        return OrangeFontHelper.getDefaultFontFamily(isArabic: true);
      } else {
        // Load Latin fonts
        if (fontFamily.latin.regularFontRes != null) {
          await _loadSingleFont(
            "HelveticaNeue",
            fontFamily.latin.regularFontRes!,
            FontWeight.w400,
          );
        }
        if (fontFamily.latin.mediumFontRes != null) {
          await _loadSingleFont(
            "HelveticaNeue-Medium",
            fontFamily.latin.mediumFontRes!,
            FontWeight.w500,
          );
        }
        if (fontFamily.latin.boldFontRes != null) {
          await _loadSingleFont(
            "HelveticaNeue-Bold",
            fontFamily.latin.boldFontRes!,
            FontWeight.w700,
          );
        }
        return OrangeFontHelper.getDefaultFontFamily(isArabic: false);
      }
    } catch (e) {
      /*if (kDebugMode) {
        print('❌ Failed to load fonts from assets: $e');
      }*/
      return _getFallbackFont();
    }
  }

  /// Loads a single font file from assets.
  static Future<void> _loadSingleFont(
    String familyName,
    String assetPath,
    FontWeight weight,
  ) async {
    final loader = FontLoader(familyName);
    final bytes = await _getFontBytesFromAssets(assetPath);
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();

    /*if (kDebugMode) {
      print('✅ Loaded $familyName (weight: ${weight.value}) from asset: $assetPath');
    }*/
  }

  /// Downloads font from CDN with local caching.
  static Future<Uint8List> _getFontBytesFromCdn(String cdnFileName) async {
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

  /// Loads font from local assets.
  static Future<Uint8List> _getFontBytesFromAssets(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  /// Returns platform-specific fallback font.
  static String _getFallbackFont() {
    return defaultTargetPlatform == TargetPlatform.android ? "Roboto" : "SFProDisplay";
  }
}

/// Internal enum for CDN font loading (not exposed to users).
/// Contains private fileName paths and weight configuration.
enum _OrangeFontVariant {
  arabicLight(
    familyName: "HelveticaNeue-Arabic-Light",
    fontWeight: FontWeight.w300,
    fileName: "pm_12751_502_502368-657u3r24tf-HelveticaNeueW20-Arabic-45Light.ttf",
  ),
  arabicRoman(
    familyName: "HelveticaNeue-Arabic",
    fontWeight: FontWeight.w400,
    fileName: "pm_12751_502_502371-4jrbp3k3ec-HelveticaNeueW20-Arabic-55Roman.ttf",
  ),
  arabicBold(
    familyName: "HelveticaNeue-Arabic-Bold",
    fontWeight: FontWeight.w700,
    fileName: "pm_12751_502_502374-hak4nhssgj-HelveticaNeueW20-Arabic-75Bold.ttf",
  ),
  latinRoman(
    familyName: "HelveticaNeue",
    fontWeight: FontWeight.w400,
    fileName: "pm_12751_491_491559-ngke9h7d3m-HelveticaNeue-Roman.ttf",
  ),
  latinMedium(
    familyName: "HelveticaNeue-Medium",
    fontWeight: FontWeight.w500,
    fileName: "pm_12751_491_491556-bd333uw5x5-HelveticaNeue-Medium.ttf",
  ),
  latinBold(
    familyName: "HelveticaNeue-Bold",
    fontWeight: FontWeight.w700,
    fileName: "pm_12751_491_491553-29arstkwm3-HelveticaNeue-Bold.ttf",
  );

  final String familyName;
  final FontWeight fontWeight;
  final String fileName;

  const _OrangeFontVariant({
    required this.familyName,
    required this.fontWeight,
    required this.fileName,
  });

  static List<_OrangeFontVariant> get arabicVariants => [
        arabicLight,
        arabicRoman,
        arabicBold,
      ];

  static List<_OrangeFontVariant> get latinVariants => [
        latinRoman,
        latinMedium,
        latinBold,
      ];
}
