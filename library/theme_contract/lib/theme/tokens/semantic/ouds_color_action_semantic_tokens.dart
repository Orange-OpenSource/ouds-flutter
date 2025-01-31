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

class OudsColorActionSemanticTokens {
  final Color actionDisabledLight;
  final Color actionEnabledLight;
  final Color actionFocusLight;
  final Color actionHighlightedLight;
  final Color actionHoverLight;
  final Color actionLoadingLight;
  final Color actionDisabledDark;

  const OudsColorActionSemanticTokens({
    this.actionDisabledLight = ColorRawTokens.colorFunctionalBlack,
    this.actionEnabledLight = ColorRawTokens.colorFunctionalBlack,
    this.actionFocusLight = ColorRawTokens.colorOpacityBlack680,
    this.actionHighlightedLight = ColorRawTokens.colorFunctionalBlack,
    this.actionHoverLight = ColorRawTokens.colorOpacityBlack680,
    this.actionLoadingLight = OrangeBrandColorRawTokens.colorOrange550,
    this.actionDisabledDark = ColorRawTokens.colorOpacityWhite200,
  });
}
