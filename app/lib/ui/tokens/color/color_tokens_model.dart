import 'package:flutter/cupertino.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/tokens/color/color_screen.dart';
import 'package:ouds_theme_contract/ouds_theme_contract.dart';

class ColorTokensModel {
  final Map<String, List<ColorTokenItem>> _groups;

  ColorTokensModel(this._groups);

  List<ColorTokenItem> operator [](String key) => _groups[key] ?? [];

  Map<String, List<ColorTokenItem>> get all => _groups;

  factory ColorTokensModel.fromTheme(
    BuildContext context,
    OudsThemeContract theme,
  ) {
    return ColorTokensModel({
      context.l10n.app_tokens_color_action_label: [
        ColorTokenItem(
          name: 'actionDisabled',
          value: theme.colorScheme(context).actionDisabled,
        ),
        ColorTokenItem(
          name: 'actionEnabled',
          value: theme.colorScheme(context).actionEnabled,
        ),
        ColorTokenItem(
          name: 'actionFocus',
          value: theme.colorScheme(context).actionFocus,
        ),
        ColorTokenItem(
          name: 'actionHighlighted',
          value: theme.colorScheme(context).actionHighlighted,
        ),
        ColorTokenItem(
          name: 'actionHover',
          value: theme.colorScheme(context).actionHover,
        ),
        ColorTokenItem(
          name: 'actionLoading',
          value: theme.colorScheme(context).actionLoading,
        ),
        ColorTokenItem(
          name: 'actionNegativeEnabled',
          value: theme.colorScheme(context).actionNegativeEnabled,
        ),
        ColorTokenItem(
          name: 'actionNegativeFocus',
          value: theme.colorScheme(context).actionNegativeFocus,
        ),
        ColorTokenItem(
          name: 'actionNegativeHover',
          value: theme.colorScheme(context).actionNegativeHover,
        ),
        ColorTokenItem(
          name: 'actionNegativeLoading',
          value: theme.colorScheme(context).actionNegativeLoading,
        ),
        ColorTokenItem(
          name: 'actionNegativePressed',
          value: theme.colorScheme(context).actionNegativePressed,
        ),
        ColorTokenItem(
          name: 'actionPressed',
          value: theme.colorScheme(context).actionPressed,
        ),
        ColorTokenItem(
          name: 'actionReadOnlyPrimary',
          value: theme.colorScheme(context).actionReadOnlyPrimary,
        ),
        ColorTokenItem(
          name: 'actionReadOnlySecondary',
          value: theme.colorScheme(context).actionReadOnlySecondary,
        ),
        ColorTokenItem(
          name: 'actionSelected',
          value: theme.colorScheme(context).actionSelected,
        ),
        ColorTokenItem(
          name: 'actionSupportDisabled ',
          value: theme.colorScheme(context).actionSupportDisabled,
        ),
        ColorTokenItem(
          name: 'actionSupportEnabled',
          value: theme.colorScheme(context).actionSupportEnabled,
        ),
        ColorTokenItem(
          name: 'actionSupportFocus',
          value: theme.colorScheme(context).actionSupportFocus,
        ),
        ColorTokenItem(
          name: 'actionSupportHover',
          value: theme.colorScheme(context).actionSupportHover,
        ),
        ColorTokenItem(
          name: 'actionSupportLoading',
          value: theme.colorScheme(context).actionSupportLoading,
        ),
        ColorTokenItem(
          name: 'actionSupportPressed',
          value: theme.colorScheme(context).actionSupportPressed,
        ),
        ColorTokenItem(
          name: 'actionVisited',
          value: theme.colorScheme(context).actionVisited,
        ),
      ],
      context.l10n.app_tokens_color_always_label: [
        ColorTokenItem(
          name: 'alwaysBlack',
          value: theme.colorScheme(context).alwaysBlack,
        ),
        ColorTokenItem(
          name: 'alwaysOnBlack',
          value: theme.colorScheme(context).alwaysOnBlack,
        ),
        ColorTokenItem(
          name: 'alwaysOnWhite',
          value: theme.colorScheme(context).alwaysOnWhite,
        ),
        ColorTokenItem(
          name: 'alwaysWhite',
          value: theme.colorScheme(context).alwaysWhite,
        ),
      ],
      context.l10n.app_tokens_color_background_label: [
        ColorTokenItem(
          name: 'bgInverseHigh',
          value: theme.colorScheme(context).bgInverseHigh,
        ),
        ColorTokenItem(
          name: 'bgInverseLow',
          value: theme.colorScheme(context).bgInverseLow,
        ),
        ColorTokenItem(
          name: 'bgPrimary',
          value: theme.colorScheme(context).bgPrimary,
        ),
        ColorTokenItem(
          name: 'bgSecondary',
          value: theme.colorScheme(context).bgSecondary,
        ),
        ColorTokenItem(
          name: 'bgTertiary',
          value: theme.colorScheme(context).bgTertiary,
        ),
      ],
      context.l10n.app_tokens_color_border_label: [
        ColorTokenItem(
          name: 'borderBrandPrimary',
          value: theme.colorScheme(context).borderBrandPrimary,
        ),
        ColorTokenItem(
          name: 'borderBrandSecondary',
          value: theme.colorScheme(context).borderBrandSecondary,
        ),
        ColorTokenItem(
          name: 'borderBrandTertiary',
          value: theme.colorScheme(context).borderBrandTertiary,
        ),
        ColorTokenItem(
          name: 'borderDefault',
          value: theme.colorScheme(context).borderDefault,
        ),
        ColorTokenItem(
          name: 'borderEmphasized',
          value: theme.colorScheme(context).borderEmphasized,
        ),
        ColorTokenItem(
          name: 'borderFocus',
          value: theme.colorScheme(context).borderFocus,
        ),
        ColorTokenItem(
          name: 'borderFocusInset',
          value: theme.colorScheme(context).borderFocusInset,
        ),
        ColorTokenItem(
          name: 'borderMuted',
          value: theme.colorScheme(context).borderMuted,
        ),
        ColorTokenItem(
          name: 'borderOnBrandPrimary',
          value: theme.colorScheme(context).borderOnBrandPrimary,
        ),
        ColorTokenItem(
          name: 'borderOnBrandSecondary',
          value: theme.colorScheme(context).borderOnBrandSecondary,
        ),
        ColorTokenItem(
          name: 'borderOnBrandTertiary',
          value: theme.colorScheme(context).borderOnBrandTertiary,
        ),
        ColorTokenItem(
          name: 'borderMinimal',
          value: theme.colorScheme(context).borderMinimal,
        ),
        ColorTokenItem(
          name: 'borderStatusAccent',
          value: theme.colorScheme(context).borderStatusAccent,
        ),
        ColorTokenItem(
          name: 'borderStatusInfo',
          value: theme.colorScheme(context).borderStatusInfo,
        ),
        ColorTokenItem(
          name: 'borderStatusNegative',
          value: theme.colorScheme(context).borderStatusNegative,
        ),
        ColorTokenItem(
          name: 'borderStatusPositive',
          value: theme.colorScheme(context).borderStatusPositive,
        ),
        ColorTokenItem(
          name: 'borderStatusWarning',
          value: theme.colorScheme(context).borderStatusWarning,
        ),
      ],
      context.l10n.app_tokens_color_content_label: [
        ColorTokenItem(
          name: 'contentBrandPrimary',
          value: theme.colorScheme(context).contentBrandPrimary,
        ),
        ColorTokenItem(
          name: 'contentBrandSecondary',
          value: theme.colorScheme(context).contentBrandSecondary,
        ),
        ColorTokenItem(
          name: 'contentBrandTertiary',
          value: theme.colorScheme(context).contentBrandTertiary,
        ),
        ColorTokenItem(
          name: 'contentDefault',
          value: theme.colorScheme(context).contentDefault,
        ),
        ColorTokenItem(
          name: 'contentDisabled',
          value: theme.colorScheme(context).contentDisabled,
        ),
        ColorTokenItem(
          name: 'contentInverse',
          value: theme.colorScheme(context).contentInverse,
        ),
        ColorTokenItem(
          name: 'contentMuted',
          value: theme.colorScheme(context).contentMuted,
        ),
        ColorTokenItem(
          name: 'contentOnActionDisabled',
          value: theme.colorScheme(context).contentOnActionDisabled,
        ),
        ColorTokenItem(
          name: 'contentOnActionEnabled',
          value: theme.colorScheme(context).contentOnActionEnabled,
        ),
        ColorTokenItem(
          name: 'contentOnActionFocus',
          value: theme.colorScheme(context).contentOnActionFocus,
        ),
        ColorTokenItem(
          name: 'contentOnActionHighlighted',
          value: theme.colorScheme(context).contentOnActionHighlighted,
        ),
        ColorTokenItem(
          name: 'contentOnActionHover',
          value: theme.colorScheme(context).contentOnActionHover,
        ),
        ColorTokenItem(
          name: 'contentOnActionLoading',
          value: theme.colorScheme(context).contentOnActionLoading,
        ),
        ColorTokenItem(
          name: 'contentOnActionPressed',
          value: theme.colorScheme(context).contentOnActionPressed,
        ),
        ColorTokenItem(
          name: 'contentOnActionSelected',
          value: theme.colorScheme(context).contentOnActionSelected,
        ),
        ColorTokenItem(
          name: 'contentOnBrandPrimary',
          value: theme.colorScheme(context).contentOnBrandPrimary,
        ),
        ColorTokenItem(
          name: 'contentOnBrandSecondary',
          value: theme.colorScheme(context).contentOnBrandSecondary,
        ),
        ColorTokenItem(
          name: 'contentOnBrandTertiary',
          value: theme.colorScheme(context).contentOnBrandTertiary,
        ),
        ColorTokenItem(
          name: 'contentOnStatusPositiveEmphasized',
          value: theme.colorScheme(context).contentOnStatusPositiveEmphasized,
        ),
        ColorTokenItem(
          name: 'contentOnStatusInfoEmphasized',
          value: theme.colorScheme(context).contentOnStatusInfoEmphasized,
        ),
        ColorTokenItem(
          name: 'contentOnStatusInfoMuted',
          value: theme.colorScheme(context).contentOnStatusInfoMuted,
        ),
        ColorTokenItem(
          name: 'contentOnStatusNegativeEmphasized',
          value: theme.colorScheme(context).contentOnStatusNegativeEmphasized,
        ),
        ColorTokenItem(
          name: 'contentOnStatusNegativeMuted',
          value: theme.colorScheme(context).contentOnStatusNegativeMuted,
        ),
        ColorTokenItem(
          name: 'contentOnStatusAccentEmphasized',
          value: theme.colorScheme(context).contentOnStatusAccentEmphasized,
        ),
        ColorTokenItem(
          name: 'contentOnStatusAccentMuted',
          value: theme.colorScheme(context).contentOnStatusAccentMuted,
        ),
        ColorTokenItem(
          name: 'contentStatusAccent',
          value: theme.colorScheme(context).contentStatusAccent,
        ),
        ColorTokenItem(
          name: 'contentStatusInfo',
          value: theme.colorScheme(context).contentStatusInfo,
        ),
        ColorTokenItem(
          name: 'contentStatusNegative',
          value: theme.colorScheme(context).contentStatusNegative,
        ),
        ColorTokenItem(
          name: 'contentStatusPositive',
          value: theme.colorScheme(context).contentStatusPositive,
        ),
        ColorTokenItem(
          name: 'contentStatusWarning',
          value: theme.colorScheme(context).contentStatusWarning,
        ),
      ],
      context.l10n.app_tokens_color_overlay_label: [
        ColorTokenItem(
          name: 'overlayDropdown',
          value: theme.colorScheme(context).overlayDropdown,
        ),
        ColorTokenItem(
          name: 'overlayTooltip',
          value: theme.colorScheme(context).overlayTooltip,
        ),
        ColorTokenItem(
          name: 'overlayDrag',
          value: theme.colorScheme(context).overlayDrag,
        ),
        ColorTokenItem(
          name: 'overlayModal',
          value: theme.colorScheme(context).overlayModal,
        ),
      ],
      context.l10n.app_tokens_color_surface_label: [
        ColorTokenItem(
          name: 'surfaceBrandPrimary',
          value: theme.colorScheme(context).surfaceBrandPrimary,
        ),
        ColorTokenItem(
          name: 'surfaceBrandSecondary',
          value: theme.colorScheme(context).surfaceBrandSecondary,
        ),
        ColorTokenItem(
          name: 'surfaceBrandTertiary',
          value: theme.colorScheme(context).surfaceBrandTertiary,
        ),
        ColorTokenItem(
          name: 'surfaceInverseHigh',
          value: theme.colorScheme(context).surfaceInverseHigh,
        ),
        ColorTokenItem(
          name: 'surfaceInverseLow',
          value: theme.colorScheme(context).surfaceInverseLow,
        ),
        ColorTokenItem(
          name: 'surfacePrimary',
          value: theme.colorScheme(context).surfacePrimary,
        ),
        ColorTokenItem(
          name: 'surfaceSecondary',
          value: theme.colorScheme(context).surfaceSecondary,
        ),
        ColorTokenItem(
          name: 'surfaceTertiary',
          value: theme.colorScheme(context).surfaceTertiary,
        ),
        ColorTokenItem(
          name: 'surfaceStatusAccentEmphasized',
          value: theme.colorScheme(context).surfaceStatusAccentEmphasized,
        ),
        ColorTokenItem(
          name: 'surfaceStatusAccentMuted',
          value: theme.colorScheme(context).surfaceStatusAccentMuted,
        ),
        ColorTokenItem(
          name: 'surfaceStatusInfoEmphasized',
          value: theme.colorScheme(context).surfaceStatusInfoEmphasized,
        ),
        ColorTokenItem(
          name: 'surfaceStatusInfoMuted',
          value: theme.colorScheme(context).surfaceStatusInfoMuted,
        ),
        ColorTokenItem(
          name: 'surfaceStatusNegativeEmphasized',
          value: theme.colorScheme(context).surfaceStatusNegativeEmphasized,
        ),
        ColorTokenItem(
          name: 'surfaceStatusNegativeMuted',
          value: theme.colorScheme(context).surfaceStatusNegativeMuted,
        ),
        ColorTokenItem(
          name: 'surfaceStatusPositiveEmphasized',
          value: theme.colorScheme(context).surfaceStatusPositiveEmphasized,
        ),
        ColorTokenItem(
          name: 'surfaceStatusPositiveMuted',
          value: theme.colorScheme(context).surfaceStatusPositiveMuted,
        ),
        ColorTokenItem(
          name: 'surfaceStatusWarningEmphasized',
          value: theme.colorScheme(context).surfaceStatusWarningEmphasized,
        ),
        ColorTokenItem(
          name: 'surfaceStatusWarningMuted',
          value: theme.colorScheme(context).surfaceStatusWarningMuted,
        ),
      ],
    });
  }
}
