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
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

/// [OudsColorScheme] is a utility class that provides color scheme configurations based on the OUDS theme.
/// It determines the appropriate colors (background, border, etc.) based on the current theme mode (light or dark).
/// The class uses [OudsColorSemanticTokens] to access specific color tokens and adjusts the color values accordingly
/// for different states (enabled, disabled, hover, pressed).
/// It supports both system-defined theme modes and custom light/dark modes for the app.

class OudsColorScheme {
  final OudsColorSemanticTokens colorTokens;
  final bool isDarkTheme;

  OudsColorScheme({
    required this.colorTokens,
    required this.isDarkTheme,
  });

  /// Creates an [OudsColorScheme] based on the current theme mode.
  ///
  /// Determines whether the theme is dark or light using the provided [BuildContext],
  /// taking into account system settings if [ThemeMode.system] is active.
  ///
  /// [colorTokens] defines the semantic color values to be used.
  ///
  /// This ensures the correct color scheme is applied depending on the active theme.
  factory OudsColorScheme.fromContext({
    required BuildContext context,
    required OudsColorSemanticTokens colorTokens,
  }) {
    final themeMode = OudsTheme.modeOf(context);
    final isDark = themeMode == ThemeMode.system ? WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark : themeMode == ThemeMode.dark;

    return OudsColorScheme(colorTokens: colorTokens, isDarkTheme: isDark);
  }

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
  Color get alwaysBlack => colorTokens.alwaysColorTokens.alwaysBlack;

  Color get alwaysOnBlack => colorTokens.alwaysColorTokens.alwaysOnBlack;

  Color get alwaysOnWhite => colorTokens.alwaysColorTokens.alwaysOnWhite;

  Color get alwaysWhite => colorTokens.alwaysColorTokens.alwaysWhite;

  /// Color - Background
  Color get bgEmphasized => isDarkTheme ? colorTokens.backgroundColorTokens.bgEmphasizedDark : colorTokens.backgroundColorTokens.bgEmphasizedLight;

  Color get bgPrimary => isDarkTheme ? colorTokens.backgroundColorTokens.bgPrimaryDark : colorTokens.backgroundColorTokens.bgPrimaryLight;

  Color get bgSecondary => isDarkTheme ? colorTokens.backgroundColorTokens.bgSecondaryDark : colorTokens.backgroundColorTokens.bgSecondaryLight;

  Color get bgTertiary => isDarkTheme ? colorTokens.backgroundColorTokens.bgTertiaryDark : colorTokens.backgroundColorTokens.bgTertiaryLight;

  /// Color - Border
  Color get borderBrandPrimary => isDarkTheme ? colorTokens.borderColorTokens.borderBrandPrimaryDark : colorTokens.borderColorTokens.borderBrandPrimaryLight;

  Color get borderBrandSecondary => isDarkTheme ? colorTokens.borderColorTokens.borderBrandSecondaryDark : colorTokens.borderColorTokens.borderBrandSecondaryLight;

  Color get borderBrandTertiary => isDarkTheme ? colorTokens.borderColorTokens.borderBrandTertiaryDark : colorTokens.borderColorTokens.borderBrandTertiaryLight;

  Color get borderDefault => isDarkTheme ? colorTokens.borderColorTokens.borderDefaultDark : colorTokens.borderColorTokens.borderDefaultLight;

  Color get borderEmphasized => isDarkTheme ? colorTokens.borderColorTokens.borderEmphasizedDark : colorTokens.borderColorTokens.borderEmphasizedLight;

  Color get borderFocus => isDarkTheme ? colorTokens.borderColorTokens.borderFocusDark : colorTokens.borderColorTokens.borderFocusLight;

  Color get borderFocusInset => isDarkTheme ? colorTokens.borderColorTokens.borderFocusInsetDark : colorTokens.borderColorTokens.borderFocusInsetLight;

  Color get borderMuted => isDarkTheme ? colorTokens.borderColorTokens.borderMutedDark : colorTokens.borderColorTokens.borderMutedLight;

  Color get borderOnBrandPrimary => isDarkTheme ? colorTokens.borderColorTokens.borderOnBrandPrimaryDark : colorTokens.borderColorTokens.borderOnBrandPrimaryLight;

  Color get borderOnBrandSecondary => isDarkTheme ? colorTokens.borderColorTokens.borderOnBrandSecondaryDark : colorTokens.borderColorTokens.borderOnBrandSecondaryDark;

