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
import 'package:ouds_core/ouds_theme.dart';
import 'package:ouds_theme_contract/ouds_theme_mode_provider.dart';

/// Concrete provider implementation for theme mode, ouds_core side.
class OudsThemeModeProviderImpl implements OudsThemeModeProvider {
  @override
  ThemeMode getThemeMode([BuildContext? context]) {
    if (context != null) {
      return OudsTheme.modeOf(context)!;
    }
    return OudsTheme.themeModeGlobal;
  }
}
