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

/// Badge types supported by the navigation bar  item in demo.
enum ItemBadge {
  /// No badge.
  none,

  /// A small dot badge.
  dot,

  /// A numeric counter badge.
  count;

  /// Localized label used as the "field name" for this enum in the UI (e.g. section title).
  static String enumName(BuildContext context) {
    return context.l10n.app_components_navigationBar_lastItemBadge_label;
  }
}

/// Provides localized display strings for [ItemBadge] values.
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
