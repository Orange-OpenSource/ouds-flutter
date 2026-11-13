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

/// Replaces an action card's content with a circular progress indicator.
///
/// A null [progress] indicates an indeterminate operation. Finite values are
/// clamped to the range 0 to 1 when rendered.
///
/// ```dart
/// OudsActionCard(
///   semanticsLabel: 'Activate your eSIM',
///   onPressed: () {},
///   loader: OudsCardLoader(progress: 0.5),
///   child: Text('Activate eSIM'),
/// )
/// ```
class OudsCardLoader {
  /// Creates a determinate or indeterminate card loading indicator.
  const OudsCardLoader({this.progress})
    : assert(
        progress == null ||
            (progress > double.negativeInfinity && progress < double.infinity),
      );

  /// Progress between 0 and 1, or null for an indeterminate operation.
  final double? progress;
}

///
/// [OUDS Action Container Card design guidelines](https://r.orange.fr/r/S-ouds-doc-action-card)
///
/// **Reference design version: 1.0.0.**
///
/// An action container card is a surface-like UI element that groups related information
/// within an interactive surface and allows a user to perform a single primary action or
/// navigate to a destination.
///
/// A null [onPressed] or false [enabled] disables the card. A [loader] replaces
/// content without changing layout and temporarily prevents activation.
/// Corner rounding is shared with content cards through
/// `OudsThemeConfigModel(card: OudsCardConfig(rounded: true), child: ...)`.
///
/// The following parameters are available:
/// - [child]: Presentation-only content with caller-defined layout and padding.
/// - [onPressed]: The primary action; null disables the card.
/// - [style]: Style of the card among [OudsCardStyle] values, filled by default.
/// - [enabled]: Whether the primary action is available.
/// - [backgroundColor]: The Background controls the visibility of the predefined layer within the Card component.
/// - [divider]: Whether filled cards have a bottom divider. Ignored for other styles.
/// - [loader]: Replaces the content while an operation is in progress.
/// - [skeleton]: A placeholder displayed instead of the card while content is loading.
/// - [semanticsLabel]: A concise, localized accessible name describing the card's action.
///
/// ```dart
/// OudsActionCard(
///   semanticsLabel: 'View your mobile plan',
///   onPressed: () {},
///   style: OudsCardStyle.elevated,
///   child: Text('200 GB plan'),
/// )
/// ```
class OudsActionCard extends StatelessWidget {
  /// Creates a single-action card with a localized accessible name.
  const OudsActionCard({
    super.key,
    required this.semanticsLabel,
    required this.onPressed,
    required this.child,
    this.style = OudsCardStyle.filled,
    this.enabled = true,
    this.backgroundColor = true,
    this.divider = false,
    this.loader,
    this.skeleton,
  }) : assert(semanticsLabel != '');

  /// A concise, localized accessible name describing the card's action.
  final String semanticsLabel;

  /// The primary action; null disables the card.
  final VoidCallback? onPressed;

  /// Presentation-only content with caller-defined layout and padding.
  final Widget child;

  /// The surface treatment, filled by default.
  final OudsCardStyle style;

  /// Whether the primary action is available.
  final bool enabled;

  /// The Background controls the visibility of the predefined layer within the Card component.
  /// This property is available for the Filled and Elevated styles when State = Enabled
  final bool backgroundColor;

  /// Whether filled cards have a bottom divider. Ignored for other styles.
  final bool divider;

  /// Replaces the content while an operation is in progress.
  final OudsCardLoader? loader;

  /// A placeholder displayed instead of the card while content is loading.
  final OudsSkeleton? skeleton;

  @override
  Widget build(BuildContext context) => OudsCardSurface(
    semanticsLabel: semanticsLabel,
    actionable: true,
    onPressed: onPressed,
    style: style,
    enabled: enabled,
    backgroundColor: backgroundColor,
    divider: divider,
    loader: loader,
    skeleton: skeleton,
    child: child,
  );
}
