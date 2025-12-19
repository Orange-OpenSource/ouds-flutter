/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';

/// Centralized access point for all asset categories used in the OUDS Flutter App.
class AppAssets {
  static final images = _Images();
  static final icons = _Icons();
  static final fonts = _Fonts();
  static final animations = _Animations();
}

class _Images {
  _Images();

  /// Tokens
  final String ilTokensColor = 'assets/illustration/token/il_tokens_color.svg';
  final String ilTokensColorDark = 'assets/illustration/token/il_tokens_color_dark.svg';

  final String ilTokensElevation = 'assets/illustration/token/il_tokens_elevation.svg';
  final String ilTokensElevationDark = 'assets/illustration/token/il_tokens_elevation_dark.svg';

  final String ilTokensOpacity = 'assets/illustration/token/il_tokens_opacity.svg';
  final String ilTokensOpacityDark = 'assets/illustration/token/il_tokens_opacity_dark.svg';

  final String ilUnion = 'assets/illustration/token/il_union.svg';
  final String ilUnionDark = 'assets/illustration/token/il_union_dark.svg';

  final String ilTypography = 'assets/illustration/token/il_tokens_typography.svg';
  final String ilTypographyDark = 'assets/illustration/token/il_tokens_typography_dark.svg';

  final String ilTokenBorder = 'assets/illustration/token/il_tokens_border.svg';
  final String ilTokenBorderDark = 'assets/illustration/token/il_tokens_border_dark.svg';

  // Components
  final String ilTopAppBarAvatar = 'assets/common/component/il_top_app_bar_avatar.jpg';

}

class _Icons {
  const _Icons();

  String functionalSocialAndEngagementContact(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/social-and-engagement/contact.svg';
  String functionalSocialAndEngagementHeartEmpty(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/social-and-engagement/heart-empty.svg';
  String functionalActionsDelete(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/actions/delete.svg';
  String functionalActionsCopy(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/actions/copy.svg';
  String functionalSettingsAndToolsUiLightMode(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/settings-and-tools/ui-light-mode.svg';
  String functionalSettingsAndToolsUiDarkMode(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/settings-and-tools/ui-dark-mode.svg';
  String functionalSettingsAndToolsThemeSystem(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/settings-and-tools/theme-system.svg';
  String functionalStatusAndIndicatorsInfo(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/status-and-indicators/info-fill.svg';
  String assistanceTipsAndTricks(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}communication/assistance/tips-and-tricks.svg';
  String designTheme(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}communication/design/theme.svg';
  String designComponentAtom(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}communication/design/component-atom.svg';
  String designToken(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}communication/design/design-token.svg';
}

class _Fonts {
  const _Fonts();
}

class _Animations {
  const _Animations();
}
