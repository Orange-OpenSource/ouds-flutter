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

class OudsTheme {
  OudsTheme._();

  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: const Color(0xfff16e00),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed: const Color(0xffff7900),
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
