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
import 'package:ouds_core/components/badge/ouds_badge_icon_status.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Modifier class to handle color logic based on badge status.
class OudsBadgeStatusModifier {
  final BuildContext context;

  OudsBadgeStatusModifier(this.context);

  /// Returns the background color based on the badge status.
  // The param state will be removed after deprecation
  Color? getStatusColor(OudsBadgeStatus? state, OudsBadgeIconStatus? badgeIconStatus,bool isEnabled) {
    final theme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return theme.actionDisabled;
    }
    // it will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return theme.surfaceInverseHigh;
        case OudsBadgeStatus.accent:
          return theme.surfaceStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return theme.surfaceStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return theme.surfaceStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return theme.surfaceStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return theme.surfaceStatusNegativeEmphasized;
      }
    }
    // this will be called when badgeIconStatus is not null
    if(badgeIconStatus != null){
      return badgeIconStatus.statusColor;
    }
    return null;
  }

  /// Returns the text and icon color based on the badge status.
  // The param state will be removed after deprecation
  Color getStatusTextAndIconColor(OudsBadgeStatus? state, OudsBadgeIconStatus? badgeIconStatus, bool isEnabled) {
    final theme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return theme.contentOnActionDisabled;
    }

    if(state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return theme.contentInverse;
        case OudsBadgeStatus.accent:
          return theme.contentOnStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return theme.contentOnStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return theme.contentOnStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return theme.contentOnStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return theme.contentOnStatusNegativeEmphasized;
      }
    } else

    if(badgeIconStatus != null){
      return badgeIconStatus.iconColor;
    }

    return Colors.black;
  }

  /// Return the icon based on badge status
  // The param state will be removed after deprecation
  String? getStatusIcon(OudsBadgeStatus? state, OudsBadgeIconStatus? badgeIconStatus) {
    // will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsBadgeStatus.positive:
          return AppAssets.icons.componentAlertTickConfirmationFill;
        case OudsBadgeStatus.info:
          return AppAssets.icons.componentAlertInformationFill;
        case OudsBadgeStatus.warning:
          return AppAssets.icons.componentAlertWarningExternalShape;
        case OudsBadgeStatus.negative:
          return AppAssets.icons.componentAlertImportantFill;
        case OudsBadgeStatus.neutral:
        case OudsBadgeStatus.accent:
          return null;
      }
    }else
    if(badgeIconStatus != null
        && badgeIconStatus.badgeStatus != OudsBadgeStatus.neutral
        && badgeIconStatus.badgeStatus != OudsBadgeStatus.accent){
      return badgeIconStatus.icon;
    }
    return null;
  }

  /// Retrieve the asset name defined by user in badgeIconStatus
  String? getAssetsName(OudsBadgeIconStatus? badgeIconStatus){
    if(badgeIconStatus != null &&
        (badgeIconStatus.badgeStatus == OudsBadgeStatus.neutral || badgeIconStatus.badgeStatus == OudsBadgeStatus.accent)){
      return badgeIconStatus.icon;
    }
    return null;
  }
}
