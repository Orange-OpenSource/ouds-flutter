// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.

/// {@category Card}
library;

/// The surface treatment shared by content and action cards.
///
/// ```dart
/// OudsCard(
///   semanticsLabel: 'Your mobile plan',
///   style: OudsCardStyle.outlined,
///   child: Text('200 GB plan'),
/// )
/// ```
enum OudsCardStyle {
  /// A configurable background with an optional bottom divider.
  filled,

  /// A transparent surface bounded by a border.
  outlined,

  /// A configurable background raised by a shadow.
  elevated,
}
