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

/// Defines the window width size classes for responsive design.
///
/// - [extraCompact]: For very small screens (e.g., small phones).
/// - [compact]: For standard mobile screens.
/// - [medium]: For tablets and large screens.
enum OudsWindowWidthSizeClass { extraCompact, compact, medium }

/// Utility class for determining the current window width size class and
/// selecting responsive values based on the screen width.
///
/// This class provides helpers to:
/// - Get the current [OudsWindowWidthSizeClass] from a [BuildContext].
/// - Select a value based on the size class (for 3 or 2 breakpoints).
///
/// Example usage:
/// ```dart
/// final sizeClass = OudsWindowSizeClassUtil.of(context);
/// final value = OudsWindowSizeClassUtil.select(
///   sizeClass: sizeClass,
///   extraCompact: 8.0,
///   compact: 12.0,
///   medium: 16.0,
/// );
/// ```
class OudsWindowSizeClassUtil {
  /// Returns the [OudsWindowWidthSizeClass] for the current screen width.
  ///
  /// - [extraCompact]: width < 390
  /// - [compact]: 390 <= width < 600
  /// - [medium]: width >= 600
  static OudsWindowWidthSizeClass of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 390) {
      return OudsWindowWidthSizeClass.extraCompact;
    } else if (width < 600) {
      return OudsWindowWidthSizeClass.compact;
    } else {
      return OudsWindowWidthSizeClass.medium;
    }
  }

  /// Selects a value based on the [OudsWindowWidthSizeClass].
  ///
  /// Example:
  /// ```dart
  /// final value = OudsWindowSizeClassUtil.select(
  ///   sizeClass: sizeClass,
  ///   extraCompact: 8.0,
  ///   compact: 12.0,
  ///   medium: 16.0,
  /// );
  /// ```
  static T select<T>({
    required OudsWindowWidthSizeClass sizeClass,
    required T extraCompact,
    required T compact,
    required T medium,
  }) {
    switch (sizeClass) {
      case OudsWindowWidthSizeClass.extraCompact:
        return extraCompact;
      case OudsWindowWidthSizeClass.compact:
        return compact;
      case OudsWindowWidthSizeClass.medium:
        return medium;
    }
  }

  /// Selects a value for mobile/tablet breakpoints only.
  ///
  /// [mobile] is used for [extraCompact] and [compact], [tablet] for [medium].
  ///
  /// Example:
  /// ```dart
  /// final value = OudsWindowSizeClassUtil.selectMobileTablet(
  ///   sizeClass: sizeClass,
  ///   mobile: 12.0,
  ///   tablet: 20.0,
  /// );
  /// ```
  static T selectMobileTablet<T>({
    required OudsWindowWidthSizeClass sizeClass,
    required T mobile,
    required T tablet,
  }) {
    switch (sizeClass) {
      case OudsWindowWidthSizeClass.medium:
        return tablet;
      case OudsWindowWidthSizeClass.extraCompact:
      case OudsWindowWidthSizeClass.compact:
        return mobile;
    }
  }
}
