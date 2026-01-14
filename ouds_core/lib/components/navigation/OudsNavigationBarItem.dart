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

class OudsNavigationBarItem {
  final String icon;
  final String label;
  final String? badge;

  const OudsNavigationBarItem({
    required this.icon,
    required this.label,
    this.badge,
  });

  NavigationDestination build(
    BuildContext context, {
    required bool isSelected,
  }) {
    final modifier = OudsNavigationBarStatusModifier(context);

    return NavigationDestination(
      label: label,
      icon: _buildIcon(
        context,
        modifier,
        badge,
        isSelected: false,
      ),
      selectedIcon: _buildIcon(
        context,
        modifier,
        badge,
        isSelected: true,
      ),
    );
  }

  Widget _buildIcon(
    BuildContext context,
    OudsNavigationBarStatusModifier modifier,
    final String? badge, {
    required bool isSelected,
  }) {
    final theme = OudsTheme.of(context);

    final widgetIcon = SvgPicture.asset(
      icon,
      height: theme.componentsTokens(context).button.sizeIconOnly,
      width: theme.componentsTokens(context).button.sizeIconOnly,
      colorFilter: ColorFilter.mode(
        modifier.getIconItemColor(
          OudsNavigationBarControlState.enabled,
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
