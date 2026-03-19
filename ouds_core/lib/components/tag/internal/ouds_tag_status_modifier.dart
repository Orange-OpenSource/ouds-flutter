//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/tag/ouds_tag_icon_status.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the appearance
class OudsTagStatusModifier {
  final BuildContext context;

  late final _colors;

  OudsTagStatusModifier(this.context) {
    _colors = OudsTheme.of(context).colorScheme(context);
  }
  /// Returns the background color based on the tag status.
  // state param will be removed after deprecation
  Color? getStatusColor(OudsTagStatus? state, OudsTagIconStatus? tagIconStatus, OudsTagAppearance? appearance, bool isEnabled) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;

    if (!isEnabled) {
      return _colors.actionDisabled;
    }

    // This condition will be removed after deprecation
    if(state != null){
      switch (state) {
        case OudsTagStatus.neutral:
          return _getNeutralStatusColor(isEmphasized);
        case OudsTagStatus.accent:
          return _getAccentStatusColor(isEmphasized);
        case OudsTagStatus.positive:
          return _getPositiveStatusColor(isEmphasized);
        case OudsTagStatus.info:
          return _getInfoStatusColor(isEmphasized);
        case OudsTagStatus.warning:
          return _getWarningStatusColor(isEmphasized);
        case OudsTagStatus.negative:
          return _getNegativeStatusColor(isEmphasized);
      }
    }
    else if(tagIconStatus != null){
      return switch (tagIconStatus) {
        Neutral() => _getNeutralStatusColor(isEmphasized),
        Accent() => _getAccentStatusColor(isEmphasized),
        Positive() => _getPositiveStatusColor(isEmphasized),
        Info() => _getInfoStatusColor(isEmphasized),
        Warning() => _getWarningStatusColor(isEmphasized),
        Negative() => _getNegativeStatusColor(isEmphasized),
      };
    }

