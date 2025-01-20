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
import 'package:ouds_flutter/theme-orange/orange_theme.dart';
import 'package:ouds_flutter/theme-white-label/white_label_theme.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final isOrangeTheme = themeController.currentTheme is OrangeTheme;

    return PopupMenuButton<String>(
      icon: Image.asset(
        'assets/ic_palette.png',
        width: 25,
        height: 25,
      ),
      onSelected: (String selectedValue) {
        if (selectedValue == 'Orange') {
          themeController.setTheme(OrangeTheme());
        } else if (selectedValue == 'WhiteLabel') {
          themeController.setTheme(WhiteLabelTheme());
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          // Menu Orange
          PopupMenuItem<String>(
            value: 'Orange',
            child: Row(
              children: [
                if (isOrangeTheme)
                  const Icon(
                    Icons.check,
                    size: 20,
                  ),
                const SizedBox(width: 10),
                const Text('Orange'),
              ],
            ),
          ),
          // Menu WhiteLabel
          PopupMenuItem<String>(
            value: 'WhiteLabel',
            child: Row(
              children: [
                if (!isOrangeTheme)
                  const Icon(
                    Icons.check,
                    size: 20,
                  ),
                const SizedBox(width: 10),
                const Text('White Label'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
