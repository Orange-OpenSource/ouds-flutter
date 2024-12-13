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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ouds_flutter/core/ouds_color_scheme.dart';

/// A class to define and manage the different themes for the OUDS application.
/// This class provides light and dark themes as well as inverse themes for various UI components.
class OudsTheme {
  /// Private constructor to prevent instantiation of the theme class.
  OudsTheme._();

  /// Orange Theme (Light)
  /// This theme defines the color scheme, app bar, navigation bar, and other UI elements for the light theme using the orange color palette.
  /// It is primarily used in light mode interfaces.
  static ThemeData orangeThemeLight = ThemeData(
    colorScheme: lightOrangeColorScheme,
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: white100,
      backgroundColor: white100,
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: white100,
          systemNavigationBarDividerColor: grey200,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
    ),
    navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: lightOrangeColorScheme.onSecondary,
      elevation: 3.0,
      indicatorColor: grey200,
      indicatorShape: null,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? const TextStyle(color: orange100)
            : const TextStyle(color: black900),
      ),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: lightOrangeColorScheme.primary);
          }
          return IconThemeData(color: lightOrangeColorScheme.secondary);
        },
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      elevation: 3.0,
      indicatorColor: grey200,
      indicatorShape: null,
      selectedIconTheme: IconThemeData(color: lightOrangeColorScheme.primary),
      unselectedIconTheme:
          IconThemeData(color: lightOrangeColorScheme.secondary),
      selectedLabelTextStyle: TextStyle(
        color: lightOrangeColorScheme.primary,
        overflow: TextOverflow.ellipsis,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: lightOrangeColorScheme.secondary,
        overflow: TextOverflow.ellipsis,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
      ),
    ),
  );

  /// Orange Theme (Dark)
  /// This theme defines the color scheme, app bar, navigation bar, and other UI elements for the dark theme using the orange color palette.
  /// It is primarily used in dark mode interfaces.
  static ThemeData orangeThemeDark = ThemeData(
    colorScheme: darkOrangeColorScheme,
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: black900,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurfaceDefault,
      surfaceTintColor: darkSurfaceDefault,
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: black900,
          systemNavigationBarDividerColor: white100,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark),
    ),
    navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: darkOrangeColorScheme.onSecondary,
      elevation: 3.0,
      indicatorColor: grey800,
      indicatorShape: null,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? const TextStyle(color: orange200)
            : const TextStyle(color: white100),
      ),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: darkOrangeColorScheme.primary);
        }
        return IconThemeData(color: darkOrangeColorScheme.secondary);
      }),
    ),
    navigationRailTheme: NavigationRailThemeData(
      elevation: 3.0,
      indicatorColor: grey800,
      indicatorShape: null,
      selectedIconTheme: IconThemeData(color: darkOrangeColorScheme.primary),
      unselectedIconTheme:
          IconThemeData(color: darkOrangeColorScheme.secondary),
      selectedLabelTextStyle: TextStyle(
        color: darkOrangeColorScheme.primary,
        overflow: TextOverflow.ellipsis,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: darkOrangeColorScheme.secondary,
        overflow: TextOverflow.ellipsis,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
      ),
    ),
  );

  /// Inverse Theme (Light)
  /// This theme defines the color scheme, app bar, navigation bar, and other UI elements for the light theme using the orange color palette.
  /// It is primarily used in light mode interfaces.
  static ThemeData inverseThemeLight = ThemeData(
    colorScheme: lightInverseColorScheme,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffeeeeee),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff212121),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff212121),
    ),
    useMaterial3: true,
  );

  /// Inverse Theme (Dark)
  /// This theme defines the color scheme, app bar, navigation bar, and other UI elements for the dark theme using the orange color palette.
  /// It is primarily used in dark mode interfaces.
  static ThemeData inverseThemeDark = ThemeData(
    colorScheme: darkInverseColorScheme,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff212121),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff212121),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xffeeeeee),
    ),
    useMaterial3: true,
  );
}
