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
import 'package:ouds_core/components/radio_button/ouds_radio_button_item.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';
import 'package:ouds_theme_orange/orange_font_service.dart';
import 'package:ouds_theme_orange/orange_theme.dart';
import 'package:ouds_theme_orange_compact/orange_compact_theme.dart';
import 'package:ouds_theme_sosh/ouds_theme_sosh.dart';
import 'package:ouds_theme_wireframe/ouds_theme_wireframe.dart';
import 'package:provider/provider.dart';

/// Enum representing the available theme options.
enum ThemeSelectorOptions { orange, orangeCompact, sosh, wireframe }

/// A dialog that allows the user to select a theme for the application.
class ThemeSelectorDialog extends StatefulWidget {
  const ThemeSelectorDialog({
    super.key,
  });

  /// Displays the [ThemeSelectorDialog].
  ///
  /// This static method provides a convenient way to show the theme selection dialog.
  static void show(
      BuildContext context,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ThemeSelectorDialog();
      },
    );
  }

  @override
  State<ThemeSelectorDialog> createState() =>
      _ThemeSelectorDialogState();
}

/// The state for the [ThemeSelectorDialog].
class _ThemeSelectorDialogState extends State<ThemeSelectorDialog> {
  String? fontFamily;
  late ThemeSelectorOptions _selectedOption;

  @override
  void initState() {
    super.initState();
    loadFont();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the initial selected theme based on the current theme from the ThemeController.
    final themeController = Provider.of<ThemeController>(context, listen: false);
    final currentTheme = themeController.currentTheme;
    if (currentTheme is OrangeCompactTheme) {
      _selectedOption = ThemeSelectorOptions.orangeCompact;
    } else if (currentTheme is SoshTheme) {
      _selectedOption = ThemeSelectorOptions.sosh;
    } else if (currentTheme is WireframeTheme) {
      _selectedOption = ThemeSelectorOptions.wireframe;
    } else {
      _selectedOption = ThemeSelectorOptions.orange;
    }
  }

  /// Loads the font family from the [OrangeFontService].
  void loadFont() {
    fontFamily = OrangeFontService.instance.fontFamily;
  }

  /// Handles the theme change when a radio button is selected.
  void _onThemeChanged(ThemeSelectorOptions? value) {
    if (value == null) return;

    setState(() {
      _selectedOption = value;
    });

    final themeController = Provider.of<ThemeController>(context, listen: false);
    OudsThemeContract theme;
    switch (value) {
      case ThemeSelectorOptions.orange:
        theme = OrangeTheme(fontFamily);
        break;
      case ThemeSelectorOptions.orangeCompact:
        theme = OrangeCompactTheme(fontFamily);
        break;
      case ThemeSelectorOptions.sosh:
        theme = SoshTheme();
        break;
      case ThemeSelectorOptions.wireframe:
        theme = WireframeTheme();
        break;
    }
    themeController.setTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.app_themeDialog_label,
        style: OudsTheme.of(context)
            .typographyTokens
            .typeHeadingMedium(context),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Radio button for the Orange theme.
          OudsRadioButtonItem<ThemeSelectorOptions>(
              title: OrangeTheme(fontFamily).name,
              value: ThemeSelectorOptions.orange,
              groupValue: _selectedOption,
              onChanged: _onThemeChanged,
              reversed: true
          ),
          // Radio button for the Orange Compact theme.
          OudsRadioButtonItem<ThemeSelectorOptions>(
              title: OrangeCompactTheme(fontFamily).name,
              value: ThemeSelectorOptions.orangeCompact,
              groupValue: _selectedOption,
              onChanged: _onThemeChanged,
              reversed: true
          ),
          // Radio button for the Sosh theme.
          OudsRadioButtonItem<ThemeSelectorOptions>(
              title: SoshTheme().name,
              value: ThemeSelectorOptions.sosh,
              groupValue: _selectedOption,
              onChanged: _onThemeChanged,
              reversed: true
          ),
          // Radio button for the Wireframe theme.
          OudsRadioButtonItem<ThemeSelectorOptions>(
              title: WireframeTheme().name,
              value: ThemeSelectorOptions.wireframe,
              groupValue: _selectedOption,
              onChanged: _onThemeChanged,
              reversed: true
          )
        ],
      ),
    );
  }
}