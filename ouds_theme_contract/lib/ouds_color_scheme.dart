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

import 'package:flutter/material.dart';
import 'package:ouds_core/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

/// [OudsColorScheme] is a utility class that provides color scheme configurations based on the OUDS theme.
/// It determines the appropriate colors (background, border, etc.) based on the current theme mode (light or dark).
/// The class uses [OudsColorSemanticTokens] to access specific color tokens and adjusts the color values accordingly
/// for different states (enabled, disabled, hover, pressed).
/// It supports both system-defined theme modes and custom light/dark modes for the app.

class OudsColorScheme {
  final OudsColorSemanticTokens colorTokens;
  final BuildContext context;

  OudsColorScheme({
    required this.colorTokens,
    required this.context,
  });

  /// Returns `true` if the current theme is dark.
  ///
  /// If the theme mode is `system`, this checks the platform's brightness.
  /// Otherwise, it returns `true` only if the mode is explicitly `dark`.
  bool get isDarkTheme {
    final themeMode = OudsTheme.modeOf(context);
    if (themeMode == ThemeMode.system) {
      final systemBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return systemBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  /// Color - Opacity
  Color get opacityLowest => isDarkTheme ? colorTokens.opacityColorTokens.opacityLowestDark : colorTokens.opacityColorTokens.opacityLowestLight;

  Color get opacityLower => isDarkTheme ? colorTokens.opacityColorTokens.opacityLowerDark : colorTokens.opacityColorTokens.opacityLowerLight;

  Color get opacityTransparent => isDarkTheme ? colorTokens.opacityColorTokens.opacityTransparentDark : colorTokens.opacityColorTokens.opacityTransparentLight;

  /// Color - Action
  Color get actionDisabled => isDarkTheme ? colorTokens.actionColorTokens.actionDisabledDark : colorTokens.actionColorTokens.actionDisabledLight;

  Color get actionEnabled => isDarkTheme ? colorTokens.actionColorTokens.actionEnabledDark : colorTokens.actionColorTokens.actionEnabledLight;

  Color get actionFocus => isDarkTheme ? colorTokens.actionColorTokens.actionFocusDark : colorTokens.actionColorTokens.actionFocusLight;

  Color get actionHighlighted => isDarkTheme ? colorTokens.actionColorTokens.actionHighlightedDark : colorTokens.actionColorTokens.actionHighlightedLight;

  Color get actionHover => isDarkTheme ? colorTokens.actionColorTokens.actionHoverDark : colorTokens.actionColorTokens.actionHoverLight;

  Color get actionLoading => isDarkTheme ? colorTokens.actionColorTokens.actionLoadingDark : colorTokens.actionColorTokens.actionLoadingLight;

  Color get actionNegativeEnabled => isDarkTheme ? colorTokens.actionColorTokens.actionNegativeEnabledDark : colorTokens.actionColorTokens.actionNegativeEnabledLight;

  Color get actionNegativeFocus => isDarkTheme ? colorTokens.actionColorTokens.actionNegativeFocusDark : colorTokens.actionColorTokens.actionNegativeFocusLight;

  Color get actionNegativeHover => isDarkTheme ? colorTokens.actionColorTokens.actionNegativeHoverDark : colorTokens.actionColorTokens.actionNegativeHoverLight;

  Color get actionNegativeLoading => isDarkTheme ? colorTokens.actionColorTokens.actionNegativeLoadingDark : colorTokens.actionColorTokens.actionNegativeLoadingLight;

  Color get actionNegativePressed => isDarkTheme ? colorTokens.actionColorTokens.actionNegativePressedDark : colorTokens.actionColorTokens.actionNegativePressedLight;

  Color get actionPressed => isDarkTheme ? colorTokens.actionColorTokens.actionPressedDark : colorTokens.actionColorTokens.actionPressedLight;

  Color get actionSelected => isDarkTheme ? colorTokens.actionColorTokens.actionSelectedDark : colorTokens.actionColorTokens.actionSelectedLight;

  Color get actionSupportEnabled => isDarkTheme ? colorTokens.actionColorTokens.actionSupportEnabledDark : colorTokens.actionColorTokens.actionSupportEnabledLight;

  Color get actionSupportFocus => isDarkTheme ? colorTokens.actionColorTokens.actionSupportFocusDark : colorTokens.actionColorTokens.actionSupportFocusLight;

  Color get actionSupportHover => isDarkTheme ? colorTokens.actionColorTokens.actionSupportHoverDark : colorTokens.actionColorTokens.actionSupportHoverLight;

  Color get actionSupportLoading => isDarkTheme ? colorTokens.actionColorTokens.actionSupportLoadingDark : colorTokens.actionColorTokens.actionSupportLoadingLight;

  Color get actionSupportPressed => isDarkTheme ? colorTokens.actionColorTokens.actionSupportPressedDark : colorTokens.actionColorTokens.actionSupportPressedLight;

  Color get actionVisited => isDarkTheme ? colorTokens.actionColorTokens.actionVisitedDark : colorTokens.actionColorTokens.actionVisitedLight;

  /// Color - Always
  Color get alwaysBlack => isDarkTheme ? colorTokens.alwaysColorTokens.alwaysBlackDark : colorTokens.alwaysColorTokens.alwaysBlackLight;

  Color get alwaysOnBlack => isDarkTheme ? colorTokens.alwaysColorTokens.alwaysOnBlackDark : colorTokens.alwaysColorTokens.alwaysOnBlackLight;

  Color get alwaysOnWhite => isDarkTheme ? colorTokens.alwaysColorTokens.alwaysOnWhiteDark : colorTokens.alwaysColorTokens.alwaysOnWhiteLight;

  Color get alwaysWhite => isDarkTheme ? colorTokens.alwaysColorTokens.alwaysWhiteDark : colorTokens.alwaysColorTokens.alwaysWhiteLight;

  /// Color - Background
  Color get bgEmphasized => isDarkTheme ? colorTokens.backgroundColorTokens.bgEmphasizedDark : colorTokens.backgroundColorTokens.bgEmphasizedLight;

  Color get bgPrimary => isDarkTheme ? colorTokens.backgroundColorTokens.bgPrimaryDark : colorTokens.backgroundColorTokens.bgPrimaryLight;

  Color get bgSecondary => isDarkTheme ? colorTokens.backgroundColorTokens.bgSecondaryDark : colorTokens.backgroundColorTokens.bgSecondaryLight;

  Color get bgTertiary => isDarkTheme ? colorTokens.backgroundColorTokens.bgTertiaryDark : colorTokens.backgroundColorTokens.bgTertiaryLight;

  /// Color - Border
  Color get borderBrandPrimary => isDarkTheme ? colorTokens.borderColorTokens.borderBrandPrimaryDark : colorTokens.borderColorTokens.borderBrandPrimaryLight;

  Color get borderDefault => isDarkTheme ? colorTokens.borderColorTokens.borderDefaultDark : colorTokens.borderColorTokens.borderDefaultLight;

  Color get borderEmphasized => isDarkTheme ? colorTokens.borderColorTokens.borderEmphasizedDark : colorTokens.borderColorTokens.borderEmphasizedLight;

  Color get borderFocus => isDarkTheme ? colorTokens.borderColorTokens.borderFocusDark : colorTokens.borderColorTokens.borderFocusLight;

  Color get borderFocusInset => isDarkTheme ? colorTokens.borderColorTokens.borderFocusInsetDark : colorTokens.borderColorTokens.borderFocusInsetLight;

  Color get borderMuted => isDarkTheme ? colorTokens.borderColorTokens.borderMutedDark : colorTokens.borderColorTokens.borderMutedLight;

  Color get borderOnBrandPrimary => isDarkTheme ? colorTokens.borderColorTokens.borderOnBrandPrimaryDark : colorTokens.borderColorTokens.borderOnBrandPrimaryLight;

  /// Color - Content
  Color get contentBrandPrimary => isDarkTheme ? colorTokens.contentColorTokens.contentBrandPrimaryDark : colorTokens.contentColorTokens.contentBrandPrimaryLight;

  Color get contentDefault => isDarkTheme ? colorTokens.contentColorTokens.contentDefaultDark : colorTokens.contentColorTokens.contentDefaultLight;

  Color get contentDisabled => isDarkTheme ? colorTokens.contentColorTokens.contentDisabledDark : colorTokens.contentColorTokens.contentDisabledLight;

  Color get contentMuted => isDarkTheme ? colorTokens.contentColorTokens.contentMutedDark : colorTokens.contentColorTokens.contentMutedLight;

  Color get contentOnActionDisabled => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionDisabledDark : colorTokens.contentColorTokens.contentOnActionDisabledLight;

  Color get contentOnActionEnabled => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionEnabledDark : colorTokens.contentColorTokens.contentOnActionEnabledLight;

  Color get contentOnActionFocus => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionFocusDark : colorTokens.contentColorTokens.contentOnActionFocusLight;

  Color get contentOnActionHighlighted => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionHighlightedDark : colorTokens.contentColorTokens.contentOnActionHighlightedLight;

  Color get contentOnActionHover => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionHoverDark : colorTokens.contentColorTokens.contentOnActionHoverLight;

  Color get contentOnActionLoading => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionLoadingDark : colorTokens.contentColorTokens.contentOnActionLoadingLight;

  Color get contentOnActionPressed => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionPressedDark : colorTokens.contentColorTokens.contentOnActionPressedLight;

  Color get contentOnBrandPrimary => isDarkTheme ? colorTokens.contentColorTokens.contentOnBrandPrimaryDark : colorTokens.contentColorTokens.contentOnBrandPrimaryLight;

  Color get contentOnOverlayEmphasized => isDarkTheme ? colorTokens.contentColorTokens.contentOnOverlayEmphasizedDark : colorTokens.contentColorTokens.contentOnOverlayEmphasizedLight;

  Color get contentOnStatusEmphasized => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusEmphasizedDark : colorTokens.contentColorTokens.contentOnStatusEmphasizedLight;

  Color get contentOnStatusEmphasizedAlt => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusEmphasizedAltDark : colorTokens.contentColorTokens.contentOnStatusEmphasizedAltLight;

  Color get contentOnStatusMuted => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusMutedDark : colorTokens.contentColorTokens.contentOnStatusMutedLight;

  Color get contentStatusInfo => isDarkTheme ? colorTokens.contentColorTokens.contentStatusInfoDark : colorTokens.contentColorTokens.contentStatusInfoLight;

  Color get contentStatusNegative => isDarkTheme ? colorTokens.contentColorTokens.contentStatusNegativeDark : colorTokens.contentColorTokens.contentStatusNegativeLight;

  Color get contentStatusPositive => isDarkTheme ? colorTokens.contentColorTokens.contentStatusPositiveDark : colorTokens.contentColorTokens.contentStatusPositiveLight;

  Color get contentStatusWarning => isDarkTheme ? colorTokens.contentColorTokens.contentStatusWarningDark : colorTokens.contentColorTokens.contentStatusWarningLight;

  /// Color - Overlay
  Color get overlayDefault => isDarkTheme ? colorTokens.overlayColorTokens.overlayDefaultDark : colorTokens.overlayColorTokens.overlayDefaultLight;

  Color get overlayDrag => isDarkTheme ? colorTokens.overlayColorTokens.overlayDragDark : colorTokens.overlayColorTokens.overlayDragLight;

  Color get overlayEmphasized => isDarkTheme ? colorTokens.overlayColorTokens.overlayEmphasizedDark : colorTokens.overlayColorTokens.overlayEmphasizedLight;

  Color get overlayModal => isDarkTheme ? colorTokens.overlayColorTokens.overlayModalDark : colorTokens.overlayColorTokens.overlayModalLight;

  /// Color - Surface
  Color get surfaceBrandPrimary => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceBrandPrimaryDark : colorTokens.surfaceColorTokens.surfaceBrandPrimaryLight;

  Color get surfaceStatusAccentEmphasized => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusAccentEmphasizedDark : colorTokens.surfaceColorTokens.surfaceStatusAccentEmphasizedLight;

  Color get surfaceStatusAccentMuted => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusAccentMutedDark : colorTokens.surfaceColorTokens.surfaceStatusAccentMutedLight;

  Color get surfaceStatusInfoEmphasized => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusInfoEmphasizedDark : colorTokens.surfaceColorTokens.surfaceStatusInfoEmphasizedLight;

  Color get surfaceStatusInfoMuted => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusInfoMutedDark : colorTokens.surfaceColorTokens.surfaceStatusInfoMutedLight;

  Color get surfaceStatusNegativeEmphasized => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusNegativeEmphasizedDark : colorTokens.surfaceColorTokens.surfaceStatusNegativeEmphasizedLight;

  Color get surfaceStatusNegativeMuted => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusNegativeMutedDark : colorTokens.surfaceColorTokens.surfaceStatusNegativeMutedLight;

  Color get surfaceStatusNeutralEmphasized => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusNeutralEmphasizedDark : colorTokens.surfaceColorTokens.surfaceStatusNeutralEmphasizedLight;

  Color get surfaceStatusNeutralMuted => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusNeutralMutedDark : colorTokens.surfaceColorTokens.surfaceStatusNeutralMutedLight;

  Color get surfaceStatusPositiveEmphasized => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusPositiveEmphasizedDark : colorTokens.surfaceColorTokens.surfaceStatusPositiveEmphasizedLight;

  Color get surfaceStatusPositiveMuted => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusPositiveMutedDark : colorTokens.surfaceColorTokens.surfaceStatusPositiveMutedLight;

  Color get surfaceStatusWarningEmphasized => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusWarningEmphasizedDark : colorTokens.surfaceColorTokens.surfaceStatusWarningEmphasizedLight;

  Color get surfaceStatusWarningMuted => isDarkTheme ? colorTokens.surfaceColorTokens.surfaceStatusWarningMutedDark : colorTokens.surfaceColorTokens.surfaceStatusWarningMutedLight;

  /// Color - Decorative
  Color get decorativeAccent1Default => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent1DefaultDark : colorTokens.decorativeColorTokens.decorativeAccent1DefaultLight;

  Color get decorativeAccent1Emphasized => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent1EmphasizedDark : colorTokens.decorativeColorTokens.decorativeAccent1EmphasizedLight;

  Color get decorativeAccent1Muted => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent1MutedDark : colorTokens.decorativeColorTokens.decorativeAccent1MutedLight;

  Color get decorativeAccent2Default => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent2DefaultDark : colorTokens.decorativeColorTokens.decorativeAccent2DefaultLight;

  Color get decorativeAccent2Emphasized => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent2EmphasizedDark : colorTokens.decorativeColorTokens.decorativeAccent2EmphasizedLight;

  Color get decorativeAccent2Muted => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent2MutedDark : colorTokens.decorativeColorTokens.decorativeAccent2MutedLight;

  Color get decorativeAccent3Default => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent3DefaultDark : colorTokens.decorativeColorTokens.decorativeAccent3DefaultLight;

  Color get decorativeAccent3Emphasized => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent3EmphasizedDark : colorTokens.decorativeColorTokens.decorativeAccent3EmphasizedLight;

  Color get decorativeAccent3Muted => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent3MutedDark : colorTokens.decorativeColorTokens.decorativeAccent3MutedLight;

  Color get decorativeAccent4Default => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent4DefaultDark : colorTokens.decorativeColorTokens.decorativeAccent4DefaultLight;

  Color get decorativeAccent4Emphasized => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent4EmphasizedDark : colorTokens.decorativeColorTokens.decorativeAccent4EmphasizedLight;

  Color get decorativeAccent4Muted => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent4MutedDark : colorTokens.decorativeColorTokens.decorativeAccent4MutedLight;

  Color get decorativeAccent5Default => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent5DefaultDark : colorTokens.decorativeColorTokens.decorativeAccent5DefaultLight;

  Color get decorativeAccent5Emphasized => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent5EmphasizedDark : colorTokens.decorativeColorTokens.decorativeAccent5EmphasizedLight;

  Color get decorativeAccent5Muted => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeAccent5MutedDark : colorTokens.decorativeColorTokens.decorativeAccent5MutedLight;

  Color get decorativeBrandPrimary => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeBrandPrimaryDark : colorTokens.decorativeColorTokens.decorativeBrandPrimaryLight;

  Color get decorativeBrandSecondary => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeBrandSecondaryDark : colorTokens.decorativeColorTokens.decorativeBrandSecondaryLight;

  Color get decorativeBrandTertiary => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeBrandTertiaryDark : colorTokens.decorativeColorTokens.decorativeBrandTertiaryLight;

  Color get decorativeSkinTint100 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint100Dark : colorTokens.decorativeColorTokens.decorativeSkinTint100Light;

  Color get decorativeSkinTint200 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint200Dark : colorTokens.decorativeColorTokens.decorativeSkinTint200Light;

  Color get decorativeSkinTint300 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint300Dark : colorTokens.decorativeColorTokens.decorativeSkinTint300Light;

  Color get decorativeSkinTint400 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint400Dark : colorTokens.decorativeColorTokens.decorativeSkinTint400Light;

  Color get decorativeSkinTint500 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint500Dark : colorTokens.decorativeColorTokens.decorativeSkinTint500Light;

  Color get decorativeSkinTint600 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint600Dark : colorTokens.decorativeColorTokens.decorativeSkinTint600Light;

  Color get decorativeSkinTint700 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint700Dark : colorTokens.decorativeColorTokens.decorativeSkinTint700Light;

  Color get decorativeSkinTint800 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint800Dark : colorTokens.decorativeColorTokens.decorativeSkinTint800Light;

  Color get decorativeSkinTint900 => isDarkTheme ? colorTokens.decorativeColorTokens.decorativeSkinTint900Dark : colorTokens.decorativeColorTokens.decorativeSkinTint900Light;

  Color get colorDecorativeNeutralEmphasizedHigher {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedHigherDark : colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedHigherLight;
  }

  Color get colorDecorativeNeutralEmphasizedLow {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowDark : colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowLight;
  }

  Color get colorDecorativeNeutralEmphasizedLower {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowerDark : colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowerLight;
  }

  Color get colorDecorativeNeutralEmphasizedLowest {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowestDark : colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowestLight;
  }

  Color get colorDecorativeNeutralMutedHigh {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedHighDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedHighLight;
  }

  Color get colorDecorativeNeutralMutedHigher {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedHigherDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedHigherLight;
  }

  Color get colorDecorativeNeutralMutedHighest {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedHighestDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedHighestLight;
  }

  Color get colorDecorativeNeutralMutedLow {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedLowDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedLowLight;
  }

  Color get colorDecorativeNeutralMutedLower {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedLowerDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedLowerLight;
  }

  Color get colorDecorativeNeutralMutedLowest {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedLowestDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedLowestLight;
  }

  Color get colorDecorativeNeutralMutedMedium {
    return isDarkTheme ? colorTokens.decorativeColorTokens.decorativeNeutralMutedMediumDark : colorTokens.decorativeColorTokens.decorativeNeutralMutedMediumLight;
  }

  /// Color - Repository

  Color get repositoryAccentDefault => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryAccentDefaultDark : colorTokens.repositoryColorTokens.repositoryAccentDefaultLight;

  Color get repositoryAccentHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryAccentHighestDark : colorTokens.repositoryColorTokens.repositoryAccentHighestLight;

  Color get repositoryAccentLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryAccentLowDark : colorTokens.repositoryColorTokens.repositoryAccentLowLight;

  Color get repositoryAccentLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryAccentLowestDark : colorTokens.repositoryColorTokens.repositoryAccentLowestLight;

  Color get repositoryInfoDefault => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryInfoDefaultDark : colorTokens.repositoryColorTokens.repositoryInfoDefaultLight;

  Color get repositoryInfoHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryInfoHighestDark : colorTokens.repositoryColorTokens.repositoryInfoHighestLight;

  Color get repositoryInfoLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryInfoLowDark : colorTokens.repositoryColorTokens.repositoryInfoLowLight;

  Color get repositoryInfoLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryInfoLowestDark : colorTokens.repositoryColorTokens.repositoryInfoLowestLight;

  Color get repositoryNegativeDefault => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeDefaultDark : colorTokens.repositoryColorTokens.repositoryNegativeDefaultLight;

  Color get repositoryNegativeHigh => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeHighDark : colorTokens.repositoryColorTokens.repositoryNegativeHighLight;

  Color get repositoryNegativeHigher => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeHigherDark : colorTokens.repositoryColorTokens.repositoryNegativeHigherLight;

  Color get repositoryNegativeHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeHighestDark : colorTokens.repositoryColorTokens.repositoryNegativeHighestLight;

  Color get repositoryNegativeLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeLowDark : colorTokens.repositoryColorTokens.repositoryNegativeLowLight;

  Color get repositoryNegativeLower => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeLowerDark : colorTokens.repositoryColorTokens.repositoryNegativeLowerLight;

  Color get repositoryNegativeLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNegativeLowestDark : colorTokens.repositoryColorTokens.repositoryNegativeLowestLight;

  Color get repositoryNeutralEmphasizedBlack =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedBlackDark : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedBlackLight;

  Color get repositoryNeutralEmphasizedHigh =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighDark : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighLight;

  Color get repositoryNeutralEmphasizedHigher =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHigherDark : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHigherLight;

  Color get repositoryNeutralEmphasizedHighest =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighestDark : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighestLight;

  Color get repositoryNeutralEmphasizedMedium =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedMediumDark : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedMediumLight;

  Color get repositoryNeutralMutedLower => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralMutedLowerDark : colorTokens.repositoryColorTokens.repositoryNeutralMutedLowerLight;

  Color get repositoryNeutralMutedLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralMutedLowestDark : colorTokens.repositoryColorTokens.repositoryNeutralMutedLowestLight;

  Color get repositoryNeutralMutedWhite => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryNeutralMutedWhiteDark : colorTokens.repositoryColorTokens.repositoryNeutralMutedWhiteLight;

  Color get repositoryOpacityBlackHigh => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackHighDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackHighLight;

  Color get repositoryOpacityBlackHigher => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackHigherDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackHigherLight;

  Color get repositoryOpacityBlackHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackHighestDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackHighestLight;

  Color get repositoryOpacityBlackLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackLowDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackLowLight;

  Color get repositoryOpacityBlackLower => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackLowerDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackLowerLight;

  Color get repositoryOpacityBlackLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackLowestDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackLowestLight;

  Color get repositoryOpacityBlackMedium => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumLight;

  Color get repositoryOpacityBlackMediumLow =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumLowDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumLowLight;

  Color get repositoryOpacityBlackMediumHigh =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumHighDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumHighLight;

  Color get repositoryOpacityBlackTransparent =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityBlackTransparentDark : colorTokens.repositoryColorTokens.repositoryOpacityBlackTransparentLight;

  Color get repositoryOpacityInfo => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityInfoDark : colorTokens.repositoryColorTokens.repositoryOpacityInfoLight;

  Color get repositoryOpacityNegative => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityNegativeDark : colorTokens.repositoryColorTokens.repositoryOpacityNegativeLight;

  Color get repositoryOpacityPositive => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityPositiveDark : colorTokens.repositoryColorTokens.repositoryOpacityPositiveLight;

  Color get repositoryOpacityWarning => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWarningDark : colorTokens.repositoryColorTokens.repositoryOpacityWarningLight;

  Color get repositoryOpacityWhiteHigh => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighLight;

  Color get repositoryOpacityWhiteHigher => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteHigherDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteHigherLight;

  Color get repositoryOpacityWhiteHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighestDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighestLight;

  Color get repositoryOpacityWhiteMedium => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumLight;

  Color get repositoryOpacityWhiteMediumLow =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumLowDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumLowLight;

  Color get repositoryOpacityWhiteLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowLight;

  Color get repositoryOpacityWhiteLower => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowerDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowerLight;

  Color get repositoryOpacityWhiteLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowestDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowestLight;

  Color get repositoryOpacityWhiteTransparent =>
      isDarkTheme ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteTransparentDark : colorTokens.repositoryColorTokens.repositoryOpacityWhiteTransparentLight;

  Color get repositoryPositiveDefault => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPositiveDefaultDark : colorTokens.repositoryColorTokens.repositoryPositiveDefaultLight;

  Color get repositoryPositiveHigh => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPositiveHighDark : colorTokens.repositoryColorTokens.repositoryPositiveHighLight;

  Color get repositoryPositiveHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPositiveHighestDark : colorTokens.repositoryColorTokens.repositoryPositiveHighestLight;

  Color get repositoryPositiveLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPositiveLowDark : colorTokens.repositoryColorTokens.repositoryPositiveLowLight;

  Color get repositoryPositiveLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPositiveLowestDark : colorTokens.repositoryColorTokens.repositoryPositiveLowestLight;

  Color get repositoryPrimaryDefault => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPrimaryDefaultDark : colorTokens.repositoryColorTokens.repositoryPrimaryDefaultLight;

  Color get repositoryPrimaryLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryPrimaryLowDark : colorTokens.repositoryColorTokens.repositoryPrimaryLowLight;

  Color get repositoryWarningDefault => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryWarningDefaultDark : colorTokens.repositoryColorTokens.repositoryWarningDefaultLight;

  Color get repositoryWarningHighest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryWarningHighestDark : colorTokens.repositoryColorTokens.repositoryWarningHighestLight;

  Color get repositoryWarningLow => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryWarningLowDark : colorTokens.repositoryColorTokens.repositoryWarningLowLight;

  Color get repositoryWarningLowest => isDarkTheme ? colorTokens.repositoryColorTokens.repositoryWarningLowestDark : colorTokens.repositoryColorTokens.repositoryWarningLowestLight;
}
