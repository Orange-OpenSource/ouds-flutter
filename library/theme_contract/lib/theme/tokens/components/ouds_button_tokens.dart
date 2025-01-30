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
import 'package:theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';
import 'package:theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

class OudsButtonTokens {
  final double borderRadius;
  final double borderWidthDefault;
  final double borderWidthDefaultInteraction;
  final double borderWidthDefaultInteractionMono;
  final double borderWidthMinimal;
  final double borderWidthMinimalInteraction;
  final Color colorBgDefaultDisabled;
  final Color colorBgDefaultEnabled;
  final Color colorBgDefaultEnabledMono;
  final Color colorBgDefaultFocus;
  final Color colorBgDefaultFocusMono;
  final Color colorBgDefaultHover;
  final Color colorBgDefaultHoverMono;
  final Color colorBgDefaultLoading;
  final Color colorBgDefaultLoadingMono;
  final Color colorBgDefaultPressed;
  final Color colorBgDefaultPressedMono;
  final Color colorBgMinimalDisabled;
  final Color colorBgMinimalDisabledMono;
  final Color colorBgMinimalEnabled;
  final Color colorBgMinimalEnabledMono;
  final Color colorBgMinimalFocus;
  final Color colorBgMinimalFocusMono;
  final Color colorBgMinimalHover;
  final Color colorBgMinimalHoverMono;
  final Color colorBgMinimalLoading;
  final Color colorBgMinimalLoadingMono;
  final Color colorBgMinimalPressed;
  final Color colorBgMinimalPressedMono;
  final Color colorBgStrongDisabledMono;
  final Color colorBgStrongEnabledMono;
  final Color colorBgStrongFocusMono;
  final Color colorBgStrongHoverMono;
  final Color colorBgStrongLoadingMono;
  final Color colorBgStrongPressedMono;
  final Color colorBorderDefaultDisabled;
  final Color colorBorderDefaultDisabledMono;
  final Color colorBorderDefaultEnabled;
  final Color colorBorderDefaultEnabledMono;
  final Color colorBorderDefaultFocus;
  final Color colorBorderDefaultFocusMono;
  final Color colorBorderDefaultHover;
  final Color colorBorderDefaultHoverMono;
  final Color colorBorderDefaultLoading;
  final Color colorBorderDefaultLoadingMono;
  final Color colorBorderDefaultPressed;
  final Color colorBorderDefaultPressedMono;
  final Color colorBorderMinimalDisabled;
  final Color colorBorderMinimalDisabledMono;
  final Color colorBorderMinimalEnabled;
  final Color colorBorderMinimalEnabledMono;
  final Color colorBorderMinimalFocus;
  final Color colorBorderMinimalFocusMono;
  final Color colorBorderMinimalHover;
  final Color colorBorderMinimalHoverMono;
  final Color colorBorderMinimalLoading;
  final Color colorBorderMinimalLoadingMono;
  final Color colorBorderMinimalPressed;
  final Color colorBorderMinimalPressedMono;
  final Color colorBorderStrongDisabledMono;
  final Color colorBorderStrongEnabledMono;
  final Color colorBorderStrongFocusMono;
  final Color colorBorderStrongHoverMono;
  final Color colorBorderStrongLoadingMono;
  final Color colorBorderStrongPressedMono;
  final Color colorContentDefaultDisabled;
  final Color colorContentDefaultEnabled;
  final Color colorContentDefaultFocus;
  final Color colorContentDefaultFocusMono;
  final Color colorContentDefaultHover;
  final Color colorContentDefaultHoverMono;
  final Color colorContentDefaultLoading;
  final Color colorContentDefaultLoadingMono;
  final Color colorContentDefaultPressed;
  final Color colorContentDefaultPressedMono;
  final Color colorContentMinimalDisabled;
  final Color colorContentMinimalDisabledMono;
  final Color colorContentMinimalFocus;
  final Color colorContentMinimalFocusMono;
  final Color colorContentMinimalHover;
  final Color colorContentMinimalHoverMono;
  final Color colorContentMinimalLoading;
  final Color colorContentMinimalLoadingMono;
  final Color colorContentMinimalPressed;
  final Color colorContentMinimalPressedMono;
  final Color colorContentStrongDisabledMono;
  final Color colorContentStrongEnabledMono;
  final Color colorContentStrongFocusMono;
  final Color colorContentStrongHoverMono;
  final Color colorContentStrongLoadingMono;
  final Color colorContentStrongPressedMono;
  final double sizeIcon;
  final double sizeIconOnly;
  final double sizeLoader;
  final double sizeMaxHeight;
  final double sizeMinHeight;
  final double sizeMinWidth;
  final double spaceColumnGapArrow;
  final double spaceColumnGapIcon;
  final double spaceInsetIconAlone;
  final double spacePaddingBlock;
  final double spacePaddingInlineArrowEnd;
  final double spacePaddingInlineArrowStart;
  final double spacePaddingInlineEndIconStart;
  final double spacePaddingInlineIconNone;
  final double spacePaddingInlineIconStart;
  final double spacePaddingInlineStartIconEnd;

