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
import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/config/component/ouds_button_config.dart';
import 'package:ouds_theme_contract/config/component/ouds_tag_config.dart';
import 'package:ouds_theme_contract/config/component/ouds_text_input_config.dart';

class OudsThemeConfigModel extends InheritedWidget {
  final OudsButtonConfig? button;
  final OudsTagConfig? tag;
  final OudsTextInputConfig? textInput;

  const OudsThemeConfigModel({
    this.button,
    this.tag,
    this.textInput,
    required super.child,
    super.key,
  });

  static OudsThemeConfigModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OudsThemeConfigModel>();
  }

  @override
  bool updateShouldNotify(covariant OudsThemeConfigModel oldWidget) {
    return button != oldWidget.button || tag != oldWidget.tag || textInput != oldWidget.textInput;
  }
}
