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

/// Centralized access point for all asset categories used in the OUDS Flutter library.
class AppAssets {
  static final symbols = _Symbols();
  static final images = _Images();
  static final icons = _Icons();
  static final fonts = _Fonts();
  static final animations = _Animations();
}

class _Symbols {
  _Symbols();
  final String symbolsRadioSelected = 'assets/symbol_radio_selected.svg';
  final String symbolsCheckboxSelected = 'assets/symbol_checkbox_selected.svg';
  final String symbolsCheckboxIndeterminate = 'assets/symbol_checkbox_indeterminate.svg';
  final String symbolsFilterChipSelected = 'assets/symbol_filter_chip_selected.svg';

}

class _Images {
  _Images();
}

class _Icons {
  _Icons();
}

class _Fonts {
  _Fonts();
}

class _Animations {
  _Animations();
}
