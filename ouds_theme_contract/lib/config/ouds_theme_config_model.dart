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
import 'package:ouds_theme_contract/config/component/ouds_alert_message_config_border.dart';
import 'package:ouds_theme_contract/config/component/ouds_button_config.dart';
import 'package:ouds_theme_contract/config/component/ouds_card_item_config.dart';
import 'package:ouds_theme_contract/config/component/ouds_progress_indicator_config.dart';
import 'package:ouds_theme_contract/config/component/ouds_text_input_config.dart';

class OudsThemeConfigModel extends InheritedWidget {
  final OudsAlertMessageConfig? alertMessage;
  final OudsButtonConfig? button;
  final OudsCardItemConfig? cardItem;
  final OudsProgressIndicatorConfig? progressIndicator;
  final OudsTextInputConfig? textInput;

  const OudsThemeConfigModel({
    this.alertMessage,
    this.button,
    this.cardItem,
    this.textInput,
    this.progressIndicator,
    required super.child,
    super.key,
  });

  static OudsThemeConfigModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OudsThemeConfigModel>();
  }

  @override
  bool updateShouldNotify(covariant OudsThemeConfigModel oldWidget) {
    return alertMessage != oldWidget.alertMessage ||
        button != oldWidget.button ||
        cardItem != oldWidget.cardItem ||
        textInput != oldWidget.textInput ||
        progressIndicator != oldWidget.progressIndicator;
  }
}
