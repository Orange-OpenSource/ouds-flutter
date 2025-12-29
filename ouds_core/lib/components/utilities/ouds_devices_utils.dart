

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