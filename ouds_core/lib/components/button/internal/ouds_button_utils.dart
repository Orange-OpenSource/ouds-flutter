//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/internal/ouds_button_icon_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_style_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';

/// Builds an icon button with optional badge, wrapped with semantics for accessibility.
///
/// This widget creates an IconButton styled according to the provided layout, appearance,
/// and control state. It also integrates badge display if provided.
///
Widget buildIconBadgeButton(
  BuildContext context,
  OudsButtonLayout layout,
  OudsButtonAppearance appearance,
  OudsButtonControlState buttonState,
  Function()? onPressed,
  String? icon,
  OudsTopBarActionBadge? badge,
  String? package,
) {
  return MergeSemantics(
    child: Semantics(
      child: IconButton(
        style: OudsButtonStyleModifier.buildButtonStyle(
          context,
          appearance: appearance,
          layout: layout,
          buttonState: buttonState,
        ),
        onPressed: onPressed,
        icon: _buildIconWithBadge(
          context,
          icon!,
          appearance,
          layout,
          buttonState,
          badge,
          package,
        ),
      ),
    ),
  );
}

/// Builds an icon widget with an optional badge overlay.
///
/// This function creates an SVG icon with specified size and color based on the control state
/// and appearance. If a badge is provided, it overlays the icon with the badge.
///
Widget _buildIconWithBadge(
  BuildContext context,
  String assetName,
  final OudsButtonAppearance appearance,
  final OudsButtonLayout layout,
  final OudsButtonControlState buttonState,
  OudsTopBarActionBadge? badge,
  String? package,
) {
  final widgetIcon = SvgPicture.asset(
    excludeFromSemantics: true,
    package: package,
    assetName,
    fit: BoxFit.contain,
    matchTextDirection: true,
    width: OudsButtonIconModifier.getIconSize(context, layout),
    height: OudsButtonIconModifier.getIconSize(context, layout),
    colorFilter: ColorFilter.mode(
      OudsButtonIconModifier.getIconColor(context, buttonState, appearance),
      BlendMode.srcIn,
    ),
  );

  // Wrap icon with badge if provided
  return badge != null
      ? (badge.hasCount
            ? OudsBadge.count(
                semanticsLabel: badge.contentDescription,
                label: badge.count.toString(),
                status: Negative(),
                size: OudsBadgeSize.medium,
                child: widgetIcon,
              )
            : OudsBadge.standard(
                semanticsLabel: badge.contentDescription,
                status: Negative(),
                size: OudsBadgeSize.xsmall,
                child: widgetIcon,
              ))
      : widgetIcon;
}
