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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/color/ouds_color_scheme.dart';

/// Used to apply the right background color associated to the appearance
class OudsTagStatusModifier {
  final BuildContext context;

  OudsTagStatusModifier(this.context);

  /// Returns the background color based on the tag status.
  Color? getStatusColor(
    OudsIconStatus? iconStatus,
    OudsTagAppearance? appearance,
    bool isEnabled,
  ) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return colorTheme.actionDisabled;
    }

    if (iconStatus != null) {
      return switch (iconStatus) {
        Neutral() => _getNeutralStatusColor(isEmphasized, colorTheme),
        Accent() => _getAccentStatusColor(isEmphasized, colorTheme),
        Positive() => _getPositiveStatusColor(isEmphasized, colorTheme),
        Info() => _getInfoStatusColor(isEmphasized, colorTheme),
        Warning() => _getWarningStatusColor(isEmphasized, colorTheme),
        Negative() => _getNegativeStatusColor(isEmphasized, colorTheme),
      };
    }

    return null;
  }

  /// Returns the background color for the **neutral** status.
  Color _getNeutralStatusColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.surfaceInverseHigh
        : colorTheme.surfaceSecondary;
  }

  /// Returns the background color for the **accent** status.
  Color _getAccentStatusColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.surfaceStatusAccentEmphasized
        : colorTheme.surfaceStatusAccentMuted;
  }

  /// Returns the background color for the **positive** status.
  Color _getPositiveStatusColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.surfaceStatusPositiveEmphasized
        : colorTheme.surfaceStatusPositiveMuted;
  }

  /// Returns the background color for the **info** status.
  Color _getInfoStatusColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.surfaceStatusInfoEmphasized
        : colorTheme.surfaceStatusInfoMuted;
  }

  /// Returns the background color for the **warning** status.
  Color _getWarningStatusColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.surfaceStatusWarningEmphasized
        : colorTheme.surfaceStatusWarningMuted;
  }

  /// Returns the background color for the **negative** status.
  Color _getNegativeStatusColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.surfaceStatusNegativeEmphasized
        : colorTheme.surfaceStatusNegativeMuted;
  }

  /// Returns the text color based on the tag status.
  Color? getStatusTextColor(
    OudsIconStatus? status,
    OudsTagAppearance appearance,
    bool isLoading,
    bool isEnabled,
  ) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (isLoading) {
      return colorTheme.contentDefault;
    }
    if (!isEnabled) {
      return colorTheme.contentOnActionDisabled;
    }

    if (status != null) {
      return switch (status) {
        Neutral() => _getNeutralTextColor(isEmphasized, colorTheme),
        Accent() => _getAccentTextColor(isEmphasized, colorTheme),
        Positive() => _getPositiveTextColor(isEmphasized, colorTheme),
        Info() => _getInfoTextColor(isEmphasized, colorTheme),
        Warning() => _getWarningTextColor(isEmphasized, colorTheme),
        Negative() => _getNegativeTextColor(isEmphasized, colorTheme),
      };
    }

    return null;
  }

  /// Returns the text color for the **neutral** status.
  Color _getNeutralTextColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized ? colorTheme.contentInverse : colorTheme.contentDefault;
  }

  /// Returns the text color for the **accent** status.
  Color _getAccentTextColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusAccentEmphasized
        : colorTheme.contentOnStatusAccentMuted;
  }

  /// Returns the text color for the **positive** status.
  Color _getPositiveTextColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusPositiveEmphasized
        : colorTheme.contentOnStatusPositiveMuted;
  }

  /// Returns the text color for the **info** status.
  Color _getInfoTextColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusInfoEmphasized
        : colorTheme.contentOnStatusInfoMuted;
  }

  /// Returns the text color for the **warning** status.
  Color _getWarningTextColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusWarningEmphasized
        : colorTheme.contentOnStatusWarningMuted;
  }

  /// Returns the text color for the **negative** status.
  Color _getNegativeTextColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusNegativeEmphasized
        : colorTheme.contentOnStatusNegativeMuted;
  }

  /// Return the icon color based on tag status
  Color getStatusIconColor(
    OudsIconStatus? iconStatus,
    OudsTagAppearance appearance,
    bool isEnabled,
  ) {
    final isEmphasized = appearance == OudsTagAppearance.emphasized;
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (!isEnabled) {
      return colorTheme.contentOnActionDisabled;
    }
    if (iconStatus != null) {
      return switch (iconStatus) {
        Neutral() => _getNeutralIconColor(isEmphasized, colorTheme),
        Accent() => _getAccentIconColor(isEmphasized, colorTheme),
        Positive() => _getPositiveIconColor(isEmphasized, colorTheme),
        Info() => _getInfoIconColor(isEmphasized, colorTheme),
        Warning() => _getWarningIconColor(isEmphasized, colorTheme),
        Negative() => _getNegativeIconColor(isEmphasized, colorTheme),
      };
    }

    return Colors.black;
  }

  /// Returns the icon color for the **neutral** status.
  Color _getNeutralIconColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized ? colorTheme.contentInverse : colorTheme.contentDefault;
  }

  /// Returns the icon color for the **accent** status.
  Color _getAccentIconColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusAccentEmphasized
        : colorTheme.contentStatusAccent;
  }

  /// Returns the icon color for the **positive** status.
  Color _getPositiveIconColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusPositiveEmphasized
        : colorTheme.contentStatusPositive;
  }

  /// Returns the icon color for the **info** status.
  Color _getInfoIconColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusInfoEmphasized
        : colorTheme.contentStatusInfo;
  }

  /// Returns the icon color for the **warning** status.
  Color _getWarningIconColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusWarningEmphasized
        : colorTheme.contentStatusWarning;
  }

  /// Returns the icon color for the **negative** status.
  Color _getNegativeIconColor(bool isEmphasized, OudsColorScheme colorTheme) {
    return isEmphasized
        ? colorTheme.contentOnStatusNegativeEmphasized
        : colorTheme.contentStatusNegative;
  }

  /// Return the icon based on tag status
  String? getStatusIcon(OudsIconStatus? iconStatus) {
    if (iconStatus != null) {
      return switch (iconStatus) {
        // For those statuses, the icon is fixed and defined here.
        Positive() => AppAssets.icons.componentAlertTickConfirmationFill,
        Info() => AppAssets.icons.componentAlertInformationFill,
        Warning() => AppAssets.icons.componentAlertWarningExternalShape,
        Negative() => AppAssets.icons.componentAlertImportantFill,

        // For the other Accent and Neutral the icon should be defined by user
        _ => null,
      };
    }
    return null;
  }

  /// Retrieve the asset name defined by the user in iconStatus (for Neutral and Accent statuses).
  String? getAssetsName(OudsIconStatus? iconStatus) {
    if (iconStatus == null) {
      return null;
    }

    // Extract the 'icon' property only from Neutral and Accent types.
    return switch (iconStatus) {
      // If the type is Neutral or Accent, extract the 'icon' value into the 'assets' variable and return it.
      Neutral(icon: final assets) => assets,
      Accent(icon: final assets) => assets,
      // For all other status types (Positive, Info, etc.), return null
      // as their icons are fixed and not user-defined.
      _ => null,
    };
  }
}
