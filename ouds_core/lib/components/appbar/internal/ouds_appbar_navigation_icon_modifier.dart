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
import 'package:ouds_core/components/appbar/ouds_appbar.dart';

class OudsAppBarNavigationIconModifier {

  OudsAppBarNavigationIconModifier();

  /// Retrieves the navigation icon for the appbar based on the provided [OudsAppBarNavigationIcon] enum.
  String? getNavigationIcon(OudsAppBarNavigationIcon? state,String? customLeadingIcon) {
    switch (state){
      case OudsAppBarNavigationIcon.back:
        return AppAssets.icons.componentButtonPrevious;
      case OudsAppBarNavigationIcon.close:
        return AppAssets.icons.componentButtonExpurge;
      case OudsAppBarNavigationIcon.menu:
        return AppAssets.icons.functionalNavigationMenu;
      case OudsAppBarNavigationIcon.custom:
        return customLeadingIcon;
        default:
        return null;

    }
  }

}
