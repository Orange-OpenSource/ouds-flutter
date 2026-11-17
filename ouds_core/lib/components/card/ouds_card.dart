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

///
/// [OUDS Card design guidelines](https://r.orange.fr/r/S-ouds-doc-content-card)
///
/// **Reference design version : 1.0.0**
///
/// A card groups related information within a non-interactive surface. Its
/// children can include independently interactive elements.
///
/// Corner rounding is shared with content cards through
/// `OudsThemeConfigModel(card: OudsCardConfig(rounded: true), child: ...)`.
///
/// Use [OudsCard.elevated], [OudsCard.filled] or [OudsCard.outlined] to choose
/// the surface treatment.
///
/// ```dart
/// OudsCard.elevated(
///   semanticsLabel: 'Manage your mobile plan',
///   child: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Text('200 GB plan'),
///       OudsLink(label: 'View plan', onPressed: () {}),
///       OudsLink(label: 'Manage options', onPressed: () {}),
///     ],
///   ),
/// )
///
/// OudsCard.outlined(
///   semanticsLabel: 'Manage your mobile plan',
///   child: Text('200 GB plan'),
/// )
///
/// OudsCard.filled(
///   semanticsLabel: 'Manage your mobile plan',
///   child: Text('200 GB plan'),
/// )
/// ```
class OudsCard extends StatelessWidget {
  /// Creates an elevated content card.
  const OudsCard.elevated({
    super.key,
    required this.child,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.skeleton,
    this.semanticsLabel,
  }) : _style = OudsCardStyle.elevated,
       assert(semanticsLabel == null || semanticsLabel != '');

  /// Creates a filled content card.
  const OudsCard.filled({
    super.key,
    required this.child,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.skeleton,
    this.semanticsLabel,
  }) : _style = OudsCardStyle.filled,
       assert(semanticsLabel == null || semanticsLabel != '');

  /// Creates an outlined content card.
  const OudsCard.outlined({
    super.key,
    required this.child,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.skeleton,
    this.semanticsLabel,
  }) : _style = OudsCardStyle.outlined,
       assert(semanticsLabel == null || semanticsLabel != '');

  /// Content with independently accessible actions and caller-defined padding.
  final Widget child;

  final OudsCardStyle _style;

  /// Whether nested controls can receive user interaction.
  final bool enabled;

  /// A concise, localized accessible name for the card's content group.
  final String? semanticsLabel;

  /// Whether to show the background for filled and elevated cards.
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
    style: _style,
    enabled: enabled,
    backgroundColor: backgroundColor,
    divider: divider,
    skeleton: skeleton,
    child: child,
  );
}
