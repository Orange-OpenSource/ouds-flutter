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
import 'package:ouds_core/components/navigation/ouds_navigation_bar_item.dart';

// --- Text-scale cap ----------------------------------------------------------
/// Maximum text-scale factor applied inside navigation bar items.
///
/// Capped at 160 % to prevent icon/label/badge overlap at large accessibility
/// text sizes on iOS.
const double kNavBarMaxTextScale = 1.6;

/// Returns a [TextScaler] capped at [kNavBarMaxTextScale].
///
/// Apply via a [MediaQuery] override so all descendants (labels, badges,
/// border ring) automatically respect the cap.
///
/// ```dart
/// MediaQuery(
///   data: MediaQuery.of(context).copyWith(
///     textScaler: clampNavBarTextScaler(context),
///   ),
///   child: child,
/// )
/// ```
TextScaler clampNavBarTextScaler(BuildContext context) =>
    MediaQuery.textScalerOf(context).clamp(maxScaleFactor: kNavBarMaxTextScale);

// --- Semantic label helpers --------------------------------------------------

/// Accessibility helper for OUDS navigation bar items.
///
/// Builds the semantic labels announced by TalkBack (Android) and
/// VoiceOver (iOS) for each navigation destination.
///
/// ### TalkBack reading order
///
/// On Android with a badge, TalkBack announces:
///
/// ```
/// "Label, 1 notification, Tab 2 of 3"
/// ```
///
/// This relies on a `Semantics` node with the badge description placed **below**
/// `NavigationDestination` in the item's `Column`. Material's `IndexedSemantics`
/// appends the positional info automatically.
///
/// > **Important**: the badge `Semantics` child must use `SizedBox(height: 1)`,
/// > not `SizedBox.shrink()`. A 0×0 rect causes Flutter to mark the node
/// > invisible and TalkBack will silently skip it.
///
/// ```dart
/// OudsNavigationBarA11y.buildTabSemanticLabel('Home', badge);
/// // → 'Home'              (no badge)
/// // → 'Home, 3 messages'  (with badge)
/// ```
abstract final class OudsNavigationBarA11y {
  /// Builds the semantic label for a navigation tab.
  ///
  /// Returns [label] alone when [badge] is `null`, or
  /// `"label, badge description"` when a badge is present.
  static String buildTabSemanticLabel(
    String label,
    OudsNavigationBarItemBadge? badge,
  ) {
    if (badge == null) return label;
    return '$label, ${badge.contentDescription}';
  }
}

/// Builds the accessible label for a navigation bar item.
///
/// Combines [label] with [badge]'s description: `"Label, badge description"`.
///
/// **Deprecated** — prefer [OudsNavigationBarA11y.buildTabSemanticLabel].
@Deprecated('Use OudsNavigationBarA11y.buildTabSemanticLabel instead.')
String buildNavItemAccessibleLabel(
  String label,
  OudsNavigationBarItemBadge? badge,
) {
  if (badge == null) return label;
  return '$label, ${badge.contentDescription}';
}
