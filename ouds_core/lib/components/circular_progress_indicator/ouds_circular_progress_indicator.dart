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
import 'package:ouds_theme_contract/ouds_theme.dart';

/// A temporary circular progress indicator component
/// used internally by several public components like text input.
class OudsCircularProgressIndicator extends StatelessWidget {
  const OudsCircularProgressIndicator({
    super.key,
    required this.color,
    this.progress,
  });

  final Color color;

  /// If null => indeterminate loader
  /// If not null => determinate loader
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final baseSize = OudsTheme.of(
      context,
    ).componentsTokens(context).button.sizeLoader;

    const double baseStrokeWidth = 3;

    return ExcludeSemantics(
      child: SizedBox(
        width: baseSize,
        height: baseSize,
        child: CircularProgressIndicator(
          value: progress,
          strokeWidth: baseStrokeWidth,
          strokeCap: StrokeCap.square,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
