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
import 'package:theme_contract/theme/ouds_theme_contract.dart';

/// Core theme wrapper that applies a theme based on [OudsThemeContract]
class OudsTheme extends InheritedWidget {
  final OudsThemeContract theme;

  const OudsTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  static OudsThemeContract of(BuildContext context) {
    final OudsTheme? result =
        context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No OudsTheme found in context!');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(OudsTheme oldWidget) => theme != oldWidget.theme;
}

/// Function to apply the chosen theme to the application.
OudsTheme applyOudsTheme({
  required OudsThemeContract themeContract,
  required Widget child,
}) {
  return OudsTheme(
    theme: themeContract,
    child: MaterialApp(
      theme: themeContract.themeData,
      home: child,
    ),
  );
}
