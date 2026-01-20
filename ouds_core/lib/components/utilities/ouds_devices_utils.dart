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

class OudsDevicesUtils {

  OudsDeviceType getOSDeviceType(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final shortestSide = size.shortestSide;

    // iPad typically has a shortest side greater than 600 pixels
    return shortestSide >= 600 ? OudsDeviceType.iPad : OudsDeviceType.iPhone;
  }
}

enum OudsDeviceType{
  iPhone,
  iPad

}