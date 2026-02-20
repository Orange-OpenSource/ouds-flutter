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
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

///An enumeration of all available Orange brand fonts with their CDN file references.
enum OrangeFont {
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

  const OrangeFont(this.family, this.cdnFile);

}

///This service manages the loading and usage of Orange brand fonts (Helvetica Neue)
/// in a Flutter application. It handles font downloading from a CDN, local caching,
/// and fallback to system fonts when necessary.
class OrangeFontService {
  static const _cdnBaseUrl = "https://mastermedia.dam-broadcast.com";


  /// Determines which font family to use based on configuration and availability.
  /// [enableHelvetica] (bool, optional): Whether to enable Helvetica fonts. Default: true
  /// [familyName] → Name used later in ThemeData
  /// [assetPaths] → List of TTF asset paths
  static Future<String> getFontFamily({
    bool enableHelvetica = true,
    String? familyName,
    Map<String, String>? fonts,
  }) async {
    // If customFontFamily is provided, returns it immediately
    if (familyName != null && fonts != null) {
      final loader = FontLoader(familyName);

      for (final entry in fonts.entries) {
        final path = entry.value;
        final data = await rootBundle.load(path);
        loader.addFont(Future.value(data));
      }

      await loader.load();

      return familyName;
    }

    // If enableHelvetica is false, returns platform-specific fallback
    if (!enableHelvetica) {
      return getFallback();
    }

    // Attempts to load Helvetica Neue from CDN
      final locale = PlatformDispatcher.instance.locale;
      bool isArabic = locale.languageCode == "ar";
      final font = isArabic
          ? OrangeFont.helveticaArabicRegular
          : OrangeFont.helveticaLatinRegular;
      return await loadFont(font);
  }

  /// Charge une font depuis CDN et retourne le fontFamily à utiliser
  /// Fallback sur Roboto si échec
  static Future<String> loadFont(OrangeFont font) async {
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
      return getFallback();
    }
  }

  static String getFallback() {
    return defaultTargetPlatform == TargetPlatform.android ? "Roboto" : "SFProDisplay";
  }

}