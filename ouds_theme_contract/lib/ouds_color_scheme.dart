import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

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
