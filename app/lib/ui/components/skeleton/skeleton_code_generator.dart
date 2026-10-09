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
import 'package:ouds_flutter_demo/ui/components/skeleton/skeleton_customization.dart';

///
/// The SkeletonCodeGenerator class is responsible for dynamically generating Flutter
/// code for the customization of a skeleton component. It leverages the skeleton's
/// customization state (animated,hasSecurityMargin) and generates the corresponding code
/// in string format, which can be used for rendering or previewing the skeleton with
/// the selected properties.
///
class SkeletonCodeGenerator {
  // Static method to generate the code based on skeleton customization state
  static String updateCode(BuildContext context) {
    final customizationState = SkeletonCustomization.of(context)!;

    final List<String> parameters = [
      "  hasSecurityMargin: ${customizationState.hasSecurityMargin}",
      "  animated: ${customizationState.hasAnimated}",
    ];

    return "OudsSkeleton(\n${parameters.join(',\n')},\n)";
  }
}
