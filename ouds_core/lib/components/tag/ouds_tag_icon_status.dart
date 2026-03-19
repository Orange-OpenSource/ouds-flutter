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

/// {@category Tag}
library;

/// Describes the configuration for an [OudsTag]'s icon and status.
///
/// This sealed class defines the *intent* of the tag's appearance, which in
/// turn determines the icon to display and its associated colors. It is used with
/// the `OudsTag` widget.
///
/// Subclasses are provided for each specific status:
/// *   [Neutral] and [Accent] allow for a user-defined custom icon.
/// *   [Positive], [Info], [Warning], and [Negative] use fixed icons defined
///     by the design system to convey a specific meaning.
///
/// ### Example
///
/// ```dart
/// // A tag with a fixed "success" icon.
/// OudsTag(
///   label: 'Success',
///   tagIconStatus: Positive(),
/// );
///
/// // A tag with a custom user-provided icon.
/// OudsTag(
///   label: 'Custom',
///   tagIconStatus: Neutral(icon: 'assets/my_custom_icon.svg'),
/// );
/// ```
sealed class OudsTagIconStatus {

  const OudsTagIconStatus();
}

/// A tag status for general-purpose labels where the icon is customizable.
///
/// Use this status when the tag's meaning is neutral and you want to provide
/// a specific icon.
class Neutral extends OudsTagIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  const Neutral({this.icon});
}

/// A tag status to highlight content related to discovery or special offers.
///
/// The icon for this status is customizable.
class Accent extends OudsTagIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  const Accent({this.icon});
}

/// A tag status that indicates success, completion, or approval.
///
/// This status uses a fixed, predefined icon from the design system.
class Positive extends OudsTagIconStatus {
  const Positive();
}

/// A tag status that provides informational context without urgency.
///
/// This status uses a fixed, predefined icon from the design system.
class Info extends OudsTagIconStatus {
  const Info();
}

/// A tag status that alerts the user to potential risks or cautions.
///
/// This status uses a fixed, predefined icon from the design system.
class Warning extends OudsTagIconStatus {
  const Warning();
}

/// A tag status that draws attention to errors or critical information.
///
/// This status uses a fixed, predefined icon from the design system.
class Negative extends OudsTagIconStatus {
  const Negative();
}