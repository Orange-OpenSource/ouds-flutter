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
import 'package:theme_contract/theme/tokens/semantic/ouds_color_repository_semantic_tokens.dart';

/// Tokens pour les boutons dans le thème OUDS.
class OudsButtonTokens {
  final double borderRadius;
  final double borderWidthDefault;
  final double borderWidthDefaultInteraction;
  final double borderWidthDefaultInteractionMono;
  final double borderWidthMinimal;
  final double borderWidthMinimalInteraction;
  final Color colorBgDefaultDisabled;
  final Color colorBgDefaultDisabledMono;
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
  final Color colorContentDefaultDisabledMono;
  final Color colorContentDefaultEnabled;
  final Color colorContentDefaultEnabledMono;
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

  const OudsButtonTokens({
    this.borderRadius = OudsBorderSemanticTokens.radiusDefault,
    this.borderWidthDefault = OudsBorderSemanticTokens.widthDefault,
    this.borderWidthDefaultInteraction = OudsBorderSemanticTokens.widthFocus,
    this.borderWidthDefaultInteractionMono =
        OudsBorderSemanticTokens.widthFocus,
    this.borderWidthMinimal = OudsBorderSemanticTokens.widthThin,
    this.borderWidthMinimalInteraction = OudsBorderSemanticTokens.widthThin,
    this.colorBgDefaultDisabled =
        Colors.blue, //pointer vers des semantics tokens / ou Raw
    this.colorBgDefaultDisabledMono =
        OudsColorRepositorySemanticTokens.repositoryAccentDefaultDark,
    this.colorBgDefaultEnabled = Colors.grey,
    this.colorBgDefaultEnabledMono = Colors.blueAccent,
    this.colorBgDefaultFocus = Colors.orange,
    this.colorBgDefaultFocusMono = Colors.deepOrange,
    this.colorBgDefaultHover = Colors.green,
    this.colorBgDefaultHoverMono = Colors.greenAccent,
    this.colorBgDefaultLoading = Colors.yellow,
    this.colorBgDefaultLoadingMono = Colors.amber,
    this.colorBgDefaultPressed = Colors.red,
    this.colorBgDefaultPressedMono = Colors.redAccent,
    this.colorBgMinimalDisabled = Colors.purple,
    this.colorBgMinimalDisabledMono = Colors.purpleAccent,
    this.colorBgMinimalEnabled = Colors.teal,
    this.colorBgMinimalEnabledMono = Colors.tealAccent,
    this.colorBgMinimalFocus = Colors.blueGrey,
    this.colorBgMinimalFocusMono = Colors.blueGrey,
    this.colorBgMinimalHover = Colors.cyan,
    this.colorBgMinimalHoverMono = Colors.cyanAccent,
    this.colorBgMinimalLoading = Colors.brown,
    this.colorBgMinimalLoadingMono = Colors.orange,
    this.colorBgMinimalPressed = Colors.pink,
    this.colorBgMinimalPressedMono = Colors.pinkAccent,
    this.colorBgStrongDisabledMono = Colors.indigo,
    this.colorBgStrongEnabledMono = Colors.indigoAccent,
    this.colorBgStrongFocusMono = Colors.indigo,
    this.colorBgStrongHoverMono = Colors.indigoAccent,
    this.colorBgStrongLoadingMono = Colors.orange,
    this.colorBgStrongPressedMono = Colors.orange,
    this.colorBorderDefaultDisabled = Colors.red,
    this.colorBorderDefaultDisabledMono = Colors.red,
    this.colorBorderDefaultEnabled = Colors.green,
    this.colorBorderDefaultEnabledMono = Colors.green,
    this.colorBorderDefaultFocus = Colors.blue,
    this.colorBorderDefaultFocusMono = Colors.transparent,
    this.colorBorderDefaultHover = Colors.blue,
    this.colorBorderDefaultHoverMono = Colors.transparent,
    this.colorBorderDefaultLoading = Colors.yellow,
    this.colorBorderDefaultLoadingMono = Colors.transparent,
    this.colorBorderDefaultPressed = Colors.green,
    this.colorBorderDefaultPressedMono = Colors.transparent,
    this.colorBorderMinimalDisabled = Colors.transparent,
    this.colorBorderMinimalDisabledMono = Colors.transparent,
    this.colorBorderMinimalEnabled = Colors.transparent,
    this.colorBorderMinimalEnabledMono = Colors.transparent,
    this.colorBorderMinimalFocus = Colors.transparent,
    this.colorBorderMinimalFocusMono = Colors.transparent,
    this.colorBorderMinimalHover = Colors.transparent,
    this.colorBorderMinimalHoverMono = Colors.transparent,
    this.colorBorderMinimalLoading = Colors.transparent,
    this.colorBorderMinimalLoadingMono = Colors.transparent,
    this.colorBorderMinimalPressed = Colors.transparent,
    this.colorBorderMinimalPressedMono = Colors.transparent,
    this.colorBorderStrongDisabledMono = Colors.transparent,
    this.colorBorderStrongEnabledMono = Colors.transparent,
    this.colorBorderStrongFocusMono = Colors.transparent,
    this.colorBorderStrongHoverMono = Colors.transparent,
    this.colorBorderStrongLoadingMono = Colors.transparent,
    this.colorBorderStrongPressedMono = Colors.transparent,
    this.colorContentDefaultDisabled = Colors.black45,
    this.colorContentDefaultDisabledMono = Colors.black,
    this.colorContentDefaultEnabled = Colors.white70,
    this.colorContentDefaultEnabledMono = Colors.white,
    this.colorContentDefaultFocus = Colors.orange,
    this.colorContentDefaultFocusMono = Colors.orange,
    this.colorContentDefaultHover = Colors.blue,
    this.colorContentDefaultHoverMono = Colors.blue,
    this.colorContentDefaultLoading = Colors.purple,
    this.colorContentDefaultLoadingMono = Colors.purple,
    this.colorContentDefaultPressed = Colors.pink,
    this.colorContentDefaultPressedMono = Colors.pink,
    this.colorContentMinimalDisabled = Colors.green,
    this.colorContentMinimalDisabledMono = Colors.green,
    this.colorContentMinimalFocus = Colors.blue,
    this.colorContentMinimalFocusMono = Colors.blue,
    this.colorContentMinimalHover = Colors.teal,
    this.colorContentMinimalHoverMono = Colors.teal,
    this.colorContentMinimalLoading = Colors.cyan,
    this.colorContentMinimalLoadingMono = Colors.cyan,
    this.colorContentMinimalPressed = Colors.pink,
    this.colorContentMinimalPressedMono = Colors.pink,
    this.colorContentStrongDisabledMono = Colors.black38,
    this.colorContentStrongEnabledMono = Colors.white70,
    this.colorContentStrongFocusMono = Colors.orange,
    this.colorContentStrongHoverMono = Colors.orange,
    this.colorContentStrongLoadingMono = Colors.purple,
    this.colorContentStrongPressedMono = Colors.pink,
    this.sizeIcon = 16.0,
    this.sizeIconOnly = 20.0,
    this.sizeLoader = 24.0,
    this.sizeMaxHeight = 48.0,
    this.sizeMinHeight = 32.0,
    this.sizeMinWidth = 88.0,
    this.spaceColumnGapArrow = 8.0,
    this.spaceColumnGapIcon = 12.0,
    this.spaceInsetIconAlone = 16.0,
    this.spacePaddingBlock = 12.0,
    this.spacePaddingInlineArrowEnd = 16.0,
    this.spacePaddingInlineArrowStart = 16.0,
    this.spacePaddingInlineEndIconStart = 12.0,
    this.spacePaddingInlineIconNone = 0.0,
    this.spacePaddingInlineIconStart = 12.0,
    this.spacePaddingInlineStartIconEnd = 12.0,
  });
}
