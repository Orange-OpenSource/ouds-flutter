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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_size_modifier.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_status_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

enum Type {
  icon,
  count,
  standard,
}

/// [OUDS Badge design guidelines](https://unified-design-system.orange.com/472794e18/p/698ea8-badge)
///
/// **Version** : 1.2.0
///
/// An OUDS badge widget.
///
/// A custom Badge widget for user interface, allowing display of various statuses, sizes, icons, or labels.
/// This component is designed to adapt to different visual contexts based on its parameters.
///
/// parameters :
/// - [status] : The badge's status, influencing its color and style (e.g., negative, positive, warning). [OudsBadgeStatus]
/// - [size] : The size of the badge, such as medium, large, etc., to fit various visual needs. [OudsBadgeSize]
/// - [label] : An optional text to display inside the badge, often used for numbers or status texts.
/// - [icon] : An optional SVG asset name to display an icon within the badge, complementing or replacing the label.
/// - [child] : A custom widget to insert inside the badge for advanced customization.
/// - [semanticsLabel]: An optional accessibility label read by screen
///   readers, providing a clear description of the badge's meaning
///   (e.g., "5 new notifications", "Error", "Success").
///
/// Styling details :
/// - The background color is determined by the [status], using [OudsBadgeStatus].
/// - The size and margins are adjusted according to the badge [size] via [OudsBadgeSize].
///
/// ### You can use the above example to implement the [OudsBadge] component in your project, customizing parameters as needed.
///
/// **Usage example :**
///
/// ```dart
/// OudsBadge(
///   status: OudsBadgeStatus.negative,
///   size: OudsBadgeSize.large,
///   label: '120',
///   enabled: true,
///   icon: 'assets/ic_heart_badge.svg',
///   child: Icon(Icons.favorite), // Replace with your child widget";
/// );
/// ```
///

class OudsBadge extends StatefulWidget {
  final OudsBadgeStatus status;
  final OudsBadgeSize? size;
  final String? label;
  final String? icon;
  final Widget? child;
  final bool enabled;
  final String? semanticsLabel;

  const OudsBadge({
    super.key,
    required this.status,
    this.size = OudsBadgeSize.medium,
    this.label,
    this.icon,
    this.child,
    this.enabled = true,
    this.semanticsLabel
  });

  @override
  State<OudsBadge> createState() => _OudsBadgeState();
}

class _OudsBadgeState extends State<OudsBadge> {
  @override
  Widget build(BuildContext context) {
    Widget? badgeLabel;
    final badgeStatusModifier = OudsBadgeStatusModifier(context);
    final badgeSizeModifier = OudsBadgeSizeModifier(context);
    final badge = OudsTheme.of(context).componentsTokens(context).badge;

    switch (type) {
      case Type.standard:
        badgeLabel = const SizedBox.shrink();
        break;
      case Type.icon:
        badgeLabel = _buildBadgeWithIcon(context, widget.icon);
        break;
      case Type.count:
        badgeLabel = _buildBadgeWithNumber(context);
        break;
    }
    final textScaler = MediaQuery.of(context).textScaler;
    final scaledSize = textScaler.scale(badgeSizeModifier.getSize(widget.size));

    return Container(
      width: type == Type.count ? null : scaledSize,
      height: type == Type.count ? null : scaledSize,
      constraints: BoxConstraints(
        minHeight: scaledSize,
        minWidth: scaledSize,
        maxHeight: type == Type.count ? double.infinity : scaledSize,
        maxWidth: type == Type.count ? double.infinity : scaledSize,
      ),
      child: Semantics(
        label: widget.semanticsLabel,
        enabled: widget.enabled,
        child: Badge(
          padding: widget.icon != null
              ? EdgeInsets.only(left: badge.spaceInset, right: badge.spaceInset)
              : widget.size == OudsBadgeSize.large
                  ? EdgeInsets.only(left: badge.spacePaddingInlineLarge, right: badge.spacePaddingInlineLarge)
                  : EdgeInsets.only(left: badge.spacePaddingInlineMedium, right: badge.spacePaddingInlineMedium),
          backgroundColor: badgeStatusModifier.getStatusColor(widget.status,widget.enabled),
          label: badgeLabel,
          child: widget.child,
        ),
      ),
    );
  }

  /// Helper to build badge text, only for medium/large sizes
  Widget _buildBadgeWithNumber(BuildContext context) {
    final theme = OudsTheme.of(context);
    final badgeStatusModifier = OudsBadgeStatusModifier(context);
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? ExcludeSemantics(
          child: Text(
              _formattedLabel(),
              style: widget.size == OudsBadgeSize.large
                  ? theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: badgeStatusModifier.getStatusTextAndIconColor((widget.status),widget.enabled))
                  : theme.typographyTokens.typeLabelDefaultSmall(context).copyWith(color: badgeStatusModifier.getStatusTextAndIconColor((widget.status),widget.enabled)),
              textAlign: TextAlign.center,
            ),
        )
        : Container();
  }

  /// Static method to build icon from asset name
  Widget _buildBadgeWithIcon(BuildContext context, String? assetName) {
    final badgeStatusModifier = OudsBadgeStatusModifier(context);

    if (assetName == null) {
      return SizedBox.shrink(); // widget empty
    }

   final icon = badgeStatusModifier.getStatusIcon(widget.status);
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? SizedBox.expand(
          child: SvgPicture.asset(
            excludeFromSemantics: true,
            icon ?? assetName,
            fit: BoxFit.contain,
            package: icon != null ? OudsTheme.of(context).packageName : null,
            colorFilter: ColorFilter.mode(
              badgeStatusModifier.getStatusTextAndIconColor((widget.status),widget.enabled),
              BlendMode.srcIn,
            ),
          ),
    ) : Container();
  }

  /// Formats a numeric label, replacing values >= 100 with "+99"
  String _formattedLabel() {
    final label = widget.label;
    if (label == null || label.isEmpty) {
      return '';
    }

    try {
      final value = BigInt.parse(label);
      if (value >= BigInt.from(100)) {
        return '+99';
      }
    } catch (e) {
      return label;
    }
    return label;
  }

  /// Returns the [Type] of badge content to display based on the widget configuration.
  ///
  /// This getter determines what kind of badge should be shown:
  /// - [Type.icon]: when an icon is provided, regardless of size.
  /// - [Type.count]: when a label (e.g. a number) is provided **and**
  ///   the badge size is either `medium` or `large`.
  /// - [Type.standard]: when neither icon nor label applies (fallback case).
  Type get type {
    final isMediumOrLarge = widget.size == OudsBadgeSize.medium || widget.size == OudsBadgeSize.large;

    if (widget.icon != null) {
      return Type.icon;
    } else if (widget.label != null && isMediumOrLarge) {
      return Type.count;
    } else {
      return Type.standard;
    }
  }
}
