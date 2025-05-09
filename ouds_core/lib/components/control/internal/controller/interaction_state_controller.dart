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

import 'package:get/get.dart';

class InteractionStateController extends GetxController {
  var isPressed = false.obs;
  var isHovered = false.obs;

  void setPressed(bool isPressed) {
    this.isPressed.value = isPressed;
  }

  void setHovered(bool isHovered) {
    this.isHovered.value = isHovered;
  }
}
