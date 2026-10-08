import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_orange/orange_theme.dart';

Widget testableWidget(Widget child) {
  final theme = OrangeTheme();

  return MaterialApp(
    theme: theme.themeData,
    darkTheme: theme.darkThemeData,
    home: OudsTheme(
      themeContract: theme,
      themeMode: ThemeMode.light,
      onColoredSurface: false,
      child: Scaffold(body: child),
    ),
  );
}
