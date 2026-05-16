/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */
/// @nodoc
library;

import 'package:flutter/material.dart';

/// Centralized accessibility utilities for OUDS Navigation components.
///
/// This class manages text scaling constraints for both [OudsNavigationBar] (Android/Material)
/// and [OudsTabBar] (iOS/Cupertino) to ensure consistent accessibility behavior and prevent
/// layout overflow when users enable zoom features.
///
/// ## Related Issues:
/// - Issue #625: Android TalkBack inconsistent reading order with badges
/// - Issue #627: iOS zoom overflow at 190-235% zoom levels
class OudsNavigationA11y {
  /// Maximum text scale factor for navigation items (Issue #627).
  ///
  /// Clamped to 108% to prevent item overflow that occurs between 190-235% zoom levels.
  /// This constraint applies to:
  /// - Icon scaling (26px icon → 28.08px at 108%)
  /// - Label text scaling
  /// - Badge size adjustments
  /// - Indicator visibility area
  ///
  /// Rationale: At 108% zoom, all components remain within their allocated space without
  /// exceeding the navigation bar container boundaries, while still supporting the maximum
  /// accessibility zoom that users expect.
  static const double maxTextScaleFactor = 1.08;

  /// Wraps a navigation widget with accessibility text scaling constraints.
  ///
  /// This helper method ensures consistent text and icon sizing across navigation items
  /// by limiting zoom enlargement to [maxTextScaleFactor]. Applied at the bar level
  /// (wrapping the entire [NavigationBar] or [CupertinoTabBar]) to work seamlessly with
  /// composite semantic labels and badge exclusion semantics.
  ///
  /// Parameters:
  /// - [child]: The navigation widget to wrap (e.g., [NavigationBar], [CupertinoTabBar])
  ///
  /// Returns:
  /// The widget wrapped with [MediaQuery.withClampedTextScaling], which enforces:
  /// - minScaleFactor: 1.0 (no minimum constraint, respects system defaults below 108%)
  /// - maxScaleFactor: 1.08 (108%, preventing overflow above this level)
  ///
  /// Example:
  /// ```dart
  /// return OudsNavigationA11y.withA11yScaling(navigationBar);
  /// ```
  static Widget withA11yScaling(Widget child) {
    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 1.0,
      maxScaleFactor: maxTextScaleFactor,
      child: child,
    );
  }
}
