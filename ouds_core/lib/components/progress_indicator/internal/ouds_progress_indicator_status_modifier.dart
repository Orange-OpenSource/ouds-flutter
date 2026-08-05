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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Resolves the indicator color from the active theme based on an [OudsIconStatus].
class OudsProgressIndicatorStatusModifier {
  final BuildContext context;

  /// Creates a status modifier bound to the given [context].
  OudsProgressIndicatorStatusModifier(this.context);

  /// Returns the indicator color based on the progress indicator status.
  Color getStatusColor(OudsIconStatus status) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    return switch (status) {
      Neutral() => colorTheme.contentDefault,
      Accent() => colorTheme.contentStatusAccent,
      Positive() => colorTheme.contentStatusPositive,
      Info() => colorTheme.contentStatusInfo,
      Warning() => colorTheme.contentStatusWarning,
      Negative() => colorTheme.contentStatusNegative,
    };
  }
}
