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
import 'package:flutter_gen/gen_l10n/ouds_flutter_app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ouds_flutter/core/ouds_theme.dart';
import 'package:ouds_flutter_demo/ui/main_screen.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
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
            title: 'OUDS Demo App',
            theme: themeController.themeData,
            darkTheme: themeController.currentTheme.darkThemeData,
            themeMode: themeController.themeMode,
            home: OudsTheme(
              themeContract: themeController.currentTheme,
              themeMode: themeController.themeMode,
              child: const MainScreen(),
            ),
            debugShowCheckedModeBanner: false,
            // Localization setup
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}

/*
    return MaterialApp(
      title: 'OUDS Demo App',
      theme: OrangeTheme().themeData,
      //home: const MainScreen(),
      home: OudsTheme(
        theme: OrangeTheme(),
        child: MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
      // Localization setup
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
 */
