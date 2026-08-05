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
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/components/tag/tag_enum.dart';

/// Represents the type of an OUDS ProgressIndicator.
enum ProgressIndicatorEnumType {
  determinate,
  indeterminate;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_common_type_tech;
  }
}

extension CustomElementType on ProgressIndicatorEnumType {
  String stringValue(BuildContext context) {
    switch (this) {
      case ProgressIndicatorEnumType.determinate:
        return capitalizeEnumValue(ProgressIndicatorEnumType.determinate);
      case ProgressIndicatorEnumType.indeterminate:
        return capitalizeEnumValue(ProgressIndicatorEnumType.indeterminate);
    }
  }
}

/// Represents the gap size of an OUDS ProgressIndicator.
enum ProgressIndicatorGapSizeEnum {
  defaultSize,
  small;

  static String enumName(BuildContext context) {
    return context.l10n.app_components_progressIndicator_gapSize_tech;
  }
}

extension CustomElementSize on ProgressIndicatorGapSizeEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ProgressIndicatorGapSizeEnum.defaultSize:
        return capitalizeEnumValue(ProgressIndicatorGapSizeEnum.defaultSize);
      case ProgressIndicatorGapSizeEnum.small:
        return capitalizeEnumValue(ProgressIndicatorGapSizeEnum.small);
    }
  }
}

/// Defines the horizontal alignment options for helper text displayed
/// with a progress indicator.
enum ProgressIndicatorHelperTextAlignmentEnum {
  left,
  center,
  right;

  static String enumName(BuildContext context) {
    return context
        .l10n
        .app_components_progressIndicator_helperTextAlignment_tech;
  }
}

extension CustomElementAlignment on ProgressIndicatorHelperTextAlignmentEnum {
  String stringValue(BuildContext context) {
    switch (this) {
      case ProgressIndicatorHelperTextAlignmentEnum.left:
        return capitalizeEnumValue(
          ProgressIndicatorHelperTextAlignmentEnum.left,
        );
      case ProgressIndicatorHelperTextAlignmentEnum.right:
        return capitalizeEnumValue(
          ProgressIndicatorHelperTextAlignmentEnum.right,
        );
      case ProgressIndicatorHelperTextAlignmentEnum.center:
        return capitalizeEnumValue(
          ProgressIndicatorHelperTextAlignmentEnum.center,
        );
    }
  }
}
