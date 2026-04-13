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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_theme_orange/orange_font_service.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange_compact/orange_compact_theme.dart';
import 'package:ouds_theme_sosh/ouds_theme_sosh.dart';
import 'package:ouds_theme_wireframe/ouds_theme_wireframe.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  String? fontFamily;

  @override
  void initState() {
    super.initState();
    loadFont();
  }

  void loadFont() {
    fontFamily = OrangeFontService.instance.fontFamily;
    setState(() {});
  }

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
              themeController.currentTheme.colorScheme(context).contentDefault,
              BlendMode.srcIn,
            ),
            child: ExcludeSemantics(
              child: SvgPicture.asset(
                AppAssets.icons.designTheme(themeController),
                colorFilter: ColorFilter.mode(
                    themeController.currentTheme.colorScheme(context).contentDefault,
                    BlendMode.srcIn
                ),
                width: 25,
                height: 25,
                fit: BoxFit.contain,
              ),
            ),
          ),
          onSelected: (String selectedValue) {
            if (selectedValue == OrangeTheme(fontFamily).name) {
              themeController.setTheme(OrangeTheme(fontFamily));
            } else if (selectedValue == OrangeCompactTheme(fontFamily).name) {
              themeController.setTheme(OrangeCompactTheme(fontFamily));
            } else if (selectedValue == SoshTheme().name) {
              themeController.setTheme(SoshTheme());
            } else if (selectedValue == WireframeTheme().name) {
              themeController.setTheme(WireframeTheme());
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              /// Menu Orange
              PopupMenuItem<String>(
                value: OrangeTheme(fontFamily).name,
                child: Semantics(
                  value: currentTheme.runtimeType == OrangeTheme ? context.l10n.app_common_selected_a11y : context.l10n.app_common_unselected_a11y,
                  child: Row(
                    children: [
                      if (currentTheme.runtimeType == OrangeTheme)
                        const Icon(
                          Icons.check,
                          size: 20,
                        ),
                      const SizedBox(width: 10),
                      Text(OrangeTheme(fontFamily).name),
                    ],
                  ),
                ),
              ),

              /// Menu Orange
              PopupMenuItem<String>(
                value: OrangeCompactTheme(fontFamily).name,
                child: Semantics(
                  value: currentTheme.runtimeType == OrangeCompactTheme ? context.l10n.app_common_selected_a11y : context.l10n.app_common_unselected_a11y,
                  child: Row(
                    children: [
                      if (currentTheme.runtimeType == OrangeCompactTheme)
                        const Icon(
                          Icons.check,
                          size: 20,
                        ),
                      const SizedBox(width: 10),
                      Text(OrangeCompactTheme(fontFamily).name),
                    ],
                  ),
                ),
              ),

              /// Menu Sosh
              PopupMenuItem<String>(
                value: SoshTheme().name,
                child: Semantics(
                  value: currentTheme.runtimeType == SoshTheme ? context.l10n.app_common_selected_a11y : context.l10n.app_common_unselected_a11y,
                  child: Row(
                    children: [
                      if (currentTheme.runtimeType == SoshTheme)
                        const Icon(
                          Icons.check,
                          size: 20,
                        ),
                      const SizedBox(width: 10),
                      Text(SoshTheme().name),
                    ],
                  ),
                ),
              ),

              /// Menu Wireframe
              PopupMenuItem<String>(
                value: WireframeTheme().name,
                child: Semantics(
                  value: currentTheme.runtimeType == WireframeTheme ? context.l10n.app_common_selected_a11y : context.l10n.app_common_unselected_a11y,
                  child: Row(
                    children: [
                      if (currentTheme.runtimeType == WireframeTheme)
                        const Icon(
                          Icons.check,
                          size: 20,
                        ),
                      const SizedBox(width: 10),
                      Text(WireframeTheme().name),
                    ],
                  ),
                ),
              ),
            ];
          },
        ),

        /// IconButton to change theme mode (Light/Dark/Auto)
        IconButton(
          icon: Semantics(
            label: context.l10n.app_topBar_theme_button_a11y,
            value: themeMode == ThemeMode.light
                ? context.l10n.app_topBar_darkMode_button_a11y
                : themeMode == ThemeMode.dark
                    ? context.l10n.app_topBar_systemMode_button_a11y
                    : context.l10n.app_topBar_lightMode_button_a11y,
            child: themeMode == ThemeMode.system
                ? ExcludeSemantics(
                    child: SvgPicture.asset(
                      AppAssets.icons.functionalSettingsAndToolsThemeSystem(themeController),
                      colorFilter: ColorFilter.mode(themeController.currentTheme.colorScheme(context).contentDefault, BlendMode.srcIn),
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                  )
                : themeMode == ThemeMode.light
                    ? SvgPicture.asset(
                        AppAssets.icons.functionalSettingsAndToolsUiLightMode(themeController),
              colorFilter: ColorFilter.mode(themeController.currentTheme.colorScheme(context).contentDefault, BlendMode.srcIn),
                        width: 25,
                        height: 25,
                        fit: BoxFit.contain,
                      )
                    : SvgPicture.asset(
                AppAssets.icons.functionalSettingsAndToolsUiDarkMode(themeController),
                colorFilter: ColorFilter.mode(themeController.currentTheme.colorScheme(context).contentDefault, BlendMode.srcIn),
                width: 25,
                height: 25,
                fit: BoxFit.contain
            ),
          ),
          onPressed: () {
            // Toggle between light, dark, and system (auto) modes
            if (themeMode == ThemeMode.light) {
              themeController.setThemeMode(ThemeMode.dark); // Switch to dark mode
            } else if (themeMode == ThemeMode.dark) {
              themeController.setThemeMode(ThemeMode.system); // Switch to system mode (Auto)
            } else {
              themeController.setThemeMode(ThemeMode.light); // Switch to light mode
            }
          },
        )
      ],
    );
  }
}
