import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

/// [OudsColorScheme] is a utility class that provides color scheme configurations based on the OUDS theme.
/// It determines the appropriate colors (background, border, etc.) based on the current theme mode (light or dark).
/// The class uses [OudsColorSemanticTokens] to access specific color tokens and adjusts the color values accordingly
/// for different states (enabled, disabled, hover, pressed).
/// It supports both system-defined theme modes and custom light/dark modes for the app.

class OudsColorScheme {
  final OudsColorSemanticTokens colorTokens;
  final ThemeMode themeMode;

  OudsColorScheme({
    required this.colorTokens,
    required this.themeMode,
  });

  bool get isDarkTheme {
    if (themeMode == ThemeMode.system) {
      final Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  Color get backgroundColorDefaultEnabled => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgPrimaryDark
      : colorTokens.backgroundColorTokens.bgPrimaryLight;

  Color get backgroundColorDefaultDisabled => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgSecondaryDark
      : colorTokens.backgroundColorTokens.bgSecondaryLight;

  Color get backgroundColorDefaultHover => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgSecondaryDark
      : colorTokens.backgroundColorTokens.bgSecondaryLight;

  Color get backgroundColorDefaultPressed => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgSecondaryDark
      : colorTokens.backgroundColorTokens.bgSecondaryLight;

  Color get colorBorderDefaultEnabled => isDarkTheme
      ? colorTokens.borderColorTokens.borderDefaultDark
      : colorTokens.borderColorTokens.borderDefaultLight;

  Color get contentColorDefaultEnabled =>
      isDarkTheme ? Colors.white : Colors.black;
}
