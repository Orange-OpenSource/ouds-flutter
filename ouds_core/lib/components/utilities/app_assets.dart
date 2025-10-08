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

/// @nodoc
library;

/// Centralized access point for all asset categories used in the OUDS Flutter library.
class AppAssets {
  static final images = _Images();
  static final icons = _Icons();
  static final fonts = _Fonts();
  static final animations = _Animations();
}

class _Images {
  _Images();
}

class _Icons {
  _Icons();

  final String importantAlert = 'assets/ic_important_alert.svg';
  final String radioSelected = 'assets/ic_radio-button_selected.svg';
  final String checkboxUndeterminate = 'assets/ic_checkbox_undeterminate.svg';
  final String checkboxSelected = 'assets/ic_checkbox_selected.svg';
  final String switchChecked = 'assets/ic_switch_selected.svg';
  final String filterChipSelected = 'assets/ic_tick.svg';

  final String tick = 'assets/ic_positive.svg';
  final String info = 'assets/ic_info.svg';
  final String warning = 'assets/ic_warning.svg';
  final String error = 'assets/ic_error.svg';
  final String bullet = 'assets/ic_bullet.svg';
  final String roundedBullet = 'assets/ic_bullet_rounded.svg';
  final String delete = 'assets/ic_delete.svg';
}

class _Fonts {
  _Fonts();
}

class _Animations {
  _Animations();
}
