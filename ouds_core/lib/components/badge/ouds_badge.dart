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

/// OudsBadge widget displays a badge with different statuses, sizes, optional label, and icon
class OudsBadge extends StatefulWidget {
  final OudsBadgeStatus status;
  final OudsBadgeSize size;
  final String? label;
  final String? icon;

  const OudsBadge({
    super.key,
    required this.status,
    required this.size,
    this.label,
    this.icon,
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

    return Container(
      width: widget.label != null ? width : null,
      height: widget.label != null ? height : null,
      padding: widget.icon != null
          ? EdgeInsets.only(left: badge.spaceInset, right: badge.spaceInset)
          : widget.size == OudsBadgeSize.large
              ? EdgeInsets.only(left: badge.spacePaddingInlineLarge, right: badge.spacePaddingInlineLarge)
              : EdgeInsets.only(left: badge.spacePaddingInlineMedium, right: badge.spacePaddingInlineMedium),
      constraints: BoxConstraints(
        minHeight: badgeSizeModifier.getSize(widget.size),
        minWidth: badgeSizeModifier.getSize(widget.size),
        maxHeight: badgeSizeModifier.getSize(widget.size),
        maxWidth: badgeSizeModifier.getSize(widget.size),
      ),
      decoration: BoxDecoration(
        color: badgeStatusModifier.getStatusColor(widget.status),
        borderRadius: BorderRadius.circular(theme.borderTokens.radiusPill),
      ),
      child: widget.label != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // this condition is two eliminate the text when we are in XSmall or Small
                _buildBadgeWithNumber(context, badgeStatusModifier),
              ],
            )
          : _buildBadgeWithIcon(context, widget.icon), //_OudsBadgeState.buildIcon(context, widget.icon),
    );
  }

  /// Helper to build badge text, only for medium/large sizes
  Widget _buildBadgeWithNumber(BuildContext context, OudsBadgeStatusModifier badgeStatusModifier) {
    final theme = OudsTheme.of(context);
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? Text(
            widget.label ?? "",
            style: widget.size == OudsBadgeSize.large
                ? theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: badgeStatusModifier.getStatusTextColor((widget.status)))
                : theme.typographyTokens.typeLabelDefaultSmall(context).copyWith(color: badgeStatusModifier.getStatusTextColor((widget.status))),
            textAlign: TextAlign.center,
          )
        : Container();
  }

  /// Static method to build icon from asset name
  Widget _buildBadgeWithIcon(BuildContext context, String? assetName) {
    final colorsScheme = OudsTheme.of(context).colorScheme;
    //String? assetName;

    if (assetName == null) {
      return SizedBox.shrink(); // widget vide
    }
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? SvgPicture.asset(
            assetName,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              colorsScheme(context).contentDefault,
              BlendMode.srcIn,
            ),
          )
        : Container();
  }
}
