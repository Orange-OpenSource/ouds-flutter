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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';


enum CardContentEnum {
  simpleContent,

  useCase;

  /// Returns the localized label for the content selector.
  static String enumName(BuildContext context) {
    return context.l10n.app_components_card_content_exemple_tech;
  }
}

/// Extension providing user-facing string representations for [CardContentEnum].
extension CustomElementAppearance on CardContentEnum {
  /// Returns the display label for this content option.
  String stringValue(BuildContext context) {
    switch (this) {
      case CardContentEnum.simpleContent:
        return capitalizeEnumValue(CardContentEnum.simpleContent);
      case CardContentEnum.useCase:
        return capitalizeEnumValue(CardContentEnum.useCase);
    }
  }
}


enum CardStyleEnum {
  filled,
  outlined,
  elevated;

  /// Returns the localized label for the style selector.
  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_style_label;
  }
}

extension CustomElementStyle on CardStyleEnum {
  /// Returns the localized label for this card style.
  String stringValue(BuildContext context) {
    switch (this) {
      case CardStyleEnum.filled:
        return context.l10n.app_components_card_style_filled_tech;
      case CardStyleEnum.outlined:
        return context.l10n.app_components_card_style_outlined_tech;
      case CardStyleEnum.elevated:
        return context.l10n.app_components_card_style_elevated_tech;
    }
  }
}
