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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';

/// Utility methods used by OUDS progress indicators.
///
/// This class centralizes common formatting and mapping logic shared by
/// circular and linear progress indicator implementations.
class OudsProgressIndicatorUtils {
  /// Returns the [Alignment] corresponding to the helper text alignment option.
  ///
  /// This is used by the linear progress indicator to position the helper text
  /// below the component.
  static Alignment getTextAlign(
    OudsProgressIndicatorHelperTextAlignment alignment,
  ) {
    switch (alignment) {
      case OudsProgressIndicatorHelperTextAlignment.left:
        return Alignment.centerLeft;
      case OudsProgressIndicatorHelperTextAlignment.center:
        return Alignment.center;
      case OudsProgressIndicatorHelperTextAlignment.right:
        return Alignment.centerRight;
    }
  }

  /// Returns the progress value only when the indicator is determinate.
  ///
  /// For indeterminate indicators, this method returns `null` so that the
  /// underlying Flutter progress indicator switches to its indeterminate state.
  static double? getProgressValue(
    OudsProgressIndicatorType? progressType,
    double? progress,
  ) {
    return progressType == OudsProgressIndicatorType.determinate
        ? progress
        : null;
  }

  /// Builds the helper text displayed below a linear progress indicator.
  ///
  /// If [percentage] is `true`, the helper text is generated from [progress]
  /// and formatted as a percentage.
  ///
  /// If [percentage] is `false`, the provided [helperText] is returned.
  ///
  /// Returns an empty string when no helper text should be displayed.
  static String buildHelperText(
    bool percentage,
    bool spaceBeforePercentage,
    double? progress, // ou double/int selon ton type réel
    String? helperText,
  ) {
    final progressValue = progress != null ? progress * 100 : 0;
    if (percentage) {
      return spaceBeforePercentage ? '$progressValue %' : '$progressValue%';
    }

    if (helperText != null) {
      return helperText;
    }

    return '';
  }

  static String? buildStatusSemanticsLabel(
    OudsLocalizations? localizations,
    OudsIconStatus status,
  ) {
    return status is Warning
        ? localizations?.core_common_warning_a11y
        : status is Negative
        ? localizations?.core_common_error_a11y
        : status is Info
        ? localizations?.core_common_info_a11y
        : null;
  }
}
