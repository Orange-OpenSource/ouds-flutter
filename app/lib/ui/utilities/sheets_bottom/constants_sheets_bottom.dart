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
class ConstantSheetBottom {
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
  ///
  /// Also used as the peek height of the `OudsBottomSheetScaffold` in
  /// [CustomizeBottomSheet], i.e. the height of the sheet while collapsed
  /// (drag handle + title/chevron header only), since that header's natural
  /// height itself varies slightly between Android and iOS.
  static double collapsedHeight =
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? _collapsedHeightAndroid
      : _collapsedHeightDefault;

  /// Fraction of the true screen height the customization sheet should
  /// occupy once expanded (see [CustomizeBottomSheet]).
  ///
  /// `OudsBottomSheetScaffold.expand()` always targets 85 % of the height
  /// available to it (`OudsBottomSheetConstants.maxExpandedFraction`, an
  /// internal, non-configurable value in `ouds_core` — this mirrors
  /// Android's `OudsBottomSheetScaffold`, whose public API has no such
  /// parameter either). To make the expanded sheet only cover
  /// [expandedHeightFraction] of the real screen instead — without
  /// modifying `ouds_core` — [CustomizeBottomSheet] wraps the scaffold in a
  /// [MediaQuery] reporting a reduced height, computed so that 85 % of that
  /// reduced height equals [expandedHeightFraction] of the true screen
  /// height.
  static const double expandedHeightFraction = 0.6;

  /// Mirrors `OudsBottomSheetConstants.maxExpandedFraction` (currently
  /// `0.85`), the fraction of its available height
  /// `OudsBottomSheetScaffold.expand()` always targets internally. Needed
  /// here to compute the [MediaQuery] override producing
  /// [expandedHeightFraction]. Keep in sync if the `ouds_core` value ever
  /// changes.
  static const double oudsBottomSheetMaxExpandedFraction = 0.85;
}
