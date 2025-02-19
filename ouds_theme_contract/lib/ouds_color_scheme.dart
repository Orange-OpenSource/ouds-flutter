import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';

/// [OudsColorScheme] is a utility class that provides color scheme configurations based on the OUDS theme.
/// It determines the appropriate colors (background, border, etc.) based on the current theme mode (light or dark).
/// The class uses [OudsColorSemanticTokens] to access specific color tokens and adjusts the color values accordingly
/// for different states (enabled, disabled, hover, pressed).
/// It supports both system-defined theme modes and custom light/dark modes for the app.

class OudsColorScheme {
  final OudsColorSemanticTokens colorTokens;
  final ThemeMode themeMode;

  OudsColorScheme({
    required this.colorTokens,
    required this.themeMode,
  });

  bool get isDarkTheme {
    if (themeMode == ThemeMode.system) {
      final Brightness brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  /// Color - Opacity

  Color get colorOpacityLowest => isDarkTheme
      ? colorTokens.opacityColorTokens.opacityLowestDark
      : colorTokens.opacityColorTokens.opacityLowestLight;

  Color get colorOpacityLower => isDarkTheme
      ? colorTokens.opacityColorTokens.opacityLowerDark
      : colorTokens.opacityColorTokens.opacityLowerLight;

  Color get colorOpacityTransparent => isDarkTheme
      ? colorTokens.opacityColorTokens.opacityTransparentDark
      : colorTokens.opacityColorTokens.opacityTransparentLight;

  /// Color - Action

  Color get colorActionDisabled => isDarkTheme
      ? colorTokens.actionColorTokens.actionDisabledDark
      : colorTokens.actionColorTokens.actionDisabledLight;

  Color get colorActionEnabled => isDarkTheme
      ? colorTokens.actionColorTokens.actionEnabledDark
      : colorTokens.actionColorTokens.actionEnabledLight;

  Color get colorActionFocus => isDarkTheme
      ? colorTokens.actionColorTokens.actionFocusDark
      : colorTokens.actionColorTokens.actionFocusLight;

  Color get colorActionHighlighted => isDarkTheme
      ? colorTokens.actionColorTokens.actionHighlightedDark
      : colorTokens.actionColorTokens.actionHighlightedLight;

  Color get colorActionHover => isDarkTheme
      ? colorTokens.actionColorTokens.actionHoverDark
      : colorTokens.actionColorTokens.actionHoverLight;

  Color get colorActionLoading => isDarkTheme
      ? colorTokens.actionColorTokens.actionLoadingDark
      : colorTokens.actionColorTokens.actionLoadingLight;

  Color get colorActionNegativeEnabled => isDarkTheme
      ? colorTokens.actionColorTokens.actionNegativeEnabledDark
      : colorTokens.actionColorTokens.actionNegativeEnabledLight;

  Color get colorActionNegativeFocus => isDarkTheme
      ? colorTokens.actionColorTokens.actionNegativeFocusDark
      : colorTokens.actionColorTokens.actionNegativeFocusLight;

  Color get colorActionNegativeHover => isDarkTheme
      ? colorTokens.actionColorTokens.actionNegativeHoverDark
      : colorTokens.actionColorTokens.actionNegativeHoverLight;

  Color get colorActionNegativeLoading => isDarkTheme
      ? colorTokens.actionColorTokens.actionNegativeLoadingDark
      : colorTokens.actionColorTokens.actionNegativeLoadingLight;

  Color get colorActionNegativePressed => isDarkTheme
      ? colorTokens.actionColorTokens.actionNegativePressedDark
      : colorTokens.actionColorTokens.actionNegativePressedLight;

  Color get colorActionPressed => isDarkTheme
      ? colorTokens.actionColorTokens.actionPressedDark
      : colorTokens.actionColorTokens.actionPressedLight;

  Color get colorActionSelected => isDarkTheme
      ? colorTokens.actionColorTokens.actionSelectedDark
      : colorTokens.actionColorTokens.actionSelectedLight;

  Color get colorActionSupportEnabled => isDarkTheme
      ? colorTokens.actionColorTokens.actionSupportEnabledDark
      : colorTokens.actionColorTokens.actionSupportEnabledLight;

  Color get colorActionSupportFocus => isDarkTheme
      ? colorTokens.actionColorTokens.actionSupportFocusDark
      : colorTokens.actionColorTokens.actionSupportFocusLight;

  Color get colorActionSupportHover => isDarkTheme
      ? colorTokens.actionColorTokens.actionSupportHoverDark
      : colorTokens.actionColorTokens.actionSupportHoverLight;

  Color get colorActionSupportLoading => isDarkTheme
      ? colorTokens.actionColorTokens.actionSupportLoadingDark
      : colorTokens.actionColorTokens.actionSupportLoadingLight;

  Color get colorActionSupportPressed => isDarkTheme
      ? colorTokens.actionColorTokens.actionSupportPressedDark
      : colorTokens.actionColorTokens.actionSupportPressedLight;

  Color get colorActionVisited => isDarkTheme
      ? colorTokens.actionColorTokens.actionVisitedDark
      : colorTokens.actionColorTokens.actionVisitedLight;

  /// Color - Always

  Color get colorAlwaysBlack => isDarkTheme
      ? colorTokens.alwaysColorTokens.alwaysBlackDark
      : colorTokens.alwaysColorTokens.alwaysBlackLight;

  Color get colorAlwaysOnBlack => isDarkTheme
      ? colorTokens.alwaysColorTokens.alwaysOnBlackDark
      : colorTokens.alwaysColorTokens.alwaysOnBlackLight;

  Color get colorAlwaysOnWhite => isDarkTheme
      ? colorTokens.alwaysColorTokens.alwaysOnWhiteDark
      : colorTokens.alwaysColorTokens.alwaysOnWhiteLight;

  Color get colorAlwaysWhite => isDarkTheme
      ? colorTokens.alwaysColorTokens.alwaysWhiteDark
      : colorTokens.alwaysColorTokens.alwaysWhiteLight;

  /// Color - Background

  Color get colorBgEmphasized => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgEmphasizedDark
      : colorTokens.backgroundColorTokens.bgEmphasizedLight;

  Color get colorBgPrimary => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgPrimaryDark
      : colorTokens.backgroundColorTokens.bgPrimaryLight;

  Color get colorBgSecondary => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgSecondaryDark
      : colorTokens.backgroundColorTokens.bgSecondaryLight;

  Color get colorBgTertiary => isDarkTheme
      ? colorTokens.backgroundColorTokens.bgTertiaryDark
      : colorTokens.backgroundColorTokens.bgTertiaryLight;

  /// Color - Border

  Color get colorBorderBrandPrimary => isDarkTheme
      ? colorTokens.borderColorTokens.borderBrandPrimaryDark
      : colorTokens.borderColorTokens.borderBrandPrimaryLight;

  Color get colorBorderDefault => isDarkTheme
      ? colorTokens.borderColorTokens.borderDefaultDark
      : colorTokens.borderColorTokens.borderDefaultLight;

  Color get colorBorderEmphasized => isDarkTheme
      ? colorTokens.borderColorTokens.borderEmphasizedDark
      : colorTokens.borderColorTokens.borderEmphasizedLight;

  Color get colorBorderFocus => isDarkTheme
      ? colorTokens.borderColorTokens.borderFocusDark
      : colorTokens.borderColorTokens.borderFocusLight;

  Color get colorBorderFocusInset => isDarkTheme
      ? colorTokens.borderColorTokens.borderFocusInsetDark
      : colorTokens.borderColorTokens.borderFocusInsetLight;

  Color get colorBorderOnBrandPrimary => isDarkTheme
      ? colorTokens.borderColorTokens.borderOnBrandPrimaryDark
      : colorTokens.borderColorTokens.borderOnBrandPrimaryLight;

  /// Color - Content

  Color get colorContentBrandPrimary => isDarkTheme
      ? colorTokens.contentColorTokens.contentBrandPrimaryDark
      : colorTokens.contentColorTokens.contentBrandPrimaryLight;

  Color get colorContentDefault => isDarkTheme
      ? colorTokens.contentColorTokens.contentDefaultDark
      : colorTokens.contentColorTokens.contentDefaultLight;

  Color get colorContentDisabled => isDarkTheme
      ? colorTokens.contentColorTokens.contentDisabledDark
      : colorTokens.contentColorTokens.contentDisabledLight;

  Color get colorContentMuted => isDarkTheme
      ? colorTokens.contentColorTokens.contentMutedDark
      : colorTokens.contentColorTokens.contentMutedLight;

  Color get colorContentOnActionDisabled => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionDisabledDark
      : colorTokens.contentColorTokens.contentOnActionDisabledLight;

  Color get colorContentOnActionEnabled => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionEnabledDark
      : colorTokens.contentColorTokens.contentOnActionEnabledLight;

  Color get colorContentOnActionFocus => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionFocusDark
      : colorTokens.contentColorTokens.contentOnActionFocusLight;

  Color get colorContentOnActionHighlighted => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionHighlightedDark
      : colorTokens.contentColorTokens.contentOnActionHighlightedLight;

  Color get colorContentOnActionHover => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionHoverDark
      : colorTokens.contentColorTokens.contentOnActionHoverLight;

  Color get colorContentOnActionLoading => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionLoadingDark
      : colorTokens.contentColorTokens.contentOnActionLoadingLight;

  Color get colorContentOnActionPressed => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnActionPressedDark
      : colorTokens.contentColorTokens.contentOnActionPressedLight;

  Color get colorContentOnBrandPrimary => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnBrandPrimaryDark
      : colorTokens.contentColorTokens.contentOnBrandPrimaryLight;

  Color get colorContentOnOverlayEmphasized => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnOverlayEmphasizedDark
      : colorTokens.contentColorTokens.contentOnOverlayEmphasizedLight;

  Color get colorContentOnStatusEmphasized => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnStatusEmphasizedDark
      : colorTokens.contentColorTokens.contentOnStatusEmphasizedLight;

  Color get colorContentOnStatusEmphasizedAlt => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnStatusEmphasizedAltDark
      : colorTokens.contentColorTokens.contentOnStatusEmphasizedAltLight;

  Color get colorContentOnStatusMuted => isDarkTheme
      ? colorTokens.contentColorTokens.contentOnStatusMutedDark
      : colorTokens.contentColorTokens.contentOnStatusMutedLight;

  Color get colorContentStatusInfo => isDarkTheme
      ? colorTokens.contentColorTokens.contentStatusInfoDark
      : colorTokens.contentColorTokens.contentStatusInfoLight;

  Color get colorContentStatusNegative => isDarkTheme
      ? colorTokens.contentColorTokens.contentStatusNegativeDark
      : colorTokens.contentColorTokens.contentStatusNegativeLight;

  Color get colorContentStatusPositive => isDarkTheme
      ? colorTokens.contentColorTokens.contentStatusPositiveDark
      : colorTokens.contentColorTokens.contentStatusPositiveLight;

  Color get colorContentStatusWarning => isDarkTheme
      ? colorTokens.contentColorTokens.contentStatusWarningDark
      : colorTokens.contentColorTokens.contentStatusWarningLight;

  /// Color - Overlay

  Color get colorOverlayDefault => isDarkTheme
      ? colorTokens.overlayColorTokens.overlayDefaultDark
      : colorTokens.overlayColorTokens.overlayDefaultLight;

  Color get colorOverlayDrag => isDarkTheme
      ? colorTokens.overlayColorTokens.overlayDragDark
      : colorTokens.overlayColorTokens.overlayDragLight;

  Color get colorOverlayEmphasized => isDarkTheme
      ? colorTokens.overlayColorTokens.overlayEmphasizedDark
      : colorTokens.overlayColorTokens.overlayEmphasizedLight;

  Color get colorOverlayModal => isDarkTheme
      ? colorTokens.overlayColorTokens.overlayModalDark
      : colorTokens.overlayColorTokens.overlayModalLight;

  /// Color - Surface

  Color get colorSurfaceBrandPrimary => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceBrandPrimaryDark
      : colorTokens.surfaceColorTokens.surfaceBrandPrimaryLight;

  Color get colorSurfaceStatusAccentEmphasized => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusAccentEmphasizedDark
      : colorTokens.surfaceColorTokens.surfaceStatusAccentEmphasizedLight;

  Color get colorSurfaceStatusAccentMuted => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusAccentMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusAccentMutedLight;

  Color get colorSurfaceStatusInfoEmphasized => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusInfoEmphasizedDark
      : colorTokens.surfaceColorTokens.surfaceStatusInfoEmphasizedLight;

  Color get colorSurfaceStatusInfoMuted => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusInfoMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusInfoMutedLight;

  Color get colorSurfaceStatusNegativeEmphasized => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusNegativeEmphasizedDark
      : colorTokens.surfaceColorTokens.surfaceStatusNegativeEmphasizedLight;

  Color get colorSurfaceStatusNegativeMuted => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusNegativeMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusNegativeMutedLight;

  Color get colorSurfaceStatusNeutralEmphasized => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusNeutralEmphasizedDark
      : colorTokens.surfaceColorTokens.surfaceStatusNeutralEmphasizedLight;

  Color get colorSurfaceStatusNeutralMuted => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusNeutralMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusNeutralMutedLight;

  Color get colorSurfaceStatusPositiveEmphasized => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusPositiveEmphasizedDark
      : colorTokens.surfaceColorTokens.surfaceStatusPositiveEmphasizedLight;

  Color get colorSurfaceStatusPositiveMuted => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusPositiveMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusPositiveMutedLight;

  Color get colorSurfaceStatusWarningEmphasized => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusWarningEmphasizedDark
      : colorTokens.surfaceColorTokens.surfaceStatusWarningEmphasizedLight;

  Color get colorSurfaceStatusWarningMuted => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusWarningMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusWarningMutedLight;

  /// Color - Decorative

  Color get colorDecorativeAccent1Default => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent1DefaultDark
      : colorTokens.decorativeColorTokens.decorativeAccent1DefaultLight;

  Color get colorDecorativeAccent1Emphasized => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent1EmphasizedDark
      : colorTokens.decorativeColorTokens.decorativeAccent1EmphasizedLight;

  Color get colorDecorativeAccent1Muted => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent1MutedDark
      : colorTokens.decorativeColorTokens.decorativeAccent1MutedLight;

  Color get colorDecorativeAccent2Default => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent2DefaultDark
      : colorTokens.decorativeColorTokens.decorativeAccent2DefaultLight;

  Color get colorDecorativeAccent2Emphasized => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent2EmphasizedDark
      : colorTokens.decorativeColorTokens.decorativeAccent2EmphasizedLight;

  Color get colorDecorativeAccent2Muted => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent2MutedDark
      : colorTokens.decorativeColorTokens.decorativeAccent2MutedLight;

  Color get colorDecorativeAccent3Default => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent3DefaultDark
      : colorTokens.decorativeColorTokens.decorativeAccent3DefaultLight;

  Color get colorDecorativeAccent3Emphasized => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent3EmphasizedDark
      : colorTokens.decorativeColorTokens.decorativeAccent3EmphasizedLight;

  Color get colorDecorativeAccent3Muted => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent3MutedDark
      : colorTokens.decorativeColorTokens.decorativeAccent3MutedLight;

  Color get colorDecorativeAccent4Default => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent4DefaultDark
      : colorTokens.decorativeColorTokens.decorativeAccent4DefaultLight;

  Color get colorDecorativeAccent4Emphasized => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent4EmphasizedDark
      : colorTokens.decorativeColorTokens.decorativeAccent4EmphasizedLight;

  Color get colorDecorativeAccent4Muted => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent4MutedDark
      : colorTokens.decorativeColorTokens.decorativeAccent4MutedLight;

  Color get colorDecorativeAccent5Default => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent5DefaultDark
      : colorTokens.decorativeColorTokens.decorativeAccent5DefaultLight;

  Color get colorDecorativeAccent5Emphasized => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent5EmphasizedDark
      : colorTokens.decorativeColorTokens.decorativeAccent5EmphasizedLight;

  Color get colorDecorativeAccent5Muted => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeAccent5MutedDark
      : colorTokens.decorativeColorTokens.decorativeAccent5MutedLight;

  Color get colorDecorativeBrandPrimary => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeBrandPrimaryDark
      : colorTokens.decorativeColorTokens.decorativeBrandPrimaryLight;

  Color get colorDecorativeBrandSecondary => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeBrandSecondaryDark
      : colorTokens.decorativeColorTokens.decorativeBrandSecondaryLight;

  Color get colorDecorativeBrandTertiary => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeBrandTertiaryDark
      : colorTokens.decorativeColorTokens.decorativeBrandTertiaryLight;

  Color get colorDecorativeNeutralDefault => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeNeutralDefaultDark
      : colorTokens.decorativeColorTokens.decorativeNeutralDefaultLight;

  Color get colorDecorativeNeutralEmphasized => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedDark
      : colorTokens.decorativeColorTokens.decorativeNeutralEmphasizedLight;

  Color get colorDecorativeNeutralMuted => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeNeutralMutedDark
      : colorTokens.decorativeColorTokens.decorativeNeutralMutedLight;

  Color get colorDecorativeSkinTint100 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint100Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint100Light;

  Color get colorDecorativeSkinTint200 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint200Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint200Light;

  Color get colorDecorativeSkinTint300 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint300Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint300Light;

  Color get colorDecorativeSkinTint400 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint400Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint400Light;

  Color get colorDecorativeSkinTint500 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint500Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint500Light;

  Color get colorDecorativeSkinTint600 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint600Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint600Light;

  Color get colorDecorativeSkinTint700 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint700Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint700Light;

  Color get colorDecorativeSkinTint800 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint800Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint800Light;

  Color get colorDecorativeSkinTint900 => isDarkTheme
      ? colorTokens.decorativeColorTokens.decorativeSkinTint900Dark
      : colorTokens.decorativeColorTokens.decorativeSkinTint900Light;

  /// Color - Repository

  Color get colorRepositoryAccentDefault => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryAccentDefaultDark
      : colorTokens.repositoryColorTokens.repositoryAccentDefaultLight;

  Color get colorRepositoryAccentHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryAccentHighestDark
      : colorTokens.repositoryColorTokens.repositoryAccentHighestLight;

  Color get colorRepositoryAccentLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryAccentLowDark
      : colorTokens.repositoryColorTokens.repositoryAccentLowLight;

  Color get colorRepositoryAccentLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryAccentLowestDark
      : colorTokens.repositoryColorTokens.repositoryAccentLowestLight;

  Color get colorRepositoryInfoDefault => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryInfoDefaultDark
      : colorTokens.repositoryColorTokens.repositoryInfoDefaultLight;

  Color get colorRepositoryInfoHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryInfoHighestDark
      : colorTokens.repositoryColorTokens.repositoryInfoHighestLight;

  Color get colorRepositoryInfoLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryInfoLowDark
      : colorTokens.repositoryColorTokens.repositoryInfoLowLight;

  Color get colorRepositoryInfoLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryInfoLowestDark
      : colorTokens.repositoryColorTokens.repositoryInfoLowestLight;

  Color get colorRepositoryNegativeDefault => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeDefaultDark
      : colorTokens.repositoryColorTokens.repositoryNegativeDefaultLight;

  Color get colorRepositoryNegativeHigh => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeHighDark
      : colorTokens.repositoryColorTokens.repositoryNegativeHighLight;

  Color get colorRepositoryNegativeHigher => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeHigherDark
      : colorTokens.repositoryColorTokens.repositoryNegativeHigherLight;

  Color get colorRepositoryNegativeHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeHighestDark
      : colorTokens.repositoryColorTokens.repositoryNegativeHighestLight;

  Color get colorRepositoryNegativeLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeLowDark
      : colorTokens.repositoryColorTokens.repositoryNegativeLowLight;

  Color get colorRepositoryNegativeLower => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeLowerDark
      : colorTokens.repositoryColorTokens.repositoryNegativeLowerLight;

  Color get colorRepositoryNegativeLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNegativeLowestDark
      : colorTokens.repositoryColorTokens.repositoryNegativeLowestLight;

  Color get colorRepositoryNeutralEmphasizedBlack => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedBlackDark
      : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedBlackLight;

  Color get colorRepositoryNeutralEmphasizedHigh => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighDark
      : colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighLight;

  Color get colorRepositoryNeutralEmphasizedHigher => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHigherDark
      : colorTokens
          .repositoryColorTokens.repositoryNeutralEmphasizedHigherLight;

  Color get colorRepositoryNeutralEmphasizedHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedHighestDark
      : colorTokens
          .repositoryColorTokens.repositoryNeutralEmphasizedHighestLight;

  Color get colorRepositoryNeutralEmphasizedMedium => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralEmphasizedMediumDark
      : colorTokens
          .repositoryColorTokens.repositoryNeutralEmphasizedMediumLight;

  Color get colorRepositoryNeutralMutedLower => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralMutedLowerDark
      : colorTokens.repositoryColorTokens.repositoryNeutralMutedLowerLight;

  Color get colorRepositoryNeutralMutedLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralMutedLowestDark
      : colorTokens.repositoryColorTokens.repositoryNeutralMutedLowestLight;

  Color get colorRepositoryNeutralMutedWhite => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryNeutralMutedWhiteDark
      : colorTokens.repositoryColorTokens.repositoryNeutralMutedWhiteLight;

  Color get colorRepositoryOpacityBlackHigh => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackHighDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackHighLight;

  Color get colorRepositoryOpacityBlackHigher => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackHigherDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackHigherLight;

  Color get colorRepositoryOpacityBlackHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackHighestDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackHighestLight;

  Color get colorRepositoryOpacityBlackLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackLowDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackLowLight;

  Color get colorRepositoryOpacityBlackLower => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackLowerDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackLowerLight;

  Color get colorRepositoryOpacityBlackLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackLowestDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackLowestLight;

  Color get colorRepositoryOpacityBlackMedium => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackMediumLight;

  Color get colorRepositoryOpacityBlackSoft => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackSoftDark
      : colorTokens.repositoryColorTokens.repositoryOpacityBlackSoftLight;

  Color get colorRepositoryOpacityBlackTransparent => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityBlackTransparentDark
      : colorTokens
          .repositoryColorTokens.repositoryOpacityBlackTransparentLight;

  Color get colorRepositoryOpacityInfo => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityInfoDark
      : colorTokens.repositoryColorTokens.repositoryOpacityInfoLight;

  Color get colorRepositoryOpacityNegative => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityNegativeDark
      : colorTokens.repositoryColorTokens.repositoryOpacityNegativeLight;

  Color get colorRepositoryOpacityPositive => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityPositiveDark
      : colorTokens.repositoryColorTokens.repositoryOpacityPositiveLight;

  Color get colorRepositoryOpacityWarning => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWarningDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWarningLight;

  Color get colorRepositoryOpacityWhiteHigh => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighLight;

  Color get colorRepositoryOpacityWhiteHigher => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteHigherDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteHigherLight;

  Color get colorRepositoryOpacityWhiteHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighestDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteHighestLight;

  Color get colorRepositoryOpacityWhiteMedium => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteMediumLight;

  Color get colorRepositoryOpacityWhiteLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowLight;

  Color get colorRepositoryOpacityWhiteLower => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowerDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowerLight;

  Color get colorRepositoryOpacityWhiteLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowestDark
      : colorTokens.repositoryColorTokens.repositoryOpacityWhiteLowestLight;

  Color get colorRepositoryOpacityWhiteTransparent => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryOpacityWhiteTransparentDark
      : colorTokens
          .repositoryColorTokens.repositoryOpacityWhiteTransparentLight;

  Color get colorRepositoryPositiveDefault => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPositiveDefaultDark
      : colorTokens.repositoryColorTokens.repositoryPositiveDefaultLight;

  Color get colorRepositoryPositiveHigh => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPositiveHighDark
      : colorTokens.repositoryColorTokens.repositoryPositiveHighLight;

  Color get colorRepositoryPositiveHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPositiveHighestDark
      : colorTokens.repositoryColorTokens.repositoryPositiveHighestLight;

  Color get colorRepositoryPositiveLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPositiveLowDark
      : colorTokens.repositoryColorTokens.repositoryPositiveLowLight;

  Color get colorRepositoryPositiveLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPositiveLowestDark
      : colorTokens.repositoryColorTokens.repositoryPositiveLowestLight;

  Color get colorRepositoryPrimaryDefault => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPrimaryDefaultDark
      : colorTokens.repositoryColorTokens.repositoryPrimaryDefaultLight;

  Color get colorRepositoryPrimaryLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryPrimaryLowDark
      : colorTokens.repositoryColorTokens.repositoryPrimaryLowLight;

  Color get colorRepositoryWarningDefault => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryWarningDefaultDark
      : colorTokens.repositoryColorTokens.repositoryWarningDefaultLight;

  Color get colorRepositoryWarningHighest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryWarningHighestDark
      : colorTokens.repositoryColorTokens.repositoryWarningHighestLight;

  Color get colorRepositoryWarningLow => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryWarningLowDark
      : colorTokens.repositoryColorTokens.repositoryWarningLowLight;

  Color get colorRepositoryWarningLowest => isDarkTheme
      ? colorTokens.repositoryColorTokens.repositoryWarningLowestDark
      : colorTokens.repositoryColorTokens.repositoryWarningLowestLight;

/*
  Color get colorActionColorTokens => isDarkTheme
      ? colorTokens.actionColorTokens.actionEnabledDark
      : colorTokens.actionColorTokens.actionEnabledLight;

  Color get colorActionEnabled => isDarkTheme
      ? colorTokens.actionColorTokens.actionEnabledDark
      : colorTokens.actionColorTokens.actionEnabledLight;

  Color get colorContentStatusWarning => isDarkTheme
      ? colorTokens.surfaceColorTokens.surfaceStatusWarningMutedDark
      : colorTokens.surfaceColorTokens.surfaceStatusWarningMutedLight;

   */
}
