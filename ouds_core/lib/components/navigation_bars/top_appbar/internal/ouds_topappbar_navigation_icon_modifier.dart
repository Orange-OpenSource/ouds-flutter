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

import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/components/navigation_bars/top_appbar/ouds_top_appbar.dart';


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

}
