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

import 'package:flutter/foundation.dart';
import 'package:ouds_theme_orange/orange_font_family.dart';
import 'package:ouds_theme_orange/orange_font_provider.dart';

/// Service for managing Orange font loading without blocking app startup.
///
/// This service allows fonts to be loaded asynchronously in the background
/// while the app starts immediately with fallback fonts.
///
/// ## Usage (Non-blocking):
///
/// ```dart
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///
///   // Start loading fonts in background (non-blocking)
///   OrangeFontService.instance.loadFromCdn();
///
///   runApp(MyApp());  // App starts immediately with fallback fonts
/// }
/// ```
///
/// ## Usage with Assets (Non-blocking):
///
/// ```dart
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///
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
///
///   OrangeFontService.instance.loadFromAssets(orangeFontFamily);
///
///   runApp(MyApp());
/// }
/// ```
class OrangeFontService {
  static final OrangeFontService instance = OrangeFontService._();

  OrangeFontService._();

  List<String?>? _loadedFontsFamily;

  bool _isLoading = false;
  final List<VoidCallback> _listeners = [];

  /// Gets the currently loaded font family name, or null if not yet loaded.
  String? get fontFamily {
    final isArabic = PlatformDispatcher.instance.locale.languageCode == 'ar';

    try {
      if (isArabic) {
        return _loadedFontsFamily?.firstWhere(
              (font) =>  font != null &&  font.toLowerCase().contains('arabic'),
        );
      }

      return _loadedFontsFamily?.firstWhere(
            (font) => font != null && !font.toLowerCase().contains('arabic'),
      );
    } on StateError {
      return null; // Return null if no font is found
    }
  }
  /// Returns true if fonts are currently being loaded.
  bool get isLoading => _isLoading;

  /// Returns true if fonts have been successfully loaded.
  bool get isLoaded => _loadedFontsFamily != null;

  /// Adds a listener that will be called when fonts finish loading.
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Removes a listener.
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Notifies all listeners that fonts have been loaded.
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Loads fonts from CDN in background (non-blocking).
  void loadFromCdn() {
    if (_isLoading || _loadedFontsFamily != null) return;

    _isLoading = true;
    OrangeFontProvider.loadFromCdn().then((fontFamily) {
      _loadedFontsFamily = fontFamily;
      _isLoading = false;
      _notifyListeners();
      if (kDebugMode) {
        print('🎨 Orange fonts loaded: $fontFamily');
      }
    }).catchError((error) {
      _isLoading = false;
      if (kDebugMode) {
        print('❌ Failed to load Orange fonts: $error');
      }
    });
  }

  /// Loads fonts from assets in background (non-blocking).
  void loadFromAssets(OrangeFontFamily fontFamily) {
    if (_isLoading || _loadedFontsFamily != null) return;

    _isLoading = true;
    OrangeFontProvider.loadFromAssets(fontFamily).then((loadedFontFamily) {
      _loadedFontsFamily = [loadedFontFamily];
      _isLoading = false;
      _notifyListeners();
      /*if (kDebugMode) {
        print('🎨 Orange fonts loaded from assets: $loadedFontFamily');
      }*/
    }).catchError((error) {
      _isLoading = false;
      /*if (kDebugMode) {
        print('❌ Failed to load Orange fonts from assets: $error');
      }*/
    });
  }

  /// Resets the service (useful for testing or hot reload).
  void reset() {
    _loadedFontsFamily = null;
    _isLoading = false;
    _listeners.clear();
  }
}
