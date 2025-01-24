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

import 'package:theme_contract/theme/tokens/ouds_key_tokens.dart';

abstract class OudsColorKeyToken implements OudsKeyToken {}

class OudsColorKeyTokenOpacity extends OudsColorKeyToken {
  OudsColorKeyTokenOpacity._();

  static OudsColorKeyTokenOpacity transparent = OudsColorKeyTokenOpacity._();
  static OudsColorKeyTokenOpacity opaque = OudsColorKeyTokenOpacity._();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
}
