//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class CustomizableSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;

  const CustomizableSwitch({super.key, required this.title, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context, listen: false);

    return SwitchListTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: themeController.currentTheme.fontTokens.sizeBodyLargeMobile,
          fontWeight: themeController.currentTheme.fontTokens.weightLabelStrong,
          letterSpacing: themeController.currentTheme.fontTokens.letterSpacingBodyLargeMobile,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
