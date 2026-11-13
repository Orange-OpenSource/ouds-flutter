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
/// [OUDS Content Card Container design guidelines](https://r.orange.fr/r/S-ouds-doc-content-card)
///
/// **Reference design version : 1.0.0**
///
/// A Content Container Card groups related information within a single surface. The card itself is not interactive, but it can contain independently
/// interactive elements, such as buttons and links. Its content is customizable through a slot, allowing designers to adapt the internal layout without
/// changing the behavior of the container.
///
/// Corner rounding is shared with content cards through
/// `OudsThemeConfigModel(card: OudsCardConfig(rounded: true), child: ...)`.
///
/// The following parameters are available:
/// - [style]: Style of the card among [OudsCardStyle] values, filled by default.
/// - [enabled]: Controls the enabled state of the card. When `false`, the OUDS components inside will be in disabled state..
/// - [backgroundColor]: Background for filled and elevated cards; transparent when omitted.
/// - [divider]: Whether to draw a bottom divider. Only applies to filled cards.
/// - [skeleton]: A placeholder displayed instead of the card while content is loading.
/// - [child]: Content with independently accessible actions and caller-defined padding.
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
/// {@category Content card}
class OudsCard extends StatelessWidget {
  /// Creates a content card with a meaningful, localized [semanticsLabel].
  const OudsCard({
    super.key,
    required this.child,
    this.style = OudsCardStyle.filled,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.skeleton,
  });

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
    style: style,
    enabled: enabled,
    backgroundColor: backgroundColor,
    divider: divider,
    skeleton: skeleton,
    child: child,
  );
}
