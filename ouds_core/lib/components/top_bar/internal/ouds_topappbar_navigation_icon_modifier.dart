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
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';


class OudsTopAppBarNavigationIconModifier {

  OudsTopAppBarNavigationIconModifier();

  /// Retrieves the navigation icon for the top app bar based on the provided [OudsTopBarActionType] enum.
  String? getNavigationIcon(OudsTopBarActionType? type,String? customLeadingIcon) {
    switch (type){
      case OudsTopBarActionType.back:
        return AppAssets.icons.componentButtonPrevious;
      case OudsTopBarActionType.close:
        return AppAssets.icons.componentButtonExpurge;
      case OudsTopBarActionType.menu:
        return AppAssets.icons.functionalNavigationMenu;
      case OudsTopBarActionType.custom:
        return customLeadingIcon;
      default:
        return null;

    }
  }

  /// Retrieves the semantic label for the top app bar based on the provided [OudsTopBarActionType] enum.
  String? getNavigationIconLabel(BuildContext context,OudsTopBarActionType? type,String? semanticLabel) {
    switch (type){
      case OudsTopBarActionType.back:
        return OudsLocalizations.of(context)?.core_topAppBar_backNavigationIcon_a11y;
      case OudsTopBarActionType.close:
        return OudsLocalizations.of(context)?.core_topAppBar_closeNavigationIcon_a11y;
      case OudsTopBarActionType.menu:
        return OudsLocalizations.of(context)?.core_topAppBar_menuNavigationIcon_a11y;
      case OudsTopBarActionType.custom:
        return semanticLabel;
      default:
        return null;

    }
  }
}