  Color get borderOnBrandTertiary => isDarkTheme ? colorTokens.borderColorTokens.borderOnBrandTertiaryDark : colorTokens.borderColorTokens.borderOnBrandTertiaryDark;

  /// Color - Content
  Color get contentBrandPrimary => isDarkTheme ? colorTokens.contentColorTokens.contentBrandPrimaryDark : colorTokens.contentColorTokens.contentBrandPrimaryLight;

  Color get contentBrandSecondary => isDarkTheme ? colorTokens.contentColorTokens.contentBrandSecondaryDark : colorTokens.contentColorTokens.contentBrandSecondaryLight;

  Color get contentBrandTertiary => isDarkTheme ? colorTokens.contentColorTokens.contentBrandTertiaryDark : colorTokens.contentColorTokens.contentBrandTertiaryLight;

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

  Color get contentOnActionSelected => isDarkTheme ? colorTokens.contentColorTokens.contentOnActionSelectedDark : colorTokens.contentColorTokens.contentOnActionSelectedLight;

  Color get contentOnBrandPrimary => isDarkTheme ? colorTokens.contentColorTokens.contentOnBrandPrimaryDark : colorTokens.contentColorTokens.contentOnBrandPrimaryLight;

  Color get contentOnBrandSecondary => isDarkTheme ? colorTokens.contentColorTokens.contentBrandSecondaryDark : colorTokens.contentColorTokens.contentBrandSecondaryLight;

  Color get contentOnBrandTertiary => isDarkTheme ? colorTokens.contentColorTokens.contentOnBrandTertiaryDark : colorTokens.contentColorTokens.contentOnBrandTertiaryLight;

  Color get contentOnOverlayEmphasized => isDarkTheme ? colorTokens.contentColorTokens.contentOnOverlayEmphasizedDark : colorTokens.contentColorTokens.contentOnOverlayEmphasizedLight;

  Color get contentOnStatusNeutralEmphasized =>
      isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusNeutralEmphasizedDark : colorTokens.contentColorTokens.contentOnStatusNeutralEmphasizedLight;

  Color get contentOnStatusNeutralMuted => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusNeutralMutedDark : colorTokens.contentColorTokens.contentOnStatusNeutralMutedLight;

  Color get contentOnStatusPositiveEmphasized =>
      isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusPositiveEmphasizedDark : colorTokens.contentColorTokens.contentOnStatusPositiveEmphasizedLight;

  Color get contentOnStatusPositiveMuted => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusPositiveMutedDark : colorTokens.contentColorTokens.contentOnStatusPositiveMutedLight;

  Color get contentOnStatusInfoEmphasized => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusInfoEmphasizedDark : colorTokens.contentColorTokens.contentOnStatusInfoEmphasizedLight;

  Color get contentOnStatusInfoMuted => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusInfoMutedDark : colorTokens.contentColorTokens.contentOnStatusInfoMutedLight;

  Color get contentOnStatusNegativeEmphasized =>
      isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusNegativeEmphasizedDark : colorTokens.contentColorTokens.contentOnStatusNegativeEmphasizedLight;

  Color get contentOnStatusNegativeMuted => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusNegativeMutedDark : colorTokens.contentColorTokens.contentOnStatusNegativeMutedLight;

  Color get contentOnStatusAccentEmphasized => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusAccentEmphasizedDark : colorTokens.contentColorTokens.contentOnStatusAccentEmphasizedLight;

  Color get contentOnStatusAccentMuted => isDarkTheme ? colorTokens.contentColorTokens.contentOnStatusAccentMutedDark : colorTokens.contentColorTokens.contentOnStatusAccentMutedLight;

  Color get contentStatusAccent => isDarkTheme ? colorTokens.contentColorTokens.contentStatusAccentDark : colorTokens.contentColorTokens.contentStatusAccentLight;

  Color get contentStatusInfo => isDarkTheme ? colorTokens.contentColorTokens.contentStatusInfoDark : colorTokens.contentColorTokens.contentStatusInfoLight;

  Color get contentStatusNegative => isDarkTheme ? colorTokens.contentColorTokens.contentStatusNegativeDark : colorTokens.contentColorTokens.contentStatusNegativeLight;

  Color get contentStatusPositive => isDarkTheme ? colorTokens.contentColorTokens.contentStatusPositiveDark : colorTokens.contentColorTokens.contentStatusPositiveLight;

