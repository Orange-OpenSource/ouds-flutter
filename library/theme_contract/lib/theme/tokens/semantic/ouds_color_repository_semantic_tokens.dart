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
import 'package:ouds_global_raw_tokens/color_raw_tokens.dart';
import 'package:ouds_global_raw_tokens/orange_brand_color_raw_tokens.dart';

class OudsColorRepositorySemanticTokens {
  static const Color repositoryAccentDefaultLight =
      ColorRawTokens.colorFunctionalSun500;
  static const Color repositoryAccentHighestLight =
      OrangeBrandColorRawTokens.colorWarmGray900;
  static const Color repositoryAccentLowLight =
      ColorRawTokens.colorFunctionalSun300;
  static const Color repositoryAccentLowestLight = Color(0xFFF1F1F1);
  static const Color repositoryAccentDefaultDark = Color(0xFFF4A300);

  const OudsColorRepositorySemanticTokens();
}
