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

/// Centralized access point for all asset categories used in the OUDS Flutter App.
class AppAssets {
  static final images = _Images();
  static final icons = _Icons();
  static final fonts = _Fonts();
  static final animations = _Animations();
}

class _Images {
  _Images();

  /// Components
  final String ilComponentsButton = 'assets/il_components_button.svg';
  final String ilComponentsButtonDark = 'assets/il_components_button_dark.svg';

  final String ilComponentsDivider = 'assets/il_components_divider.svg';
  final String ilComponentsDividerDark = 'assets/il_components_divider_dark.svg';

  final String ilcomponentsCheckbox = 'assets/il_components_checkbox.svg';
  final String ilcomponentsCheckboxDark = 'assets/il_components_checkbox_dark.svg';

  final String ilComponentsRadioButton = 'assets/il_components_radio_button.svg';
  final String ilComponentsRadioButtonDark = 'assets/il_components_radio_button_dark.svg';

  final String ilComponentsSwitch = 'assets/il_components_switch.svg';
  final String ilComponentsSwitchDark = 'assets/il_components_switch_dark.svg';

  ///Tokens
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
}

class _Icons {
  const _Icons();

  final String icAbout = 'assets/ic_about.svg';
  final String icAtom = 'assets/ic_atom.svg';
  final String icCopy = 'assets/ic_copy.svg';
  final String icPalette = 'assets/ic_palette.svg';
  final String icThemeSystem = 'assets/ic_theme_system.svg';
  final String icToken = 'assets/ic_token.svg';
  final String icHeart = 'assets/ic_heart.svg';
}

class _Fonts {
  const _Fonts();
}

class _Animations {
  const _Animations();
}
