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

///
/// The CheckboxCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a checkbox component. It leverages the checkbox's
/// customization state, specifically the enabled and error states, and generates
/// the corresponding code in string format, which can be used for rendering or
/// previewing the checkbox with the selected properties.
///
class DividerCodeGenerator {
  // Static method to generate the code based on divider customization state
  static String updateCode(BuildContext context, bool vertical) {

    return """${functionName(vertical)}(\ncolor: \n)""";
  }


  // Method to get the function name according to the orientation of divider
  static String functionName(bool vertical) {
    // Return the function name  based on the orientation of divider
     return "${vertical == true ? 'OudsVerticalDivider' : 'OudsHorizontalDivider'}";
  }

}