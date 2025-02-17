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
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange_country/orange_country_theme.dart';
import 'package:ouds_theme_white_label/white_label_theme.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    final themeMode = themeController.themeMode;

    return Row(
      children: [
        /// Button to change the theme
        PopupMenuButton<String>(
          icon: ColorFiltered(
            colorFilter: ColorFilter.mode(
              themeController
                  .currentTheme.colorsScheme.contentColorDefaultEnabled,
              BlendMode.srcIn,
            ),
            child: Image.asset(
              'assets/ic_palette.png',
              width: 25,
              height: 25,
            ),
          ),
          onSelected: (String selectedValue) {
            if (selectedValue == OrangeTheme(themeMode: themeMode).name) {
              themeController.setTheme(OrangeTheme(themeMode: themeMode));
            } else if (selectedValue ==
                OrangeCountryCustomTheme(themeMode: themeMode).name) {
              themeController
                  .setTheme(OrangeCountryCustomTheme(themeMode: themeMode));
            } else if (selectedValue ==
                WhiteLabelTheme(themeMode: themeMode).name) {
              themeController.setTheme(WhiteLabelTheme(themeMode: themeMode));
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              /// Menu Orange
              PopupMenuItem<String>(
                value: OrangeTheme(themeMode: themeMode).name,
                child: Row(
                  children: [
                    if (currentTheme.runtimeType == OrangeTheme)
                      const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(OrangeTheme(themeMode: themeMode).name),
                  ],
                ),
              ),

              /// Menu OrangeCountryCustom
              PopupMenuItem<String>(
                value: OrangeCountryCustomTheme(themeMode: themeMode).name,
                child: Row(
                  children: [
                    if (currentTheme.runtimeType == OrangeCountryCustomTheme)
                      const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(OrangeCountryCustomTheme(themeMode: themeMode).name),
                  ],
                ),
              ),

              /// Menu WhiteLabel
              PopupMenuItem<String>(
                value: WhiteLabelTheme(themeMode: themeMode).name,
                child: Row(
                  children: [
                    if (currentTheme.runtimeType == WhiteLabelTheme)
                      const Icon(
                        Icons.check,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(WhiteLabelTheme(themeMode: themeMode).name),
                  ],
                ),
              ),
            ];
          },
        ),

        /// IconButton to change theme mode (Light/Dark/Auto)
        IconButton(
          icon: Icon(
              // If the theme mode is 'system', show 'Auto' icon
              themeMode == ThemeMode.system
                  ? Icons.brightness_auto // Auto mode (system theme)
                  : themeMode == ThemeMode.light
                      ? Icons.wb_sunny // Light mode
                      : Icons.nightlight_round, // Dark mode
              size: 28,
              color: themeController
                  .currentTheme.colorsScheme.contentColorDefaultEnabled),
          onPressed: () {
            // Toggle between light, dark, and system (auto) modes
            if (themeMode == ThemeMode.light) {
              themeController
                  .setThemeMode(ThemeMode.dark); // Switch to dark mode
            } else if (themeMode == ThemeMode.dark) {
              themeController.setThemeMode(
                  ThemeMode.system); // Switch to system mode (Auto)
            } else {
              themeController
                  .setThemeMode(ThemeMode.light); // Switch to light mode
            }
          },
        ),
      ],
    );
  }
}
