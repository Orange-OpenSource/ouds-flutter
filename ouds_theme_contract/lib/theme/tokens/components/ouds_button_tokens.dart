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
import 'package:ouds_global_raw_tokens/dimension_raw_tokens.dart';
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';

class OudsButtonTokens {
  final double borderRadius;
  final double borderWidthDefault;
  final Color colorBgDefaultEnabled;
  final Color colorBorderDefaultEnabled;
  final Color colorContentDefaultEnabled;
  final double sizeMaxHeight;
  final double sizeMinHeight;
  final double sizeMinWidth;

  OudsButtonTokens({
    required OudsProvidersTokens providersTokens,
    double? borderRadius,
    double? borderWidthDefault,
    Color? colorBgDefaultEnabled,
    Color? colorBorderDefaultEnabled,
    Color? colorContentDefaultEnabled,
    double? sizeMaxHeight,
    double? sizeMinHeight,
    double? sizeMinWidth,
  })  : borderRadius =
            borderRadius ?? providersTokens.borderTokens.radiusDefault,
        borderWidthDefault =
            borderWidthDefault ?? providersTokens.borderTokens.widthDefault,
        colorBgDefaultEnabled = colorBgDefaultEnabled ??
            providersTokens.colorScheme.backgroundColorDefaultEnabled,
        colorBorderDefaultEnabled = colorBorderDefaultEnabled ??
            providersTokens.colorScheme.colorBorderDefaultEnabled,
        colorContentDefaultEnabled = colorContentDefaultEnabled ??
            providersTokens.colorScheme.contentColorDefaultEnabled,
        sizeMaxHeight = DimensionRawTokens.dimension600,
        sizeMinHeight = DimensionRawTokens.dimension600,
        sizeMinWidth = DimensionRawTokens.dimension600;
}
