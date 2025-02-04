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
import 'package:ouds_global_raw_tokens/dimensions_raw_tokens.dart';
import 'package:ouds_theme_contract/ouds_color_scheme.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_border_semantic_tokens.dart';

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

  OudsButtonTokens({
    required OudsColorScheme colorScheme,
    double? borderRadius,
    double? borderWidthDefault,
    double? borderWidthDefaultInteraction,
    double? borderWidthMinimal,
    double? borderWidthMinimalInteraction,
    Color? colorBgDefaultEnabled,
    Color? colorBgDefaultDisabled,
    Color? colorBgDefaultEnabledMono,
    Color? colorBgDefaultFocus,
    Color? colorBgDefaultFocusMono,
    Color? colorBgDefaultHover,
    Color? colorBgDefaultHoverMono,
    Color? colorBgDefaultLoading,
    Color? colorBgDefaultLoadingMono,
    Color? colorBgDefaultPressed,
    Color? colorBgDefaultPressedMono,
    Color? colorBgMinimalDisabled,
    Color? colorBgMinimalDisabledMono,
    Color? colorBgMinimalEnabled,
    Color? colorBgMinimalEnabledMono,
    Color? colorBgMinimalFocus,
    Color? colorBgMinimalFocusMono,
    Color? colorBgMinimalHover,
    Color? colorBgMinimalHoverMono,
    Color? colorBgMinimalLoading,
    Color? colorBgMinimalLoadingMono,
    Color? colorBgMinimalPressed,
    Color? colorBgMinimalPressedMono,
    Color? colorBgStrongDisabledMono,
    Color? colorBgStrongEnabledMono,
    Color? colorBgStrongFocusMono,
    Color? colorBgStrongHoverMono,
    Color? colorBgStrongLoadingMono,
    Color? colorBgStrongPressedMono,
    Color? colorBorderDefaultDisabled,
    Color? colorBorderDefaultDisabledMono,
    Color? colorBorderDefaultEnabled,
    Color? colorBorderDefaultEnabledMono,
    Color? colorBorderDefaultFocus,
    Color? colorBorderDefaultFocusMono,
    Color? colorBorderDefaultHover,
    Color? colorBorderDefaultHoverMono,
    Color? colorBorderDefaultLoading,
    Color? colorBorderDefaultLoadingMono,
    Color? colorBorderDefaultPressed,
    Color? colorBorderDefaultPressedMono,
    Color? colorBorderMinimalDisabled,
    Color? colorBorderMinimalDisabledMono,
    Color? colorBorderMinimalEnabled,
    Color? colorBorderMinimalEnabledMono,
    Color? colorBorderMinimalFocus,
    Color? colorBorderMinimalFocusMono,
    Color? colorBorderMinimalHover,
    Color? colorBorderMinimalHoverMono,
    Color? colorBorderMinimalLoading,
    Color? colorBorderMinimalLoadingMono,
    Color? colorBorderMinimalPressed,
    Color? colorBorderMinimalPressedMono,
    Color? colorBorderStrongDisabledMono,
    Color? colorBorderStrongEnabledMono,
    Color? colorBorderStrongFocusMono,
    Color? colorBorderStrongHoverMono,
    Color? colorBorderStrongLoadingMono,
    Color? colorBorderStrongPressedMono,
    Color? colorContentDefaultDisabled,
    Color? colorContentDefaultEnabled,
    Color? colorContentDefaultFocus,
    Color? colorContentDefaultFocusMono,
    Color? colorContentDefaultHover,
    Color? colorContentDefaultHoverMono,
    Color? colorContentDefaultLoading,
    Color? colorContentDefaultLoadingMono,
    Color? colorContentDefaultPressed,
    Color? colorContentDefaultPressedMono,
    Color? colorContentMinimalDisabled,
    Color? colorContentMinimalDisabledMono,
    Color? colorContentMinimalFocus,
    Color? colorContentMinimalFocusMono,
    Color? colorContentMinimalHover,
    Color? colorContentMinimalHoverMono,
    Color? colorContentMinimalLoading,
    Color? colorContentMinimalLoadingMono,
    Color? colorContentMinimalPressed,
    Color? colorContentMinimalPressedMono,
    Color? colorContentStrongDisabledMono,
    Color? colorContentStrongEnabledMono,
    Color? colorContentStrongFocusMono,
    Color? colorContentStrongHoverMono,
    Color? colorContentStrongLoadingMono,
    Color? colorContentStrongPressedMono,
    double? sizeIcon,
    double? sizeIconOnly,
    double? sizeLoader,
    double? sizeMaxHeight,
    double? sizeMinHeight,
    double? sizeMinWidth,
    double? spaceColumnGapArrow,
    double? spaceColumnGapIcon,
    double? spaceInsetIconAlone,
    double? spacePaddingBlock,
    double? spacePaddingInlineArrowEnd,
    double? spacePaddingInlineArrowStart,
    double? spacePaddingInlineEndIconStart,
    double? spacePaddingInlineIconNone,
    double? spacePaddingInlineIconStart,
    double? spacePaddingInlineStartIconEnd,
  })  : borderRadius = borderRadius ?? OudsBorderSemanticTokens.radiusDefault,
        borderWidthDefault = OudsBorderSemanticTokens.widthDefault,
        borderWidthDefaultInteraction = borderWidthDefaultInteraction ??
            OudsBorderSemanticTokens.widthFocus,
        borderWidthDefaultInteractionMono = OudsBorderSemanticTokens.widthFocus,
        borderWidthMinimal =
            borderWidthMinimal ?? OudsBorderSemanticTokens.widthThin,
        borderWidthMinimalInteraction =
            borderWidthMinimalInteraction ?? OudsBorderSemanticTokens.widthThin,
        colorBgDefaultEnabled =
            colorBgDefaultEnabled ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultDisabled =
            colorBgDefaultDisabled ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultEnabledMono = colorBgDefaultEnabledMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultFocus =
            colorBgDefaultFocus ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultFocusMono = colorBgDefaultFocusMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultHover =
            colorBgDefaultHover ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultHoverMono = colorBgDefaultHoverMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultLoading =
            colorBgDefaultLoading ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultLoadingMono = colorBgDefaultLoadingMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultPressed =
            colorBgDefaultPressed ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgDefaultPressedMono = colorBgDefaultPressedMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgMinimalDisabled =
            colorBgMinimalDisabled ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgMinimalDisabledMono = colorBgMinimalDisabledMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgMinimalEnabled =
            colorBgMinimalEnabled ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgMinimalEnabledMono = colorBgMinimalEnabledMono ??
            colorScheme.backgroundColorDefaultEnabled,
        colorBgMinimalFocus =
            colorBgMinimalFocus ?? colorScheme.backgroundColorDefaultEnabled,
        colorBgMinimalFocusMono = colorBgMinimalFocusMono ?? Colors.blueGrey,
        colorBgMinimalHover = colorBgMinimalHover ?? Colors.cyan,
        colorBgMinimalHoverMono = colorBgMinimalHoverMono ?? Colors.cyanAccent,
        colorBgMinimalLoading = colorBgMinimalLoading ?? Colors.brown,
        colorBgMinimalLoadingMono = colorBgMinimalLoadingMono ?? Colors.orange,
        colorBgMinimalPressed = colorBgMinimalPressed ?? Colors.pink,
        colorBgMinimalPressedMono =
            colorBgMinimalPressedMono ?? Colors.pinkAccent,
        colorBgStrongDisabledMono = colorBgStrongDisabledMono ?? Colors.indigo,
        colorBgStrongEnabledMono =
            colorBgStrongEnabledMono ?? Colors.indigoAccent,
        colorBgStrongFocusMono = colorBgStrongFocusMono ?? Colors.indigo,
        colorBgStrongHoverMono = colorBgStrongHoverMono ?? Colors.indigoAccent,
        colorBgStrongLoadingMono = colorBgStrongLoadingMono ?? Colors.orange,
        colorBgStrongPressedMono = colorBgStrongPressedMono ?? Colors.orange,
        colorBorderDefaultDisabled = colorBorderDefaultDisabled ?? Colors.red,
        colorBorderDefaultDisabledMono =
            colorBorderDefaultDisabledMono ?? Colors.red,
        colorBorderDefaultEnabled =
            colorBorderDefaultEnabled ?? colorScheme.colorBorderDefaultEnabled,
        colorBorderDefaultEnabledMono =
            colorBorderDefaultEnabledMono ?? Colors.green,
        colorBorderDefaultFocus = colorBorderDefaultFocus ?? Colors.blue,
        colorBorderDefaultFocusMono =
            colorBorderDefaultFocusMono ?? Colors.transparent,
        colorBorderDefaultHover = colorBorderDefaultHover ?? Colors.blue,
        colorBorderDefaultHoverMono =
            colorBorderDefaultHoverMono ?? Colors.transparent,
        colorBorderDefaultLoading = colorBorderDefaultLoading ?? Colors.yellow,
        colorBorderDefaultLoadingMono =
            colorBorderDefaultLoadingMono ?? Colors.transparent,
        colorBorderDefaultPressed = colorBorderDefaultPressed ?? Colors.green,
        colorBorderDefaultPressedMono =
            colorBorderDefaultPressedMono ?? Colors.transparent,
        colorBorderMinimalDisabled =
            colorBorderMinimalDisabled ?? Colors.transparent,
        colorBorderMinimalDisabledMono =
            colorBorderMinimalDisabledMono ?? Colors.transparent,
        colorBorderMinimalEnabled =
            colorBorderMinimalEnabled ?? Colors.transparent,
        colorBorderMinimalEnabledMono =
            colorBorderMinimalEnabledMono ?? Colors.transparent,
        colorBorderMinimalFocus = colorBorderMinimalFocus ?? Colors.transparent,
        colorBorderMinimalFocusMono =
            colorBorderMinimalFocusMono ?? Colors.transparent,
        colorBorderMinimalHover = colorBorderMinimalHover ?? Colors.transparent,
        colorBorderMinimalHoverMono =
            colorBorderMinimalHoverMono ?? Colors.transparent,
        colorBorderMinimalLoading =
            colorBorderMinimalLoading ?? Colors.transparent,
        colorBorderMinimalLoadingMono =
            colorBorderMinimalLoadingMono ?? Colors.transparent,
        colorBorderMinimalPressed =
            colorBorderMinimalPressed ?? Colors.transparent,
        colorBorderMinimalPressedMono =
            colorBorderMinimalPressedMono ?? Colors.transparent,
        colorBorderStrongDisabledMono =
            colorBorderStrongDisabledMono ?? Colors.transparent,
        colorBorderStrongEnabledMono =
            colorBorderStrongEnabledMono ?? Colors.transparent,
        colorBorderStrongFocusMono =
            colorBorderStrongFocusMono ?? Colors.transparent,
        colorBorderStrongHoverMono =
            colorBorderStrongHoverMono ?? Colors.transparent,
        colorBorderStrongLoadingMono =
            colorBorderStrongLoadingMono ?? Colors.transparent,
        colorBorderStrongPressedMono =
            colorBorderStrongPressedMono ?? Colors.transparent,
        colorContentDefaultDisabled =
            colorContentDefaultDisabled ?? Colors.black45,
        colorContentDefaultEnabled = colorContentDefaultEnabled ??
            colorScheme.contentColorDefaultEnabled,
        colorContentDefaultFocus = colorContentDefaultFocus ?? Colors.orange,
        colorContentDefaultFocusMono =
            colorContentDefaultFocusMono ?? Colors.orange,
        colorContentDefaultHover = colorContentDefaultHover ?? Colors.blue,
        colorContentDefaultHoverMono =
            colorContentDefaultHoverMono ?? Colors.blue,
        colorContentDefaultLoading =
            colorContentDefaultLoading ?? Colors.purple,
        colorContentDefaultLoadingMono =
            colorContentDefaultLoadingMono ?? Colors.purple,
        colorContentDefaultPressed = colorContentDefaultPressed ?? Colors.pink,
        colorContentDefaultPressedMono =
            colorContentDefaultPressedMono ?? Colors.pink,
        colorContentMinimalDisabled =
            colorContentMinimalDisabled ?? Colors.green,
        colorContentMinimalDisabledMono =
            colorContentMinimalDisabledMono ?? Colors.green,
        colorContentMinimalFocus = colorContentMinimalFocus ?? Colors.blue,
        colorContentMinimalFocusMono =
            colorContentMinimalFocusMono ?? Colors.blue,
        colorContentMinimalHover = colorContentMinimalHover ?? Colors.teal,
        colorContentMinimalHoverMono =
            colorContentMinimalHoverMono ?? Colors.teal,
        colorContentMinimalLoading = colorContentMinimalLoading ?? Colors.cyan,
        colorContentMinimalLoadingMono =
            colorContentMinimalLoadingMono ?? Colors.cyan,
        colorContentMinimalPressed = colorContentMinimalPressed ?? Colors.pink,
        colorContentMinimalPressedMono =
            colorContentMinimalPressedMono ?? Colors.pink,
        colorContentStrongDisabledMono =
            colorContentStrongDisabledMono ?? Colors.black38,
        colorContentStrongEnabledMono =
            colorContentStrongEnabledMono ?? Colors.white70,
        colorContentStrongFocusMono =
            colorContentStrongFocusMono ?? Colors.orange,
        colorContentStrongHoverMono =
            colorContentStrongHoverMono ?? Colors.orange,
        colorContentStrongLoadingMono =
            colorContentStrongLoadingMono ?? Colors.purple,
        colorContentStrongPressedMono =
            colorContentStrongPressedMono ?? Colors.pink,
        sizeIcon = sizeIcon ?? 16.0,
        sizeIconOnly = sizeIconOnly ?? 20.0,
        sizeLoader = sizeLoader ?? 24.0,
        sizeMaxHeight = sizeMaxHeight ?? DimensionRawTokens.dimension600,
        sizeMinHeight = sizeMinHeight ?? DimensionRawTokens.dimension600,
        sizeMinWidth = sizeMinWidth ?? DimensionRawTokens.dimension600,
        spaceColumnGapArrow = spaceColumnGapArrow ?? 8.0,
        spaceColumnGapIcon = spaceColumnGapIcon ?? 12.0,
        spaceInsetIconAlone = spaceInsetIconAlone ?? 16.0,
        spacePaddingBlock = spacePaddingBlock ?? 12.0,
        spacePaddingInlineArrowEnd = spacePaddingInlineArrowEnd ?? 16.0,
        spacePaddingInlineArrowStart = spacePaddingInlineArrowStart ?? 16.0,
        spacePaddingInlineEndIconStart = spacePaddingInlineEndIconStart ?? 12.0,
        spacePaddingInlineIconNone = spacePaddingInlineIconNone ?? 0.0,
        spacePaddingInlineIconStart = spacePaddingInlineIconStart ?? 12.0,
        spacePaddingInlineStartIconEnd = spacePaddingInlineStartIconEnd ?? 12.0;
}
