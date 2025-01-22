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

import 'package:ouds_flutter/theme-contract/theme/tokens/ouds_key_tokens.dart';

class OudsBorderKeyToken implements OudsKeyToken {
  @override
  String get name => 'OudsBorderKeyToken';
}

// Définir les valeurs possibles pour les tokens de rayon de bordure (Radius)
class OudsBorderRadius {
  static const double none = 0;
  static const double small = 1;
  static const double medium = 2;
  static const double large = 3;
}

// Définir les valeurs possibles pour les tokens de largeur de bordure (Width)
class OudsBorderWidth {
  static const double none = 4;
  static const double defaultWidth = 5;
  static const double medium = 6;
  static const double thick = 7;
}
