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
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_modifier.dart';
import 'package:ouds_core/components/navigation/internal/ouds_navigation_bar_state.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_bar_tokens.dart';

class OudsNavigationBarItemBadge {
  final String contentDescription;
  final int? count;

  const OudsNavigationBarItemBadge({
    required this.contentDescription,
    this.count,
  });

  /// Optional: helper to know if this is a count badge
  bool get hasCount => count != null;
}

class OudsNavigationBarItem {
  final String icon;
  final String label;
  final OudsNavigationBarItemBadge? badge;
  final bool isSelected;
  final OudsNavigationBarControlState state;

  const OudsNavigationBarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.badge,
    this.state = OudsNavigationBarControlState.enabled,
  });

  Column build(
    BuildContext context, {
    required bool isSelected,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);
    final bar = OudsTheme.of(context).componentsTokens(context).bar;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top vertical bar
        _buildTopIndicatorBar(context, bar, isSelected),
        Flexible(
          child: NavigationDestination(
            label: label,
            icon: _buildBadgeIcon(context, icon, modifier, badge, isSelected: isSelected),
            selectedIcon: _buildBadgeIcon(context, icon, modifier, badge, isSelected: isSelected),
          ),
        )
      ],
    );
  }

  Container _buildTopIndicatorBar(BuildContext context, OudsBarTokens bar, bool isSelected) {
    final navigationBarStatusModifier = OudsNavigationBarStatusModifier(context);

    return Container(
      height: bar.sizeHeightActiveIndicatorCustom, // thickness of the bar
      width: bar.sizeWidthActiveIndicatorCustomTop, // width of the bar (adjust)
      decoration: BoxDecoration(
        color: isSelected ? navigationBarStatusModifier.getIndicatorBarColor(state).withValues(alpha: bar.opacityActiveIndicatorCustom) : Colors.transparent,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(bar.borderRadiusActiveIndicatorCustomTop),
          right: Radius.circular(bar.borderRadiusActiveIndicatorCustomBottom),
        ),
      ),
    );
  }

  Widget _buildBadgeIcon(
    BuildContext context,
    String assetName,
    OudsNavigationBarStatusModifier modifier,
    final OudsNavigationBarItemBadge? badge, {
    required bool isSelected,
  }) {
    print("state item: ${state}");
    final widgetIcon = SvgPicture.asset(
      excludeFromSemantics: true,
      assetName,
      fit: BoxFit.contain,
      height: OudsTheme.of(context).componentsTokens(context).button.sizeIconOnly,
      width: OudsTheme.of(context).componentsTokens(context).button.sizeIconOnly,
      colorFilter: ColorFilter.mode(
        modifier.getIconItemColor(
          state,
          isSelected,
        ),
        BlendMode.srcIn,
      ),
    );

    return badge != null
        ? OudsBadge(
            semanticsLabel: badge.contentDescription,
            label: badge.count.toString(),
            status: OudsBadgeStatus.negative,
            size: badge.hasCount ? OudsBadgeSize.medium : OudsBadgeSize.xsmall,
            child: widgetIcon,
          )
        : widgetIcon;
  }
}
