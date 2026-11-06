// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.

/// {@category Card}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/card/internal/ouds_card_surface.dart';
import 'package:ouds_core/components/card/ouds_card_style.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

export 'package:ouds_core/components/card/ouds_card_style.dart';

/// A non-interactive content container. Reference design version: 1.0.0.
///
/// The card never becomes a button, takes keyboard focus, or reacts to hover,
/// focus and press. Interactive children retain their individual actions,
/// accessible names and focus targets. Use `OudsActionCard` instead when the
/// entire surface represents one action.
///
/// [semanticsLabel] must be a short, localized name describing the purpose of
/// the group, not a concatenation of the slot's text. Content remains separately
/// accessible. The slot controls its own padding and layout.
/// Corner rounding is shared with action cards through
/// `OudsThemeConfigModel(card: OudsCardConfig(rounded: true), child: ...)`.
///
/// Setting [enabled] to false blocks pointer, keyboard and accessibility
/// activation in the slot. Pass disabled state to the children explicitly
/// (for example, null callbacks) for appropriate visuals and announcements.
///
/// ```dart
/// OudsCard(
///   semanticsLabel: 'Manage your mobile plan',
///   style: OudsCardStyle.outlined,
///   child: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Text('200 GB plan'),
///       OudsLink(label: 'View plan', onPressed: () {}),
///       OudsLink(label: 'Manage options', onPressed: () {}),
///     ],
///   ),
/// )
/// ```
class OudsCard extends StatelessWidget {
  /// Creates a content card with a meaningful, localized [semanticsLabel].
  const OudsCard({
    super.key,
    required this.semanticsLabel,
    required this.child,
    this.style = OudsCardStyle.filled,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.skeleton,
  }) : assert(semanticsLabel != '');

  /// A concise, localized accessible name for the content group.
  final String semanticsLabel;

  /// Content with independently accessible actions and caller-defined padding.
  final Widget child;

  /// The surface treatment, filled by default.
  final OudsCardStyle style;

  /// Whether nested controls can receive user interaction.
  final bool enabled;

  /// Background for filled and elevated cards; transparent when omitted.
  ///
  /// Ignored by outlined cards, whose background is always transparent.
  final bool backgroundColor;

  /// Whether to draw a bottom divider. Only applies to filled cards.
  final bool divider;

  /// A placeholder displayed instead of the card while content is loading.
  final OudsSkeleton? skeleton;

  @override
  Widget build(BuildContext context) => OudsCardSurface(
    semanticsLabel: semanticsLabel,
    style: style,
    enabled: enabled,
    backgroundColor: backgroundColor,
    divider: divider,
    skeleton: skeleton,
    child: child,
  );
}
