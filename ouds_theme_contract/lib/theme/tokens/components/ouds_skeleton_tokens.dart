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
import 'package:ouds_theme_contract/ouds_tokens_provider.dart';

class OudsSkeletonTokens {
  final Color colorBg;
  final Color colorGradientMiddle;
  final Color colorGradientStartEnd;

  OudsSkeletonTokens({
    required OudsProvidersTokens providersTokens,
    Color? colorBg,
    Color? colorGradientMiddle,
    Color? colorGradientStartEnd,
  })  : colorBg = colorBg ??
            providersTokens.colorScheme.backgroundColorDefaultEnabled,
        colorGradientMiddle = colorGradientMiddle ??
            providersTokens.colorScheme.colorBorderDefaultEnabled,
        colorGradientStartEnd = colorGradientStartEnd ??
            providersTokens.colorScheme.contentColorDefaultEnabled;
}
