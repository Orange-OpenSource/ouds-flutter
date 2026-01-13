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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/top_appbar/ouds_top_appbar.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';


class OudsTopAppBarNavigationIconModifier {

  OudsTopAppBarNavigationIconModifier();

  /// Retrieves the navigation icon for the navigation_bars based on the provided [OudsTopAppBarNavigationLeadingIcon] enum.
  String? getNavigationIcon(OudsTopAppBarNavigationLeadingIcon? state,String? customLeadingIcon) {
    switch (state){
      case OudsTopAppBarNavigationLeadingIcon.back:
        return AppAssets.icons.componentButtonPrevious;
      case OudsTopAppBarNavigationLeadingIcon.close:
        return AppAssets.icons.componentButtonExpurge;
      case OudsTopAppBarNavigationLeadingIcon.menu:
        return AppAssets.icons.functionalNavigationMenu;
      case OudsTopAppBarNavigationLeadingIcon.custom:
        return customLeadingIcon;
        default:
        return null;

    }
  }

  /// Retrieves the semantic label for the navigation_bars based on the provided [OudsTopAppBarNavigationLeadingIcon] enum.
  String? getNavigationIconLabel(BuildContext context,OudsTopAppBarNavigationLeadingIcon? state,String? semanticLabel) {
    switch (state){
      case OudsTopAppBarNavigationLeadingIcon.back:
        return OudsLocalizations.of(context)?.core_common_back_a11y;
      case OudsTopAppBarNavigationLeadingIcon.close:
        return OudsLocalizations.of(context)?.core_topAppBar_close_label_a11y;
      case OudsTopAppBarNavigationLeadingIcon.menu:
        return OudsLocalizations.of(context)?.core_topAppBar_menu_label_a11y;
      case OudsTopAppBarNavigationLeadingIcon.custom:
        return semanticLabel;
      default:
        return null;

    }
  }

}
