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

/// {@category Badge}
library;

import 'package:ouds_core/components/badge/ouds_badge.dart';

/// Describes the configuration for an [OudsBadge] with an icon.
///
/// This sealed class defines the *intent* of the badge's appearance, which in
/// turn determines the icon to display and its associated colors. It is used with
/// the `OudsBadge.icon` constructor.
///
/// Subclasses are provided for each specific status:
/// *   [Neutral] and [Accent] allow for a user-defined custom icon.
/// *   [Positive], [Info], [Warning], and [Negative] use fixed icons defined
///     by the design system to convey a specific meaning.
///
/// ### Example
///
/// ```dart
/// // A badge with a fixed "success" icon.
/// OudsBadge.icon(
///   badgeIconStatus: Positive(),
///   child: Avatar(),
/// );
///
/// // A badge with a custom user-provided icon.
/// OudsBadge.icon(
///   badgeIconStatus: Neutral(icon: 'assets/my_custom_icon.svg'),
///   child: Avatar(),
/// );
///

sealed class OudsBadgeIconStatus {

  const OudsBadgeIconStatus();

}

/// A badge status for general-purpose labels where the icon is customizable.
///
/// Use this status when the badge's meaning is neutral and you want to provide
/// a specific icon.
class Neutral extends OudsBadgeIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  const Neutral({this.icon});
}

/// A badge status to highlight content related to discovery or special offers.
///
/// The icon for this status is customizable.
class Accent extends OudsBadgeIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  const Accent({this.icon});
}

/// A badge status that indicates success, completion, or approval.
///
/// This status uses a fixed, predefined icon from the design system.
class Positive extends OudsBadgeIconStatus {
  const Positive();
}

/// A badge status that provides informational context without urgency.
///
/// This status uses a fixed, predefined icon from the design system.
class Info extends OudsBadgeIconStatus {
  const Info();
}

/// A badge status that alerts the user to potential risks or cautions.
///
/// This status uses a fixed, predefined icon from the design system.
class Warning extends OudsBadgeIconStatus {
  const Warning();
}

/// A badge status that draws attention to errors or critical information.
///
/// This status uses a fixed, predefined icon from the design system.
class Negative extends OudsBadgeIconStatus {
  const Negative();
}