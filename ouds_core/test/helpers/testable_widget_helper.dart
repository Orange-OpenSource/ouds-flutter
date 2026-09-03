import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_orange/orange_theme.dart';

Widget testableWidget(Widget child, {OudsThemeContract? theme}) {
  final resolvedTheme = theme ?? OrangeTheme();

  return MaterialApp(
    theme: resolvedTheme.themeData,
    darkTheme: resolvedTheme.darkThemeData,
    home: OudsTheme(
      themeContract: resolvedTheme,
      themeMode: ThemeMode.light,
      onColoredSurface: false,
      child: Scaffold(body: child),
    ),
  );
}
