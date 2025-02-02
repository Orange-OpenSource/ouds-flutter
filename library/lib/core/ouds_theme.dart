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
import 'package:ouds_theme_contract/theme/ouds_theme_contract.dart';

class OudsTheme extends InheritedWidget {
  final OudsThemeContract themeContract;
  final ThemeMode themeMode;

  static OudsTheme? _instance; // Stocker l'instance

  OudsTheme({
    super.key,
    required this.themeContract,
    required this.themeMode,
    required super.child,
  }) {
    _instance = this; // Mettre à jour l'instance
  }

  // Accès statique au ThemeMode
  static ThemeMode? get themeModeGlobal => _instance?.themeMode;

  static OudsThemeContract of(BuildContext context) {
    final OudsTheme? result =
        context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No OudsTheme found in context!');
    return result!.themeContract;
  }

  static ThemeMode modeOf(BuildContext context) {
    final OudsTheme? result =
        context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    assert(result != null, 'No OudsTheme found in context!');
    return result!.themeMode;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    print('updateShouldNotify called: themeMode: $themeMode');
    return oldWidget is OudsTheme &&
        (oldWidget.themeMode != themeMode ||
            oldWidget.themeContract != themeContract);
  }
}

/*
class OudsTheme extends InheritedWidget {
  final OudsThemeContract themeContract;
  final ThemeMode themeMode;

  const OudsTheme({
    super.key,
    required this.themeContract,
    required this.themeMode,
    required super.child,
  });

  // Accède à la configuration du thème via `OudsTheme.of(context)`
  static OudsThemeContract of(BuildContext context) {
    final OudsTheme? result =
        context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    print(result!.themeContract);
    assert(result != null, 'No OudsTheme found in context!');
    return result!.themeContract;
  }

  static ThemeMode modeOf(BuildContext context) {
    final OudsTheme? result =
        context.dependOnInheritedWidgetOfExactType<OudsTheme>();
    print(result!.themeMode);
    assert(result != null, 'No OudsTheme found in context!');
    return result!.themeMode;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    print('updateShouldNotify called: themeMode: $themeMode');
    return oldWidget is OudsTheme &&
        (oldWidget.themeMode != themeMode ||
            oldWidget.themeContract != themeContract);
  }
}
*/
