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

/// Abstraction to provide the current theme mode.
abstract class OudsThemeModeProvider {
  /// Returns the global or current [ThemeMode].
  ThemeMode getThemeMode([BuildContext? context]);
}
