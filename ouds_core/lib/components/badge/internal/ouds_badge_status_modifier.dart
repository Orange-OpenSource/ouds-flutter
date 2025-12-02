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
import 'package:ouds_core/components/utilities/app_assets.dart';

enum OudsBadgeStatus {
  negative,
  accent,
  positive,
  info,
  warning,
  neutral,
}

/// Modifier class to handle color logic based on badge status.
class OudsBadgeStatusModifier {
  final BuildContext context;

  OudsBadgeStatusModifier(this.context);

  /// Returns the background color based on the badge status.
  Color getStatusColor(OudsBadgeStatus state, bool isEnabled) {
    final theme = OudsTheme.of(context).colorScheme(context);

    if(!isEnabled){
      return  theme.actionDisabled;
    }
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

  /// Returns the text and icon color based on the badge status.
  Color getStatusTextAndIconColor(OudsBadgeStatus state, bool isEnabled) {
    final theme = OudsTheme.of(context).colorScheme(context);

    if(!isEnabled){
      return theme.contentOnActionDisabled;
    }

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
  }

  /// Return the icon based on badge status
  String? getStatusIcon(OudsBadgeStatus state) {
    switch (state) {
      case OudsBadgeStatus.positive:
        return AppAssets.icons.componentAlertSuccess;
      case OudsBadgeStatus.info:
        return AppAssets.icons.componentAlertInformation;
      case OudsBadgeStatus.warning:
        return AppAssets.icons.componentAlertWarningExternalShape;
      case OudsBadgeStatus.negative:
        return AppAssets.icons.componentAlertImportant;
      case OudsBadgeStatus.neutral:
      case OudsBadgeStatus.accent:
        return null;
    }
  }
}
