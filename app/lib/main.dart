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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_flutter_demo/l10n/gen/ouds_flutter_app_localizations.dart';
import 'package:ouds_flutter_demo/ui/main_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(OudsApplication());
}

class OudsApplication extends StatefulWidget {
  const OudsApplication({super.key});

  @override
  State<OudsApplication> createState() => _OudsApplicationState();
}

class _OudsApplicationState extends State<OudsApplication> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeController>(
      create: (_) => ThemeController(),
      child: Consumer<ThemeController>(
        builder: (context, themeController, _) {
          return GetMaterialApp(
            title: 'Design System Toolbox',
            theme: themeController.themeData,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return Directionality(
                textDirection: Directionality.of(context) == TextDirection.rtl
                    ? TextDirection.rtl // If the language is RTL, use TextDirection.rtl
                    : TextDirection.ltr, // Otherwise, use TextDirection.ltr
                child: OudsTheme(
                  themeContract: themeController.currentTheme,
                  themeMode: themeController.themeMode,
                  onColoredSurface: themeController.onColoredSurface,
                  child: child ?? Container(),
                ),
              );
            },
            home: const MainScreen(),
            // Localization setup
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              OudsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              //use the system language if available
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return Locale('en');
            },
          );
        },
      ),
    );
  }
}