  Color get contentStatusWarning => isDarkTheme ? colorTokens.contentColorTokens.contentStatusWarningDark : colorTokens.contentColorTokens.contentStatusWarningLight;

  /// Color - Decorative
  Color get decorativeAccent1Default => colorTokens.decorativeColorTokens.decorativeAccent1Default;

  Color get decorativeAccent1Emphasized => colorTokens.decorativeColorTokens.decorativeAccent1Emphasized;

  Color get decorativeAccent1Muted => colorTokens.decorativeColorTokens.decorativeAccent1Muted;

  Color get decorativeAccent2Default => colorTokens.decorativeColorTokens.decorativeAccent2Default;

  Color get decorativeAccent2Emphasized => colorTokens.decorativeColorTokens.decorativeAccent2Emphasized;

  Color get decorativeAccent2Muted => colorTokens.decorativeColorTokens.decorativeAccent2Muted;

  Color get decorativeAccent3Default => colorTokens.decorativeColorTokens.decorativeAccent3Default;

  Color get decorativeAccent3Emphasized => colorTokens.decorativeColorTokens.decorativeAccent3Emphasized;

  Color get decorativeAccent3Muted => colorTokens.decorativeColorTokens.decorativeAccent3Muted;

  Color get decorativeAccent4Default => colorTokens.decorativeColorTokens.decorativeAccent4Default;

  Color get decorativeAccent4Emphasized => colorTokens.decorativeColorTokens.decorativeAccent4Emphasized;

  Color get decorativeAccent4Muted => colorTokens.decorativeColorTokens.decorativeAccent4Muted;

  Color get decorativeAccent5Default => colorTokens.decorativeColorTokens.decorativeAccent5Default;

  Color get decorativeAccent5Emphasized => colorTokens.decorativeColorTokens.decorativeAccent5Emphasized;

  Color get decorativeAccent5Muted => colorTokens.decorativeColorTokens.decorativeAccent5Muted;

  Color get decorativeBrandPrimaryEmphasized => colorTokens.decorativeColorTokens.decorativeBrandPrimaryEmphasized;

  Color get decorativeBrandPrimaryMuted => colorTokens.decorativeColorTokens.decorativeBrandPrimaryMuted;

  Color get decorativeBrandPrimary => colorTokens.decorativeColorTokens.decorativeBrandPrimary;

  Color get decorativeBrandSecondary => colorTokens.decorativeColorTokens.decorativeBrandSecondary;

  Color get decorativeBrandEmphasized => colorTokens.decorativeColorTokens.decorativeBrandSecondaryEmphasized;

  Color get decorativeBrandMuted => colorTokens.decorativeColorTokens.decorativeBrandSecondaryMuted;

  Color get decorativeBrandTertiary => colorTokens.decorativeColorTokens.decorativeBrandTertiary;

  Color get decorativeBrandTertiaryEmphasized => colorTokens.decorativeColorTokens.decorativeBrandTertiaryEmphasized;

  Color get decorativeBrandTertiaryMuted => colorTokens.decorativeColorTokens.decorativeBrandTertiaryMuted;

  Color get decorativeNeutralEmphasizedHigh => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedHigh;

  Color get decorativeNeutralEmphasizedHigher => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedHigher;

  Color get decorativeNeutralEmphasizedHighest => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedHighest;

  Color get decorativeNeutralEmphasizedLow => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLow;

  Color get decorativeNeutralEmphasizedLower => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLower;

  Color get decorativeNeutralEmphasizedLowest => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLowest;

  Color get decorativeNeutralEmphasizedMedium => colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedMedium;

  Color get decorativeNeutralMutedHigh => colorTokens.decorativeColorTokens.decorativeNeutralMutedHigh;

  Color get decorativeNeutralMutedHigher => colorTokens.decorativeColorTokens.decorativeNeutralMutedHigher;

  Color get decorativeNeutralMutedHighest => colorTokens.decorativeColorTokens.decorativeNeutralMutedHighest;

  Color get decorativeNeutralMutedLower => colorTokens.decorativeColorTokens.decorativeNeutralMutedLower;

  Color get decorativeNeutralMutedLowest => colorTokens.decorativeColorTokens.decorativeNeutralMutedLowest;

