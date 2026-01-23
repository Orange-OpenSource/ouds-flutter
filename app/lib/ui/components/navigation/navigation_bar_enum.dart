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

enum ItemBadge {
  none,
  dot,
  count;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_navigationBar_lastItemBadge_label;
  }
}

extension CustomElementStyle on ItemBadge {
  String stringValue(BuildContext context) {
    switch (this) {
      case ItemBadge.none:
        return context.l10n.app_components_common_none_label;
      case ItemBadge.dot:
        return context.l10n.app_components_common_dot_label;
      case ItemBadge.count:
        return context.l10n.app_components_badge_countType_label;
    }
  }
}
