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
  final String ilTokensColor = 'assets/il_tokens_color.svg';
  final String ilTokensColorDark = 'assets/il_tokens_color_dark.svg';

  final String ilTokensElevation = 'assets/il_tokens_elevation.svg';
  final String ilTokensElevationDark = 'assets/il_tokens_elevation_dark.svg';

  final String ilTokensOpacity = 'assets/il_tokens_opacity.svg';
  final String ilTokensOpacityDark = 'assets/il_tokens_opacity_dark.svg';

  final String ilUnion = 'assets/il_union.svg';
  final String ilUnionDark = 'assets/il_union_dark.svg';

  final String ilTypography = 'assets/il_tokens_typography.svg';
  final String ilTypographyDark = 'assets/il_tokens_typography_dark.svg';

  final String ilTokenBorder = 'assets/il_tokens_border.svg';
  final String ilTokenBorderDark = 'assets/il_tokens_border_dark.svg';
}

class _Icons {
  const _Icons();

  final String icAbout = 'assets/ic_about.svg';
  final String icAtom = 'assets/ic_atom.svg';
  final String icCopy = 'assets/ic_copy.svg';
  final String icPalette = 'assets/ic_palette.svg';
  final String icThemeSystem = 'assets/ic_theme_system.svg';
  final String icToken = 'assets/ic_token.svg';
  final String icUILightMode = 'assets/ui-light-mode.svg';

  String functionalSocialAndEngagementHeartEmpty(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/social-and-engagement/heart-empty.svg';
  String functionalActionsDelete(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/actions/delete.svg';
  String functionalSettingsAndToolsUiDarkMode(ThemeController themeController) => '${themeController.getAssetsPath(themeController)}functional/settings-and-tools/ui-dark-mode.svg';
}

class _Fonts {
  const _Fonts();
}

class _Animations {
  const _Animations();
}
