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
/// {@category Tag}
library;

import 'package:ouds_core/components/badge/ouds_badge.dart';

/// Describes the configuration for an [OudsBadge] / [OudsTag] with an icon.
///
/// This sealed class defines the *intent* of the component's appearance, which in
/// turn determines the icon to display and its associated colors.
///
/// Subclasses are provided for each specific status:
/// *   [Neutral] and [Accent] allow for a user-defined custom icon.
/// *   [Positive], [Info], [Warning], and [Negative] use fixed icons defined
///     by the design system to convey a specific meaning.
///
/// ### Example usage in [OudsBadge]
///
/// ```dart
/// // A badge with a fixed "success" icon.
/// OudsBadge.icon(
///   iconStatus: Positive(),
///   child: Avatar(),
/// );
///
/// // A badge with a custom user-provided icon.
/// OudsBadge.icon(
///   iconStatus: Neutral(icon: 'assets/my_custom_icon.svg'),
///   child: Avatar(),
/// );
///
/// ### Example usage in [OudsTag]
///
/// ```dart
/// // A tag with a fixed "success" icon.
/// OudsTag(
///   label: 'Success',
///   iconStatus: Positive(),
/// );
///
/// // A tag with a custom user-provided icon.
/// OudsTag(
///   label: 'Custom',
///   iconStatus: Neutral(icon: 'assets/my_custom_icon.svg'),
/// );
/// ```
///
sealed class OudsIconStatus {
  const OudsIconStatus();

  /// A static list containing the types of all functional statuses.
  ///
  /// This can be used to easily check if a given status instance belongs
  /// to the functional category (Positive, Info, Warning, Negative).
  ///
  /// ### Example
  /// ```dart
  /// final myStatus = Positive();
  /// final isFunctional = OudsIconStatus.functionalStatuses.contains(myStatus.runtimeType);
  /// // isFunctional will be true
  /// ```
  static const List<Type> functionalStatuses = [
    Positive,
    Info,
    Warning,
    Negative,
  ];
}

/// A status for general-purpose labels where the icon is customizable.
///
/// Use this status when the component's meaning is neutral and you want to provide
/// a specific icon.
class Neutral extends OudsIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  const Neutral({this.icon});
}

/// A status to highlight content related to discovery or special offers.
///
/// The icon for this status is customizable.
class Accent extends OudsIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  const Accent({this.icon});
}

/// A status that indicates success, completion, or approval.
///
/// This status uses a fixed, predefined icon from the design system.
class Positive extends OudsIconStatus {}

/// A status that provides informational context without urgency.
///
/// This status uses a fixed, predefined icon from the design system.
class Info extends OudsIconStatus {}

/// A status that alerts the user to potential risks or cautions.
///
/// This status uses a fixed, predefined icon from the design system.
class Warning extends OudsIconStatus {}

/// A status that draws attention to errors or critical information.
///
/// This status uses a fixed, predefined icon from the design system.
class Negative extends OudsIconStatus {}