  Color get decorativeNeutralMutedLow => colorTokens.decorativeColorTokens.decorativeNeutralMutedLow;

  Color get decorativeNeutralMutedMedium => colorTokens.decorativeColorTokens.decorativeNeutralMutedMedium;

  Color get decorativeSkinTint100 => colorTokens.decorativeColorTokens.decorativeSkinTint100;

  Color get decorativeSkinTint200 => colorTokens.decorativeColorTokens.decorativeSkinTint200;

  Color get decorativeSkinTint300 => colorTokens.decorativeColorTokens.decorativeSkinTint300;

  Color get decorativeSkinTint400 => colorTokens.decorativeColorTokens.decorativeSkinTint400;

  Color get decorativeSkinTint500 => colorTokens.decorativeColorTokens.decorativeSkinTint500;

  Color get decorativeSkinTint600 => colorTokens.decorativeColorTokens.decorativeSkinTint600;

  Color get decorativeSkinTint700 => colorTokens.decorativeColorTokens.decorativeSkinTint700;

  Color get decorativeSkinTint800 => colorTokens.decorativeColorTokens.decorativeSkinTint800;

  Color get decorativeSkinTint900 => colorTokens.decorativeColorTokens.decorativeSkinTint900;

  /// Color - Opacity
  Color get opacityLowest => isDarkTheme ? colorTokens.opacityColorTokens.opacityLowestDark : colorTokens.opacityColorTokens.opacityLowestLight;

  Color get opacityLower => isDarkTheme ? colorTokens.opacityColorTokens.opacityLowerDark : colorTokens.opacityColorTokens.opacityLowerLight;

  Color get opacityTransparent => isDarkTheme ? colorTokens.opacityColorTokens.opacityTransparentDark : colorTokens.opacityColorTokens.opacityTransparentLight;

  /// Color - Overlay
  Color get overlayDefault => isDarkTheme ? colorTokens.overlayColorTokens.overlayDefaultDark : colorTokens.overlayColorTokens.overlayDefaultLight;

  Color get overlayDrag => isDarkTheme ? colorTokens.overlayColorTokens.overlayDragDark : colorTokens.overlayColorTokens.overlayDragLight;

  Color get overlayEmphasized => isDarkTheme ? colorTokens.overlayColorTokens.overlayEmphasizedDark : colorTokens.overlayColorTokens.overlayEmphasizedLight;

  Color get overlayModal => isDarkTheme ? colorTokens.overlayColorTokens.overlayModalDark : colorTokens.overlayColorTokens.overlayModalLight;

  /// Color - Repository

  Color get repositoryAccentDefault => colorTokens.repositoryColorTokens.repositoryAccentDefault;

  Color get repositoryAccentHighest => colorTokens.repositoryColorTokens.repositoryAccentHighest;

  Color get repositoryAccentLow => colorTokens.repositoryColorTokens.repositoryAccentLow;

  Color get repositoryAccentLowest => colorTokens.repositoryColorTokens.repositoryAccentLowest;

  Color get repositoryInfoDefault => colorTokens.repositoryColorTokens.repositoryInfoDefault;

  Color get repositoryInfoHighest => colorTokens.repositoryColorTokens.repositoryInfoHighest;

  Color get repositoryInfoLow => colorTokens.repositoryColorTokens.repositoryInfoLow;

  Color get repositoryInfoLowest => colorTokens.repositoryColorTokens.repositoryInfoLowest;

  Color get repositoryNegativeDefault => colorTokens.repositoryColorTokens.repositoryNegativeDefault;

  Color get repositoryNegativeHigh => colorTokens.repositoryColorTokens.repositoryNegativeHigh;

  Color get repositoryNegativeHigher => colorTokens.repositoryColorTokens.repositoryNegativeHigher;

  Color get repositoryNegativeHighest => colorTokens.repositoryColorTokens.repositoryNegativeHighest;

  Color get repositoryNegativeLow => colorTokens.repositoryColorTokens.repositoryNegativeLow;

  Color get repositoryNegativeLower => colorTokens.repositoryColorTokens.repositoryNegativeLower;

  Color get repositoryNegativeLowest => colorTokens.repositoryColorTokens.repositoryNegativeLowest;

  Color get repositoryNeutralEmphasizedBlack => colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedBlack;

  Color get repositoryNeutralEmphasizedHigh => colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHigh;

  Color get repositoryNeutralEmphasizedHigher => colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHigher;

