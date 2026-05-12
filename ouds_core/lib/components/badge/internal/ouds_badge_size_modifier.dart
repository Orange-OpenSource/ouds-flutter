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
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

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

  double getBadgeIconOffsetsPadding(
    OudsBadgeStatus? state,
    OudsBadgeSize? size,
    OudsIconStatus? status,
  ) {
    final badgeToken = OudsTheme.of(context).componentsTokens(context).badge;
    if ((state != null &&
            (state != OudsBadgeStatus.neutral &&
                state != OudsBadgeStatus.accent)) ||
        !OudsIconStatus.functionalStatuses.contains(status.runtimeType)) {
      switch (size) {
        case OudsBadgeSize.xsmall:
          return badgeToken.spaceInsetXsmall;
        case OudsBadgeSize.small:
          return badgeToken.spaceInsetSmall;
        case OudsBadgeSize.medium:
        case OudsBadgeSize.large:
          return badgeToken.spaceInsetMediumLarge;
        case null:
          return badgeToken.sizeMedium;
      }
    }
    return 0.0;
  }
}
