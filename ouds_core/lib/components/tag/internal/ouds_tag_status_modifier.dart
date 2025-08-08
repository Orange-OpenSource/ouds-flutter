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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';


/// Used to apply the right background color associated to the hierarchy
class OudsTagStatusModifier {
  final BuildContext context;

  OudsTagStatusModifier(this.context);

  /// Returns the background color based on the tag status.
  Color getStatusColor(OudsTagStatus state,OudsTagHierarchy hierarchy) {
    final theme = OudsTheme.of(context).colorScheme(context);
    final isEmphasized = hierarchy == OudsTagHierarchy.emphasized;

    switch (state) {
      case OudsTagStatus.neutral:
        return isEmphasized
            ? theme.surfaceStatusNeutralEmphasized
            : theme.surfaceStatusNeutralMuted;
      case OudsTagStatus.accent:
        return isEmphasized
            ? theme.surfaceStatusAccentEmphasized
            : theme.surfaceStatusAccentMuted;
      case OudsTagStatus.positive:
        return isEmphasized
            ? theme.surfaceStatusPositiveEmphasized
            : theme.surfaceStatusPositiveMuted;
      case OudsTagStatus.info:
        return isEmphasized
            ? theme.surfaceStatusInfoEmphasized
            : theme.surfaceStatusInfoMuted;
      case OudsTagStatus.warning:
        return isEmphasized
            ? theme.surfaceStatusWarningEmphasized
            : theme.surfaceStatusWarningMuted;
      case OudsTagStatus.negative:
        return isEmphasized
            ? theme.surfaceStatusNegativeEmphasized
            : theme.surfaceStatusNegativeMuted;
      case OudsTagStatus.disabled:
        return theme.actionDisabled;
    }
  }

  /// Returns the text color based on the tag status.
  Color getStatusTextAndLoaderColor(OudsTagStatus state, OudsTagHierarchy hierarchy) {
    final theme = OudsTheme.of(context).colorScheme(context);
    final isEmphasized = hierarchy == OudsTagHierarchy.emphasized;

    switch (state) {
      case OudsTagStatus.neutral:
        return isEmphasized
            ? theme.contentOnStatusNeutralEmphasized
            : theme.contentOnStatusNeutralMuted;
      case OudsTagStatus.accent:
        return isEmphasized
            ? theme.contentOnStatusAccentEmphasized
            : theme.contentOnStatusAccentMuted;
      case OudsTagStatus.positive:
        return isEmphasized
            ? theme.contentOnStatusPositiveEmphasized
            : theme.contentOnStatusPositiveMuted;
      case OudsTagStatus.info:
        return isEmphasized
            ? theme.contentOnStatusInfoEmphasized
            : theme.contentOnStatusInfoMuted;
      case OudsTagStatus.warning:
        return isEmphasized
            ? theme.contentOnStatusWarningEmphasized
            : theme.contentOnStatusWarningMuted;
      case OudsTagStatus.negative:
        return isEmphasized
            ? theme.contentOnStatusNegativeEmphasized
            : theme.contentOnStatusNegativeMuted;
      case OudsTagStatus.disabled:
        return theme.contentOnActionDisabled;
    }
  }

  /// Return the icon color based on tag status
  Color getStatusIconColor(OudsTagStatus state, OudsTagHierarchy hierarchy) {
    final theme = OudsTheme.of(context).colorScheme(context);
    final isEmphasized = hierarchy == OudsTagHierarchy.emphasized;

    switch (state) {
      case OudsTagStatus.neutral:
        return isEmphasized
            ? theme.contentOnStatusNeutralEmphasized
            : theme.contentOnStatusNeutralMuted;
      case OudsTagStatus.accent:
        return isEmphasized
            ? theme.contentOnStatusAccentEmphasized
            : theme.contentStatusAccent;
      case OudsTagStatus.positive:
        return isEmphasized
            ? theme.contentOnStatusPositiveEmphasized
            : theme.contentStatusPositive;
      case OudsTagStatus.info:
        return isEmphasized
            ? theme.contentOnStatusInfoEmphasized
            : theme.contentStatusInfo;
      case OudsTagStatus.warning:
        return isEmphasized
            ? theme.contentOnStatusWarningEmphasized
            : theme.contentOnStatusWarningMuted;
      case OudsTagStatus.negative:
        return isEmphasized
            ? theme.contentOnStatusNegativeEmphasized
            : theme.contentStatusNegative;
      case OudsTagStatus.disabled:
        return theme.contentOnActionDisabled;
    }
  }

  /// Return the icon based on tag status
  String? getStatusIcon(OudsTagStatus state) {

    switch (state) {
      case OudsTagStatus.positive:
        return AppAssets.icons.tick;
      case OudsTagStatus.info:
        return AppAssets.icons.info;
      case OudsTagStatus.warning:
        return AppAssets.icons.warning;
      case OudsTagStatus.negative:
        return AppAssets.icons.error;
      case OudsTagStatus.neutral:
      case OudsTagStatus.accent:
      case OudsTagStatus.disabled:
        return null;
    }
  }

}
