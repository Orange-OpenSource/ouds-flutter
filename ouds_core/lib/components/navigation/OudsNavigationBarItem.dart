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

class OudsNavigationBarItem {
  final String icon;
  final String label;
  final String? badge;
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
            icon: _buildIcon(context, modifier, badge, isSelected: isSelected),
            selectedIcon: _buildIcon(context, modifier, badge, isSelected: true),
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

  Widget _buildIcon(
    BuildContext context,
    OudsNavigationBarStatusModifier modifier,
    final String? badge, {
    required bool isSelected,
  }) {
    final buttonTokens = OudsTheme.of(context).componentsTokens(context).button;
    print("state item: ${state}");
    final widgetIcon = SvgPicture.asset(
      icon,
      height: buttonTokens.sizeIconOnly,
      width: buttonTokens.sizeIconOnly,
      colorFilter: ColorFilter.mode(
        modifier.getIconItemColor(
          state,
          isSelected,
        ),
        BlendMode.srcIn,
      ),
    );

    OudsBadgeSize badgeSize = this.badge != null && this.badge != "" ? OudsBadgeSize.medium : OudsBadgeSize.xsmall;
    String? badgeText = this.badge != null && this.badge != "" ? badge : null;
    return badge != null ? OudsBadge(label: badgeText, status: OudsBadgeStatus.negative, size: badgeSize, child: widgetIcon) : widgetIcon;
  }
}
