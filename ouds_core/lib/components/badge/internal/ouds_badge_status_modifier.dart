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
import 'package:ouds_theme_contract/ouds_theme.dart';

enum OudsBadgeStatus {
  negative,
  accent,
  positive,
  info,
  warning,
  neutral,
  disabled;
}

class OudsBadgeStatusModifier {
  final BuildContext context;

  OudsBadgeStatusModifier(this.context);

  /// Gets the background color based on the control state.
  Color getStatusColor(state) {
    final theme = OudsTheme.of(context).colorScheme(context);

    switch (state) {
      case OudsBadgeStatus.negative:
        return theme.surfaceStatusNegativeEmphasized;
      case OudsBadgeStatus.accent:
        return theme.surfaceStatusAccentEmphasized;
      case OudsBadgeStatus.positive:
        return theme.surfaceStatusPositiveEmphasized;
      case OudsBadgeStatus.info:
        return theme.surfaceStatusInfoEmphasized;
      case OudsBadgeStatus.warning:
        return theme.surfaceStatusWarningEmphasized;
      case OudsBadgeStatus.neutral:
        return theme.surfaceStatusNeutralEmphasized;
      case OudsBadgeStatus.disabled:
        return theme.actionDisabled;
      default:
        return theme.surfaceStatusNeutralEmphasized;
    }
  }

  Color getStatusTextColor(state) {
    final theme = OudsTheme.of(context).colorScheme(context);

    switch (state) {
      case OudsBadgeStatus.negative:
        return theme.contentOnStatusNegativeEmphasized;
      case OudsBadgeStatus.accent:
        return theme.contentOnStatusAccentEmphasized;
      case OudsBadgeStatus.positive:
        return theme.contentOnStatusPositiveEmphasized;
      case OudsBadgeStatus.info:
        return theme.contentOnStatusInfoEmphasized;
      case OudsBadgeStatus.warning:
        return theme.contentOnStatusWarningEmphasized;
      case OudsBadgeStatus.neutral:
        return theme.contentOnStatusNeutralEmphasized;
      case OudsBadgeStatus.disabled:
        return theme.actionDisabled;
      default:
        return theme.contentOnStatusNeutralEmphasized;
    }
  }
}
