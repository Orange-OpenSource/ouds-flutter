//
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

// Tokens version 0.11.0
// Generated by Tokenator

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';
import 'package:ouds_global_raw_tokens/dimension_raw_tokens.dart';

class OudsControlItemTokens {
  final Color colorBgFocus;
  final Color colorBgHover;
  final Color colorBgLoading;
  final Color colorBgPressed;
  final Color colorContentLoader;
  final double sizeIcon;
  final double sizeListItemSizeMinHeightText;
  final double sizeLoader;
  final double sizeMaxHeightAssetsContainer;
  final double sizeMinHeight;
  final double sizeMinWidth;
  final double spaceColumnGap;
  final double spaceInset;
  final double spaceRowGap;

  OudsControlItemTokens({
    required OudsProvidersTokens providersTokens,
    Color? colorBgFocus,
    Color? colorBgHover,
    Color? colorBgLoading,
    Color? colorBgPressed,
    Color? colorContentLoader,
    double? sizeIcon,
    double? sizeListItemSizeMinHeightText,
    double? sizeLoader,
    double? sizeMaxHeightAssetsContainer,
    double? sizeMinHeight,
    double? sizeMinWidth,
    double? spaceColumnGap,
    double? spaceInset,
    double? spaceRowGap
  }) :
    colorBgFocus = colorBgFocus ?? providersTokens.colorScheme.actionSupportFocus,
    colorBgHover = colorBgHover ?? providersTokens.colorScheme.actionSupportHover,
    colorBgLoading = colorBgLoading ?? providersTokens.colorScheme.actionSupportLoading,
    colorBgPressed = colorBgPressed ?? providersTokens.colorScheme.actionSupportPressed,
    colorContentLoader = colorContentLoader ?? providersTokens.colorScheme.contentDefault,
    sizeIcon = sizeIcon ?? providersTokens.sizeTokens.iconWithLabelLargeSizeMd,
    sizeListItemSizeMinHeightText = sizeListItemSizeMinHeightText ?? providersTokens.sizeTokens.iconWithLabelLargeSizeMd,
    sizeLoader = sizeLoader ?? providersTokens.sizeTokens.iconWithLabelLargeSizeSm,
    sizeMaxHeightAssetsContainer = sizeMaxHeightAssetsContainer ?? DimensionRawTokens.dimension1200,
    sizeMinHeight = sizeMinHeight ?? DimensionRawTokens.dimension650,
    sizeMinWidth = sizeMinWidth ?? DimensionRawTokens.dimension2000,
    spaceColumnGap = spaceColumnGap ?? providersTokens.spaceTokens.columnGapTall,
    spaceInset = spaceInset ?? providersTokens.spaceTokens.insetMedium,
    spaceRowGap = spaceRowGap ?? providersTokens.spaceTokens.rowGapNone;
}
