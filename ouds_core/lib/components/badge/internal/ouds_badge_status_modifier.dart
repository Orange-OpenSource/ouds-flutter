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
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Modifier class to handle color logic based on badge status.
class OudsBadgeStatusModifier {
  final BuildContext context;

  OudsBadgeStatusModifier(this.context);

  /// Returns the background color based on the badge status.
  //deprecation remove: The param state will be removed after deprecation
  Color? getStatusColor(
    OudsBadgeStatus? state,
    OudsIconStatus? status,
    bool isEnabled,
    bool iconType,
  ) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return (iconType &&
              status is! Warning &&
              status is! Accent &&
              status is! Neutral)
          ? Colors.transparent
          : colorTheme.actionDisabled;
    }

    if (iconType &&
        ((state != null &&
                (state != OudsBadgeStatus.neutral &&
                    state != OudsBadgeStatus.accent)) ||
            (status != null &&
                (OudsIconStatus.functionalStatuses.contains(
                  status.runtimeType,
                ))))) {
      return colorTheme.opacityTransparent;
    }
    //deprecation remove:  will be removed after deprecation
    if (state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return colorTheme.surfaceInverseHigh;
        case OudsBadgeStatus.accent:
          return colorTheme.surfaceStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return colorTheme.surfaceStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return colorTheme.surfaceStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return colorTheme.surfaceStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return colorTheme.surfaceStatusNegativeEmphasized;
      }
    } else {
      if (status != null) {
        final iconTokens = OudsTheme.of(context).componentsTokens(context).icon;

        return switch (status) {
          Neutral() => colorTheme.surfaceInverseHigh,
          Accent() => colorTheme.surfaceStatusAccentEmphasized,
          Positive() => colorTheme.surfaceStatusPositiveEmphasized,
          Info() => colorTheme.surfaceStatusInfoEmphasized,
          Warning() => iconTokens.colorContentStatusWarningExternalShape,
          Negative() => colorTheme.surfaceStatusNegativeEmphasized,
        };
      }
    }
    return null;
  }

  /// Returns the background color based on the badge status.
  //deprecation remove: The param state will be removed after deprecation
  Color? getTextColor(
    OudsBadgeStatus? state,
    OudsIconStatus? status,
    bool isEnabled,
  ) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return colorTheme.contentOnActionDisabled;
    }
    //deprecation remove:  will be removed after deprecation
    if (state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return colorTheme.contentInverse;
        case OudsBadgeStatus.accent:
          return colorTheme.contentOnStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return colorTheme.contentOnStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return colorTheme.contentOnStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return colorTheme.contentOnStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return colorTheme.contentOnStatusNegativeEmphasized;
      }
    } else {
      if (status != null) {
        return switch (status) {
          Neutral() => colorTheme.contentInverse,
          Accent() => colorTheme.contentOnStatusAccentEmphasized,
          Positive() => colorTheme.contentOnStatusPositiveEmphasized,
          Info() => colorTheme.contentOnStatusInfoEmphasized,
          Warning() => colorTheme.contentOnStatusWarningEmphasized,
          Negative() => colorTheme.contentOnStatusNegativeEmphasized,
        };
      }
    }
    return null;
  }

  /// Returns the icon color based on the badge status.
  //deprecation remove: The param state will be removed after deprecation
  Color getIconColor(
    OudsBadgeStatus? state,
    OudsIconStatus? status,
    bool isEnabled,
  ) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      if ((state == OudsBadgeStatus.accent ||
              state == OudsBadgeStatus.neutral) ||
          (!OudsIconStatus.functionalStatuses.contains(status.runtimeType))) {
        return colorTheme.contentOnActionDisabled;
      } else {
        return colorTheme.actionDisabled;
      }
    }

    //deprecation remove:  will be removed after deprecation
    if (state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return colorTheme.contentInverse;
        case OudsBadgeStatus.accent:
          return colorTheme.contentOnStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return colorTheme.contentStatusPositive;
        case OudsBadgeStatus.info:
          return colorTheme.contentStatusInfo;
        case OudsBadgeStatus.warning:
          return colorTheme.contentOnStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return colorTheme.contentStatusNegative;
      }
    } else if (status != null) {
      final iconTokens = OudsTheme.of(context).componentsTokens(context).icon;

      return switch (status) {
        Neutral() => colorTheme.contentInverse,
        Accent() => colorTheme.contentOnStatusAccentEmphasized,
        Positive() => colorTheme.contentStatusPositive,
        Info() => colorTheme.contentStatusInfo,
        Warning() => iconTokens.colorContentStatusWarningInternalShape,
        Negative() => colorTheme.contentStatusNegative,
      };
    }
    return Colors.black;
  }

  /// Return the icon based on badge status
  //deprecation remove: The param state will be removed after deprecation
  String? getIcon(OudsBadgeStatus? state, OudsIconStatus? status) {
    //deprecation remove:  will be removed after deprecation
    if (state != null) {
      switch (state) {
        case OudsBadgeStatus.positive:
          return AppAssets.icons.badgeIconTickConfirmationFill;
        case OudsBadgeStatus.info:
          return AppAssets.icons.badgeIconInfoFill;
        case OudsBadgeStatus.warning:
          return AppAssets.icons.componentAlertWarningExternalShape;
        case OudsBadgeStatus.negative:
          return AppAssets.icons.badgeIconErrorFill;
        case OudsBadgeStatus.neutral:
        case OudsBadgeStatus.accent:
          return null;
      }
    } else {
      // Handle the new 'iconStatus' API
      if (status != null) {
        return switch (status) {
          // For those statuses, the icon is fixed and defined here.
          Positive() => AppAssets.icons.badgeIconTickConfirmationFill,
          Info() => AppAssets.icons.badgeIconInfoFill,
          Warning() => null,
          Negative() => AppAssets.icons.badgeIconErrorFill,

          // For the other Accent and Neutral the icon should be defined by user
          _ => null,
        };
      }
    }
    return null;
  }

  /// Retrieve the asset name defined by user in iconStatus
  String? getAssetsName(OudsIconStatus? status) {
    if (status == null) {
      return null;
    }

    // Extract the 'icon' property only from Neutral and Accent types.
    return switch (status) {
      // If the type is Neutral or Accent, extract the 'icon' value into the 'assets' variable and return it.
      Neutral(icon: final assets) => assets,
      Accent(icon: final assets) => assets,
      // For all other status types (Positive, Info, etc.), return null
      // as their icons are fixed and not user-defined.
      _ => null,
    };
  }
}
