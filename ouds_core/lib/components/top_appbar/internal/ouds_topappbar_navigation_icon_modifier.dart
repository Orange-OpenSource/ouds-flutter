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
import 'package:ouds_core/components/top_appbar/ouds_topappbar.dart';

class OudsTopAppBarNavigationIconModifier {

  OudsTopAppBarNavigationIconModifier();

  /// Retrieves the navigation icon for the topappbar based on the provided [OudsTopAppBarNavigationIcon] enum.
  String? getNavigationIcon(OudsTopAppBarNavigationIcon? state,String? customLeadingIcon) {
    switch (state){
      case OudsTopAppBarNavigationIcon.back:
        return AppAssets.icons.componentButtonPrevious;
      case OudsTopAppBarNavigationIcon.close:
        return AppAssets.icons.componentButtonExpurge;
      case OudsTopAppBarNavigationIcon.menu:
        return AppAssets.icons.functionalNavigationMenu;
      case OudsTopAppBarNavigationIcon.custom:
        return customLeadingIcon;
        default:
        return null;

    }
  }

}
