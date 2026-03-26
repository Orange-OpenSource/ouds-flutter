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
  late final _colors;

  OudsBadgeStatusModifier(this.context){
    _colors = OudsTheme.of(context).colorScheme(context);
  }

  /// Returns the background color based on the badge status.
  //deprecation remove: The param state will be removed after deprecation
  Color? getStatusColor(OudsBadgeStatus? state, OudsIconStatus? status,bool isEnabled) {

    if (!isEnabled) {
      return _colors.actionDisabled;
    }
    //deprecation remove:  will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return _colors.surfaceInverseHigh;
        case OudsBadgeStatus.accent:
          return _colors.surfaceStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return _colors.surfaceStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return _colors.surfaceStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return _colors.surfaceStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return _colors.surfaceStatusNegativeEmphasized;
      }
    }else{
      if(status != null){
        return switch (status) {
          Neutral() => _colors.surfaceInverseHigh,
          Accent() => _colors.surfaceStatusAccentEmphasized,
          Positive() => _colors.surfaceStatusPositiveEmphasized,
          Info() => _colors.surfaceStatusInfoEmphasized,
          Warning() => _colors.surfaceStatusWarningEmphasized,
          Negative() => _colors.surfaceStatusNegativeEmphasized,
        };
      }
    }
    return null;
  }

  /// Returns the text and icon color based on the badge status.
  //deprecation remove: The param state will be removed after deprecation
  Color getStatusTextAndIconColor(OudsBadgeStatus? state, OudsIconStatus? status, bool isEnabled) {

    if (!isEnabled) {
      return _colors.contentOnActionDisabled;
    }

    //deprecation remove:  will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsBadgeStatus.neutral:
          return _colors.contentInverse;
        case OudsBadgeStatus.accent:
          return _colors.contentOnStatusAccentEmphasized;
        case OudsBadgeStatus.positive:
          return _colors.contentOnStatusPositiveEmphasized;
        case OudsBadgeStatus.info:
          return _colors.contentOnStatusInfoEmphasized;
        case OudsBadgeStatus.warning:
          return _colors.contentOnStatusWarningEmphasized;
        case OudsBadgeStatus.negative:
          return _colors.contentOnStatusNegativeEmphasized;
      }
    }else if(status != null){
      return switch (status) {
        Neutral() => _colors.contentInverse,
        Accent() => _colors.contentOnStatusAccentEmphasized,
        Positive() => _colors.contentOnStatusPositiveEmphasized,
        Info() => _colors.contentOnStatusInfoEmphasized,
        Warning() => _colors.contentOnStatusWarningEmphasized,
        Negative() => _colors.contentOnStatusNegativeEmphasized,
      };
    }
    return Colors.black;
  }

  /// Return the icon based on badge status
  //deprecation remove: The param state will be removed after deprecation
  String? getIcon(OudsBadgeStatus? state, OudsIconStatus? status) {

    //deprecation remove:  will be removed after deprecation
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
    }else{
      // Handle the new 'iconStatus' API
      if (status != null) {
        return switch (status) {
        // For those statuses, the icon is fixed and defined here.
          Positive() => AppAssets.icons.componentAlertTickConfirmationFill,
          Info() => AppAssets.icons.componentAlertInformationFill,
          Warning() => AppAssets.icons.componentAlertWarningExternalShape,
          Negative() => AppAssets.icons.componentAlertImportantFill,

        // For the other Accent and Neutral the icon should be defined by user
          _ => null
        };
      }
    }
    return null;
  }

  /// Retrieve the asset name defined by user in iconStatus
  String? getAssetsName(OudsIconStatus? status){
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
