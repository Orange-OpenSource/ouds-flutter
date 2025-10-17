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

import 'package:flutter/material.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

enum OudsBadgeSize {
  xsmall,
  small,
  medium,
  large;
}

class OudsBadgeSizeModifier {
  final BuildContext context;

  OudsBadgeSizeModifier(this.context);

  /// Retrieves the size (double) for the badge based on the provided size enum.
  double getSize(OudsBadgeSize? state) {
    final theme = OudsTheme.of(context).componentsTokens(context).badge;

    switch (state) {
      case OudsBadgeSize.xsmall:
        return theme.sizeXsmall;
      case OudsBadgeSize.small:
        return theme.sizeSmall;
      case OudsBadgeSize.medium:
        return theme.sizeMedium;
      case OudsBadgeSize.large:
        return theme.sizeLarge;
      case null:
        return theme.sizeMedium;
    }
  }

  /// Retrieves the size of icon (double) for the badge based on the provided size enum.
  double? getIconSize(OudsBadgeSize? state) {
    final theme = OudsTheme.of(context).componentsTokens(context).badge;

    switch (state) {
      case OudsBadgeSize.xsmall:
      case OudsBadgeSize.small:
        return null;
      case OudsBadgeSize.medium:
        return theme.sizeXsmall + 2;
      case OudsBadgeSize.large:
        return theme.sizeSmall + 2;
      case null:
        return null;
    }
  }
}
