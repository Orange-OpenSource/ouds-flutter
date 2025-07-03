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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_size_modifier.dart';
import 'package:ouds_core/components/badge/internal/ouds_badge_status_modifier.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsBadge extends StatefulWidget {
  final OudsBadgeStatus status;
  final OudsBadgeSize size;
  final String? label;
  final String? icon;
  final Widget? child;

  const OudsBadge({
    super.key,
    required this.status,
    required this.size,
    this.label,
    this.icon,
    this.child,
  });

  @override
  State<OudsBadge> createState() => _OudsBadgeState();
}

class _OudsBadgeState extends State<OudsBadge> {
  @override
  Widget build(BuildContext context) {
    final badgeStatusModifier = OudsBadgeStatusModifier(context);
    final badgeSizeModifier = OudsBadgeSizeModifier(context);
    final badge = OudsTheme.of(context).componentsTokens(context).badge;
    final height = badgeSizeModifier.getSizeMediumLarge(widget.size).$1;
    final width = badgeSizeModifier.getSizeMediumLarge(widget.size).$2;
    final theme = OudsTheme.of(context);
    String fixNumber = '+99';
    final isLargeOrMediumNumber = widget.label != null && widget.label == fixNumber;
    Widget badgeLabel;

    if (widget.icon != null && (widget.size == OudsBadgeSize.medium || widget.size == OudsBadgeSize.large)) {
      badgeLabel = _buildBadgeWithIcon(context, widget.icon);
    } else if (widget.label != null && (widget.size == OudsBadgeSize.medium || widget.size == OudsBadgeSize.large)) {
      badgeLabel = _buildBadgeWithNumber(context);
    } else {
      badgeLabel = const SizedBox.shrink();
    }

    return Container(
      width: isLargeOrMediumNumber ? width : null,
      height: isLargeOrMediumNumber ? height : null,
      constraints: BoxConstraints(
        minHeight: widget.icon != null ? badgeSizeModifier.getSize(widget.size) : 0.0,
        minWidth: widget.icon != null ? badgeSizeModifier.getSize(widget.size) : 0.0,
        maxHeight: widget.icon != null ? badgeSizeModifier.getSize(widget.size) : double.infinity,
        maxWidth: widget.icon != null ? badgeSizeModifier.getSize(widget.size) : double.infinity,
      ),
      child: Badge(
        padding: widget.icon != null
            ? EdgeInsets.symmetric(horizontal: badge.spaceInset)
            : widget.size == OudsBadgeSize.large
                ? EdgeInsets.only(left: badge.spacePaddingInlineLarge, right: badge.spacePaddingInlineLarge)
                : EdgeInsets.only(left: badge.spacePaddingInlineMedium, right: badge.spacePaddingInlineMedium),
        label: badgeLabel,
        backgroundColor: badgeStatusModifier.getStatusColor(widget.status),
        child: widget.child,
      ),
    );
  }

  /// Helper to build badge text, only for medium/large sizes
  Widget _buildBadgeWithNumber(BuildContext context) {
    final theme = OudsTheme.of(context);
    final badgeStatusModifier = OudsBadgeStatusModifier(context);
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? Text(
            _formattedLabel(),
            style: widget.size == OudsBadgeSize.large
                ? theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: badgeStatusModifier.getStatusTextAndIconColor((widget.status)))
                : theme.typographyTokens.typeLabelDefaultSmall(context).copyWith(color: badgeStatusModifier.getStatusTextAndIconColor((widget.status))),
            textAlign: TextAlign.center,
          )
        : Container();
  }

  /// Static method to build icon from asset name
  Widget _buildBadgeWithIcon(BuildContext context, String? assetName) {
    final badgeStatusModifier = OudsBadgeStatusModifier(context);

    if (assetName == null) {
      return SizedBox.shrink(); // widget vide
    }
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? SvgPicture.asset(
            assetName,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              badgeStatusModifier.getStatusTextAndIconColor((widget.status)),
              BlendMode.srcIn,
            ),
          )
        : Container();
  }

  /// static method to calculate if we have a number 100 we changed by +99
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
}
