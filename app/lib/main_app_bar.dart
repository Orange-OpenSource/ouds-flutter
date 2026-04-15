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
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar_action_config.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/dialog/theme_selector_dialog.dart';
import 'package:ouds_flutter_demo/ui/utilities/dialog/theme_settings_dialog.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange_compact/orange_compact_theme.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final String? previousPageTitle;

  const MainAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.previousPageTitle,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final currentTheme = themeController.currentTheme;
    final themeMode = themeController.themeMode;

    return  OudsTopBar(
      title: title,
      translucent: true,
      materialConfig: OudsTopAppBarConfig(centerTitle: false),
      leadingActions: [
        showBackButton
          ? OudsTopBarActionConfig.back(
        previousPageTitle: previousPageTitle,
        onActionPressed: () {
            Navigator.pop(context);
          },
        )
         : OudsTopBarActionConfig.none()
      ],
      trailingActions: [
        /// Button to show the dialog to change the config of rounded corners
        /// only for Orange and Orange Compact themes.
        if(currentTheme.runtimeType == OrangeTheme
            || currentTheme.runtimeType == OrangeCompactTheme)
        OudsTopBarActionConfig.icon(
            contentDescription: context.l10n.app_topBar_themeSettings_button_a11y,
            icon:  AppAssets.icons.functionalNavigationFilters(themeController),
            onActionPressed: () {
              ThemeSettingsDialog.show(context,themeController);
            }
        ),
        OudsTopBarActionConfig.icon(
            contentDescription:  context.l10n.app_topBar_theme_button_a11y,
            icon: AppAssets.icons.designTheme(themeController),
            onActionPressed: (){
              ThemeSelectorDialog.show(context);
            }
        ),
        /// IconButton to change theme mode (Light/Dark/Auto)
        OudsTopBarActionConfig.icon(
          contentDescription:  _getAccessibilityLabelByThemeMode(context, themeMode),
            icon: _getIconByThemeMode(themeController,themeMode),
          onActionPressed: () {
            // Toggle between light, dark, and system (auto) modes
            if (themeMode == ThemeMode.light) {
              themeController.setThemeMode(ThemeMode.dark); // Switch to dark mode
            } else if (themeMode == ThemeMode.dark) {
              themeController.setThemeMode(ThemeMode.system); // Switch to system mode (Auto)
            } else {
              themeController.setThemeMode(ThemeMode.light); // Switch to light mode
            }
          }

        )
      ],
    );
  }

  /// Returns the accessibility (a11y) label for the theme button
  /// based on the current [themeMode].
  String _getAccessibilityLabelByThemeMode(BuildContext context, ThemeMode themeMode){
    return themeMode == ThemeMode.light
        ? context.l10n.app_topBar_darkMode_button_a11y
        : themeMode == ThemeMode.dark
        ? context.l10n.app_topBar_systemMode_button_a11y
        : context.l10n.app_topBar_lightMode_button_a11y;
  }

  /// Returns the appropriate icon path for the theme toggle button
  /// based on the current [themeMode].
  String _getIconByThemeMode(ThemeController themeController, ThemeMode themeMode){
    return themeMode == ThemeMode.system
        ? AppAssets.icons.functionalSettingsAndToolsThemeSystem(themeController)
        : themeMode == ThemeMode.light
        ?  AppAssets.icons.functionalSettingsAndToolsUiLightMode(themeController)
        : AppAssets.icons.functionalSettingsAndToolsUiDarkMode(themeController);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
