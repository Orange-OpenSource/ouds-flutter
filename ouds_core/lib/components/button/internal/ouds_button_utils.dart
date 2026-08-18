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
import 'package:ouds_core/components/utilities/badge_border_utils.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';

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
          componentType: OudsButtonComponent.defaultButton,
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
      ? buildBadgeWithBorder(
          context: context,
          hasCount: badge.hasCount,
          child: badge.hasCount
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
                ),
        )
      : widgetIcon;
}

/// Returns the default chevron icon path based on layout
String getDefaultChevronIcon(OudsNavigationButtonLayout layout) {
  switch (layout) {
    case OudsNavigationButtonLayout.next:
      return 'assets/component/button/next.svg';
    case OudsNavigationButtonLayout.previous:
      return 'assets/component/button/previous.svg';
  }
}

/// Resolves the [OudsButtonTokens] size-dependent values (min size, paddings, icon size, …)
/// based on the given [OudsButtonSize], since Tokenator generates a `Default` and a `Small`
/// variant for each of these tokens.
extension OudsButtonSizeTokens on OudsButtonTokens {
  double sizeMinWidth(OudsButtonSize size) =>
      size == OudsButtonSize.small ? sizeMinWidthSmall : sizeMinWidthDefault;

  double sizeMinHeight(OudsButtonSize size) =>
      size == OudsButtonSize.small ? sizeMinHeightSmall : sizeMinHeightDefault;

  double sizeIcon(OudsButtonSize size) =>
      size == OudsButtonSize.small ? sizeIconSmall : sizeIconDefault;

  double sizeIconOnly(OudsButtonSize size) =>
      size == OudsButtonSize.small ? sizeIconOnlySmall : sizeIconOnlyDefault;

  double sizeProgressIndicator(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? sizeProgressIndicatorSmall
      : sizeProgressIndicatorDefault;

  double spaceProgressIndicator(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spaceInsetProgressIndicatorOnlySmall
      : spaceInsetProgressIndicatorOnlyDefault;

  double spaceColumnGapIcon(OudsButtonSize size) => size == OudsButtonSize.small
      ? spaceColumnGapIconSmall
      : spaceColumnGapIconDefault;

  double spaceColumnGapChevron(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spaceColumnGapChevronSmall
      : spaceColumnGapChevronDefault;

  double spaceInsetIconOnly(OudsButtonSize size) => size == OudsButtonSize.small
      ? spaceInsetIconOnlySmall
      : spaceInsetIconOnlyDefault;

  double spacePaddingBlock(OudsButtonSize size) => size == OudsButtonSize.small
      ? spacePaddingBlockSmall
      : spacePaddingBlockDefault;

  double spacePaddingInlineChevronEnd(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spacePaddingInlineChevronEndSmall
      : spacePaddingInlineChevronEndDefault;

  double spacePaddingInlineChevronStart(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spacePaddingInlineChevronStartSmall
      : spacePaddingInlineChevronStartDefault;

  double spacePaddingInlineEndIconStart(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spacePaddingInlineEndIconStartSmall
      : spacePaddingInlineEndIconStartDefault;

  double spacePaddingInlineIconNone(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spacePaddingInlineIconNoneSmall
      : spacePaddingInlineIconNoneDefault;

  double spacePaddingInlineIconStart(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spacePaddingInlineIconStartSmall
      : spacePaddingInlineIconStartDefault;

  double spacePaddingInlineStartIconEnd(OudsButtonSize size) =>
      size == OudsButtonSize.small
      ? spacePaddingInlineStartIconEndSmall
      : spacePaddingInlineStartIconEndDefault;
}