  Color get repositoryNeutralEmphasizedHighest => colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighest;

  Color get repositoryNeutralEmphasizedMedium => colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedMedium;

  Color get repositoryNeutralMutedLower => colorTokens.repositoryColorTokens.repositoryNeutralMutedLower;

  Color get repositoryNeutralMutedLowest => colorTokens.repositoryColorTokens.repositoryNeutralMutedLowest;

  Color get repositoryNeutralMutedWhite => colorTokens.repositoryColorTokens.repositoryNeutralMutedWhite;

  Color get repositoryOpacityBlackHigh => colorTokens.repositoryColorTokens.repositoryOpacityBlackHigh;

  Color get repositoryOpacityBlackHigher => colorTokens.repositoryColorTokens.repositoryOpacityBlackHigher;

  Color get repositoryOpacityBlackHighest => colorTokens.repositoryColorTokens.repositoryOpacityBlackHighest;

  Color get repositoryOpacityBlackLow => colorTokens.repositoryColorTokens.repositoryOpacityBlackLow;

  Color get repositoryOpacityBlackLower => colorTokens.repositoryColorTokens.repositoryOpacityBlackLower;

  Color get repositoryOpacityBlackLowest => colorTokens.repositoryColorTokens.repositoryOpacityBlackLowest;

  Color get repositoryOpacityBlackMedium => colorTokens.repositoryColorTokens.repositoryOpacityBlackMedium;

  Color get repositoryOpacityBlackMediumLow => colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumLow;

  Color get repositoryOpacityBlackMediumHigh => colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumHigh;

  Color get repositoryOpacityBlackTransparent => colorTokens.repositoryColorTokens.repositoryOpacityBlackTransparent;

  Color get repositoryOpacityInfo => colorTokens.repositoryColorTokens.repositoryOpacityInfo;

  Color get repositoryOpacityNegative => colorTokens.repositoryColorTokens.repositoryOpacityNegative;

  Color get repositoryOpacityPositive => colorTokens.repositoryColorTokens.repositoryOpacityPositive;

  Color get repositoryOpacityWarning => colorTokens.repositoryColorTokens.repositoryOpacityWarning;

  Color get repositoryOpacityWhiteHigh => colorTokens.repositoryColorTokens.repositoryOpacityWhiteHigh;

  Color get repositoryOpacityWhiteHigher => colorTokens.repositoryColorTokens.repositoryOpacityWhiteHigher;

  Color get repositoryOpacityWhiteHighest => colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighest;

  Color get repositoryOpacityWhiteMedium => colorTokens.repositoryColorTokens.repositoryOpacityWhiteMedium;

  Color get repositoryOpacityWhiteMediumLow => colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumLow;

  Color get repositoryOpacityWhiteLow => colorTokens.repositoryColorTokens.repositoryOpacityWhiteLow;

  Color get repositoryOpacityWhiteLower => colorTokens.repositoryColorTokens.repositoryOpacityWhiteLower;

  Color get repositoryOpacityWhiteLowest => colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowest;

  Color get repositoryOpacityWhiteTransparent => colorTokens.repositoryColorTokens.repositoryOpacityWhiteTransparent;

  Color get repositoryPositiveDefault => colorTokens.repositoryColorTokens.repositoryPositiveDefault;

  Color get repositoryPositiveHigh => colorTokens.repositoryColorTokens.repositoryPositiveHigh;

  Color get repositoryPositiveHighest => colorTokens.repositoryColorTokens.repositoryPositiveHighest;

  Color get repositoryPositiveLow => colorTokens.repositoryColorTokens.repositoryPositiveLow;

  Color get repositoryPositiveLowest => colorTokens.repositoryColorTokens.repositoryPositiveLowest;

  Color get repositoryPrimaryDefault => colorTokens.repositoryColorTokens.repositoryPrimaryDefault;

  Color get repositoryPrimaryLow => colorTokens.repositoryColorTokens.repositoryPrimaryLow;

  Color get repositoryWarningDefault => colorTokens.repositoryColorTokens.repositoryWarningDefault;

  Color get repositoryWarningHighest => colorTokens.repositoryColorTokens.repositoryWarningHighest;

  Color get repositoryWarningLow => colorTokens.repositoryColorTokens.repositoryWarningLow;

  Color get repositoryWarningLowest => colorTokens.repositoryColorTokens.repositoryWarningLowest;

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
}
