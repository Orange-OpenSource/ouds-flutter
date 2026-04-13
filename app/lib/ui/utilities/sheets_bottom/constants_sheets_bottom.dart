/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/foundation.dart';

/// Defines static constants used for the customize Sheet Bottom component.
///
/// This class centralizes configuration values such as animation durations,
/// icon sizes, and layout dimensions used by the bottom sheet.
///
/// It also provides platform-specific values, such as different collapsed
/// heights for Android and other platforms.
class ConstantSheetBottom{
  /// Current rotation value for the chevron icon animation.
  static double chevronTurns = 0.5;

  /// Duration (in seconds) of the AnimatedContainer transition.
  static int animatedContainerDuration = 11150;

  /// Duration (in milliseconds) of the chevron rotation animation.
  static int animatedRotationDuration = 300;

  /// Radius applied to the top corners of the bottom sheet.
  static double sheetRadius = 2.5;

  /// Size of the expand/collapse icon.
  static double expandIconSize = 31;

  /// Collapsed height of the bottom sheet for Android devices.
  static const double _collapsedHeightAndroid = 80;

  /// Collapsed height of the bottom sheet for non-Android platforms.
  static const double _collapsedHeightDefault = 91;

  /// Platform-dependent collapsed height of the bottom sheet.
  static double collapsedHeight = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? _collapsedHeightAndroid
      : _collapsedHeightDefault;

}