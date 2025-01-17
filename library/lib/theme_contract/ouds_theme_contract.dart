import 'package:flutter/material.dart';

/// Contrat qui doit être implémenté par tous les thèmes.
abstract class OudsThemeContract {
  ThemeData get themeData;

  // Couleurs principales
  Color get primaryColor;
  Color get secondaryColor;
  Color get backgroundColor;

  // Typographie
  TextStyle get headlineTextStyle;
  TextStyle get bodyTextStyle;

  // Espacements
  double get smallSpacing;
  double get mediumSpacing;
  double get largeSpacing;

  // Tokens pour les composants
  double get buttonHeight;
  double get buttonBorderRadius;
}