    return null;
  }

  Color _getNeutralStatusColor(bool isEmphasized){
    return isEmphasized ? _colors.surfaceInverseHigh : _colors.surfaceSecondary;
  }
  Color _getAccentStatusColor(bool isEmphasized){
    return isEmphasized ? _colors.surfaceStatusAccentEmphasized : _colors.surfaceStatusAccentMuted;
  }
  Color _getPositiveStatusColor(bool isEmphasized){
    return isEmphasized ? _colors.surfaceStatusPositiveEmphasized : _colors.surfaceStatusPositiveMuted;
  }
  Color _getInfoStatusColor(bool isEmphasized){
    return isEmphasized ? _colors.surfaceStatusInfoEmphasized : _colors.surfaceStatusInfoMuted;
  }
  Color _getWarningStatusColor(bool isEmphasized){
    return isEmphasized ? _colors.surfaceStatusWarningEmphasized : _colors.surfaceStatusWarningMuted;
  }
  Color _getNegativeStatusColor(bool isEmphasized){
    return isEmphasized ? _colors.surfaceStatusNegativeEmphasized : _colors.surfaceStatusNegativeMuted;
  }


  /// Returns the text color based on the tag status.
  // state param will be removed after deprecation
  Color? getStatusTextColor(OudsTagStatus? state, OudsTagIconStatus? tagIconStatus, OudsTagAppearance appearance, bool isLoading, bool isEnabled) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;

    if (isLoading) {
      return _colors.contentDefault;
    }
    if (!isEnabled) {
      return _colors.contentOnActionDisabled;
    }

    // This condition will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsTagStatus.neutral:
          return _getNeutralTextColor(isEmphasized);
        case OudsTagStatus.accent:
          return _getAccentTextColor(isEmphasized);
        case OudsTagStatus.positive:
          return _getPositiveTextColor(isEmphasized);
        case OudsTagStatus.info:
          return _getInfoTextColor(isEmphasized);
        case OudsTagStatus.warning:
          return _getWarningTextColor(isEmphasized);
        case OudsTagStatus.negative:
          return _getNegativeTextColor(isEmphasized);
      }
    }    else if(tagIconStatus != null){
      return switch (tagIconStatus) {
        Neutral() => _getNeutralTextColor(isEmphasized),
        Accent() => _getAccentTextColor(isEmphasized),
        Positive() => _getPositiveTextColor(isEmphasized),
        Info() => _getInfoTextColor(isEmphasized),
        Warning() => _getWarningTextColor(isEmphasized),
        Negative() => _getNegativeTextColor(isEmphasized),
      };
    }

    return null;
  }

  Color _getNeutralTextColor(bool isEmphasized){
    return isEmphasized ? _colors.contentInverse : _colors.contentDefault;
  }
  Color _getAccentTextColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusAccentEmphasized : _colors
        .contentOnStatusAccentMuted;
  }
  Color _getPositiveTextColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusPositiveEmphasized : _colors
        .contentOnStatusPositiveMuted;
  }
  Color _getInfoTextColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusInfoEmphasized : _colors
        .contentOnStatusInfoMuted;
  }
  Color _getWarningTextColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusWarningEmphasized : _colors
        .contentOnStatusWarningMuted;
  }
  Color _getNegativeTextColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusNegativeEmphasized : _colors
        .contentOnStatusNegativeMuted;
  }


  /// Return the icon color based on tag status
  // state param will be removed after deprecation
  Color getStatusIconColor(OudsTagStatus? state, OudsTagIconStatus? tagIconStatus, OudsTagAppearance appearance, bool isEnabled) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;

    if (!isEnabled) {
      return _colors.contentOnActionDisabled;
    }

    // this condition will be removed after deprecation
    if(state != null) {
      switch (state) {
        case OudsTagStatus.neutral:
          return _getNeutralIconColor(isEmphasized);
        case OudsTagStatus.accent:
          return _getAccentIconColor(isEmphasized);
        case OudsTagStatus.positive:
          return _getPositiveIconColor(isEmphasized);
        case OudsTagStatus.info:
          return _getInfoIconColor(isEmphasized);
        case OudsTagStatus.warning:
          return _getWarningIconColor(isEmphasized);
        case OudsTagStatus.negative:
          return _getNegativeIconColor(isEmphasized);
      }
    }else if(tagIconStatus != null){
      return switch (tagIconStatus) {
        Neutral() => _getNeutralIconColor(isEmphasized),
        Accent() => _getAccentIconColor(isEmphasized),
        Positive() => _getPositiveIconColor(isEmphasized),
        Info() => _getInfoIconColor(isEmphasized),
        Warning() => _getWarningIconColor(isEmphasized),
        Negative() => _getNegativeIconColor(isEmphasized),
      };
    }

    return Colors.black;
  }

  Color _getNeutralIconColor(bool isEmphasized){
    return isEmphasized ? _colors.contentInverse : _colors.contentDefault;
  }
  Color _getAccentIconColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusAccentEmphasized : _colors
        .contentStatusAccent;
  }
  Color _getPositiveIconColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusPositiveEmphasized : _colors
        .contentStatusPositive;
  }
  Color _getInfoIconColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusInfoEmphasized : _colors
        .contentStatusInfo;
  }
  Color _getWarningIconColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusWarningEmphasized : _colors
        .contentStatusWarning;
  }
  Color _getNegativeIconColor(bool isEmphasized){
    return isEmphasized ? _colors.contentOnStatusNegativeEmphasized : _colors
        .contentStatusNegative;
  }

  /// Return the icon based on tag status
  // state param will be removed after deprecation
  String? getStatusIcon(OudsTagStatus? state, OudsTagIconStatus? tagIconStatus) {

    // this condition will be removed after deprecation
    if(state != null){
      switch (state) {
        case OudsTagStatus.positive:
          return AppAssets.icons.componentAlertTickConfirmationFill;
        case OudsTagStatus.info:
          return AppAssets.icons.componentAlertInformationFill;
        case OudsTagStatus.warning:
          return AppAssets.icons.componentAlertWarningExternalShape;
        case OudsTagStatus.negative:
          return AppAssets.icons.componentAlertImportantFill;
        case OudsTagStatus.neutral:
        case OudsTagStatus.accent:
          return null;
      }
    }else
      // Handle the new 'tagIconStatus' API
    if (tagIconStatus != null) {
      return switch (tagIconStatus) {

      // For those statuses, the icon is fixed and defined here.
        Positive() => AppAssets.icons.componentAlertTickConfirmationFill,
        Info() => AppAssets.icons.componentAlertInformationFill,
        Warning() => AppAssets.icons.componentAlertWarningExternalShape,
        Negative() => AppAssets.icons.componentAlertImportantFill,

      // For the other Accent and Neutral the icon should be defined by user
        _ => null
      };
    }
    return null;
  }

  /// Retrieve the asset name defined by the user in tagIconStatus (for Neutral and Accent statuses).
  String? getAssetsName(OudsTagIconStatus? tagIconStatus) {
    if (tagIconStatus == null) {
      return null;
    }

    // Extract the 'icon' property only from Neutral and Accent types.
    return switch (tagIconStatus) {
    // If the type is Neutral or Accent, extract the 'icon' value into the 'assets' variable and return it.
      Neutral(icon: final assets) => assets,
      Accent(icon: final assets) => assets,
    // For all other status types (Positive, Info, etc.), return null
    // as their icons are fixed and not user-defined.
      _ => null,
    };
  }
}