  OudsButtonTokens({required OudsColorSemanticTokens colorTokens})
      : borderRadius = OudsBorderSemanticTokens.radiusDefault,
        borderWidthDefault = OudsBorderSemanticTokens.widthDefault,
        borderWidthDefaultInteraction = OudsBorderSemanticTokens.widthFocus,
        borderWidthDefaultInteractionMono = OudsBorderSemanticTokens.widthFocus,
        borderWidthMinimal = OudsBorderSemanticTokens.widthThin,
        borderWidthMinimalInteraction = OudsBorderSemanticTokens.widthThin,
        colorBgDefaultEnabled =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultDisabled =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultEnabledMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultFocus =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultFocusMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultHover =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultHoverMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultLoading =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultLoadingMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultPressed =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgDefaultPressedMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgMinimalDisabled =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgMinimalDisabledMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgMinimalEnabled =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgMinimalEnabledMono =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgMinimalFocus =
            colorTokens.backgroundColorTokens.bgSecondaryLight,
        colorBgMinimalFocusMono = Colors.blueGrey,
        colorBgMinimalHover = Colors.cyan,
        colorBgMinimalHoverMono = Colors.cyanAccent,
        colorBgMinimalLoading = Colors.brown,
        colorBgMinimalLoadingMono = Colors.orange,
        colorBgMinimalPressed = Colors.pink,
        colorBgMinimalPressedMono = Colors.pinkAccent,
        colorBgStrongDisabledMono = Colors.indigo,
        colorBgStrongEnabledMono = Colors.indigoAccent,
        colorBgStrongFocusMono = Colors.indigo,
        colorBgStrongHoverMono = Colors.indigoAccent,
        colorBgStrongLoadingMono = Colors.orange,
        colorBgStrongPressedMono = Colors.orange,
        colorBorderDefaultDisabled = Colors.red,
        colorBorderDefaultDisabledMono = Colors.red,
        colorBorderDefaultEnabled = Colors.green,
        colorBorderDefaultEnabledMono = Colors.green,
        colorBorderDefaultFocus = Colors.blue,
        colorBorderDefaultFocusMono = Colors.transparent,
        colorBorderDefaultHover = Colors.blue,
        colorBorderDefaultHoverMono = Colors.transparent,
        colorBorderDefaultLoading = Colors.yellow,
        colorBorderDefaultLoadingMono = Colors.transparent,
        colorBorderDefaultPressed = Colors.green,
        colorBorderDefaultPressedMono = Colors.transparent,
        colorBorderMinimalDisabled = Colors.transparent,
        colorBorderMinimalDisabledMono = Colors.transparent,
        colorBorderMinimalEnabled = Colors.transparent,
        colorBorderMinimalEnabledMono = Colors.transparent,
        colorBorderMinimalFocus = Colors.transparent,
        colorBorderMinimalFocusMono = Colors.transparent,
        colorBorderMinimalHover = Colors.transparent,
        colorBorderMinimalHoverMono = Colors.transparent,
        colorBorderMinimalLoading = Colors.transparent,
        colorBorderMinimalLoadingMono = Colors.transparent,
        colorBorderMinimalPressed = Colors.transparent,
        colorBorderMinimalPressedMono = Colors.transparent,
        colorBorderStrongDisabledMono = Colors.transparent,
        colorBorderStrongEnabledMono = Colors.transparent,
        colorBorderStrongFocusMono = Colors.transparent,
        colorBorderStrongHoverMono = Colors.transparent,
        colorBorderStrongLoadingMono = Colors.transparent,
        colorBorderStrongPressedMono = Colors.transparent,
        colorContentDefaultDisabled = Colors.black45,
        colorContentDefaultEnabled =
            colorTokens.backgroundColorTokens.bgSecondaryDark,
        colorContentDefaultFocus = Colors.orange,
        colorContentDefaultFocusMono = Colors.orange,
        colorContentDefaultHover = Colors.blue,
        colorContentDefaultHoverMono = Colors.blue,
        colorContentDefaultLoading = Colors.purple,
        colorContentDefaultLoadingMono = Colors.purple,
        colorContentDefaultPressed = Colors.pink,
        colorContentDefaultPressedMono = Colors.pink,
        colorContentMinimalDisabled = Colors.green,
        colorContentMinimalDisabledMono = Colors.green,
        colorContentMinimalFocus = Colors.blue,
        colorContentMinimalFocusMono = Colors.blue,
        colorContentMinimalHover = Colors.teal,
        colorContentMinimalHoverMono = Colors.teal,
        colorContentMinimalLoading = Colors.cyan,
        colorContentMinimalLoadingMono = Colors.cyan,
        colorContentMinimalPressed = Colors.pink,
        colorContentMinimalPressedMono = Colors.pink,
        colorContentStrongDisabledMono = Colors.black38,
        colorContentStrongEnabledMono = Colors.white70,
        colorContentStrongFocusMono = Colors.orange,
        colorContentStrongHoverMono = Colors.orange,
        colorContentStrongLoadingMono = Colors.purple,
        colorContentStrongPressedMono = Colors.pink,
        sizeIcon = 16.0,
        sizeIconOnly = 20.0,
        sizeLoader = 24.0,
        sizeMaxHeight = 48.0,
        sizeMinHeight = 32.0,
        sizeMinWidth = 88.0,
        spaceColumnGapArrow = 8.0,
        spaceColumnGapIcon = 12.0,
        spaceInsetIconAlone = 16.0,
        spacePaddingBlock = 12.0,
        spacePaddingInlineArrowEnd = 16.0,
        spacePaddingInlineArrowStart = 16.0,
        spacePaddingInlineEndIconStart = 12.0,
        spacePaddingInlineIconNone = 0.0,
        spacePaddingInlineIconStart = 12.0,
        spacePaddingInlineStartIconEnd = 12.0;
}
