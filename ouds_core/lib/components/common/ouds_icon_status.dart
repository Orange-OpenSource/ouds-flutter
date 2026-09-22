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
/// {@category Alert}
library;

import 'dart:ui';

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
/// // A tag with a custom user-provided icon with untined icon
/// OudsTag(
///   label: 'Custom',
///   iconStatus: Neutral(icon: 'assets/my_custom_icon.svg, tinted = false'),
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

  /// Returns the background color to apply behind the icon.
  ///
  /// A custom background is only applied when the icon is not tinted
  /// ([Neutral.tinted] or [Accent.tinted] is `false`). Otherwise, no
  /// background is applied and the theme default is used.
  Color? get getBackgroundColor => switch (this) {
    Neutral(tinted: false, backgroundColor: final bg) => bg,
    Accent(tinted: false, backgroundColor: final bg) => bg,
    _ => null,
  };

  /// Returns the custom icon asset path for non-functional statuses.
  ///
  /// Only [Neutral] and [Accent] statuses allow a user-provided icon. For
  /// functional statuses ([Positive], [Info], [Warning], [Negative]), this
  /// returns `null` since their icon is fixed by the design system.
  String? get nonFunctionalIcon => switch (this) {
    Neutral(icon: final assets) => assets,
    Accent(icon: final assets) => assets,
    _ => null,
  };

  /// Returns whether the icon is tinted.
  ///
  /// Only [Neutral] and [Accent] statuses allow a user-provided icon. For
  /// functional statuses ([Positive], [Info], [Warning], [Negative]), this
  /// returns `true` since their icon is always tinted by the design system.
  bool get isTinted => switch (this) {
    Neutral(tinted: final tinted) => tinted,
    Accent(tinted: final tinted) => tinted,
    _ => true,
  };
}

/// A status for general-purpose labels where the icon is customizable.
///
/// Use this status when the component's meaning is neutral and you want to provide
/// a specific icon.
class Neutral extends OudsIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  /// The label for accessibility when using a custom icon.
  ///
  /// This is required when [icon] is provided to ensure screen readers
  /// can describe the status to users.
  final String? semanticsLabel;

  ///  Controls whether the icon should be tinted with the theme color. Defaults to `true`.
  ///  When set to `false`, the icon is displayed with its original colors (e.g., for multi-color icons).
  ///   Note that untinted icons must ensure sufficient contrast with the background for accessibility reasons.
  final bool tinted;

  /// The background color to apply behind the icon.
  ///
  /// Only applicable when [tinted] is `false`. When [tinted] is `true`,
  /// this parameter is ignored and the theme's default background color is used instead.
  final Color? backgroundColor;

  const Neutral({
    this.icon,
    this.semanticsLabel,
    this.tinted = true,
    this.backgroundColor,
  }) : assert(
         backgroundColor == null || !tinted,
         'backgroundColor is only applicable when tinted is false. '
         'When tinted is true, the theme default background color is applied.',
       );
}

/// A status to highlight content related to discovery or special offers.
///
/// The icon for this status is customizable.
class Accent extends OudsIconStatus {
  /// The path to the custom SVG asset for the icon.
  final String? icon;

  /// The label for accessibility when using a custom icon.
  ///
  /// This is required when [icon] is provided to ensure screen readers
  /// can describe the status to users.
  final String? semanticsLabel;

  ///  Controls whether the icon should be tinted with the theme color. Defaults to `true`.
  ///  When set to `false`, the icon is displayed with its original colors (e.g., for multi-color icons).
  ///   Note that untinted icons must ensure sufficient contrast with the background for accessibility reasons.
  final bool tinted;

  /// The background color to apply behind the icon.
  ///
  /// Only applicable when [tinted] is `false`. When [tinted] is `true`,
  /// this parameter is ignored and the theme's default background color is used instead.
  final Color? backgroundColor;

  const Accent({
    this.icon,
    this.semanticsLabel,
    this.tinted = true,
    this.backgroundColor,
  }) : assert(
         backgroundColor == null || !tinted,
         'backgroundColor is only applicable when tinted is false. '
         'When tinted is true, the theme default background color is applied.',
       );
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
