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

import 'package:flutter/animation.dart';

/// Internal constants shared across OUDS bottom sheet components.
class OudsBottomSheetConstants {
  OudsBottomSheetConstants._();

  /// Width of the drag handle pill.
  static const double handleWidth = 32.0;

  /// Height of the drag handle pill.
  static const double handleHeight = 4.0;

  /// Default sheet peek height, matching Material's `BottomSheetDefaults.SheetPeekHeight`.
  static const double sheetPeekHeight = 56.0;

  /// Radius of the drag handle pill corners.
  static const double handleRadius = 2.0;

  /// Animation duration for bottom sheet size changes (in milliseconds).
  /// Also used as the velocity threshold (px/s) to trigger expand/collapse on fling gesture.
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Animation curve for bottom sheet size changes.
  static const Curve animationCurve = Curves.easeInOut;

  /// Maximum fraction of available body height for the expanded standard sheet.
  static const double maxExpandedFraction = 0.85;

  /// Maximum fraction of available body height for the modal sheet.
  static const double modalMaxHeightFraction = 0.95;
}
