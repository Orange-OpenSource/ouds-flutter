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
import 'package:ouds_core/components/badge/ouds_badge_icon_status.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

enum Type {
  icon,
  count,
  standard,
}

/// The [OudsBadgeStatus]  enum defines the visual importance of the badge within the UI.
enum OudsBadgeStatus {
  negative,
  accent,
  positive,
  info,
  warning,
  neutral,
}

/// The [OudsBadgeSize] enum defines the size of the badge within the UI.
enum OudsBadgeSize {
  xsmall,
  small,
  medium,
  large;
}

/// [OUDS Badge design guidelines](https://r.orange.fr/r/S-ouds-doc-badge)
///
/// **Reference design version : 1.2.0**
///
/// Badge is a UI element that emphasizes system notifications, status, or the categorization of an information,
/// throughout colour only. Badge is rendered as a coloured shape, without icon, text or number; and its chosen
/// size remains unchanged regardless of the changes of the interface size.
///
/// Badges have five statuses depending on the context of the information they represent.
/// Each status is designed to convey a specific meaning and ensure clarity in communication.
///
/// **A11Y recommendation:** Provide a `semanticsLabel` semantics to clarify the meaning of this badge.
///
/// This widget provides three distinct types of badges, each created using a
/// specific named constructor:
///
/// *   `OudsBadge.standard`: A simple dot, useful for indicating a status or
///     the presence of new, unquantified items.
/// *   `OudsBadge.count`: Displays a numerical value or short text. The text is
///     only visible for `medium` and `large` sizes. For numerical labels of 100
///     or more, it displays "+99".
/// *   `OudsBadge.icon`: Displays an icon within the badge. The icon is only
///     visible for `medium` and `large` sizes.
///
/// parameters :
/// - [status] : The badge's status, influencing its color and style (e.g., negative, positive, warning). **Used by `OudsBadge.standard` and `OudsBadge.count`**.
/// - [size] : The size of the badge, such as medium, large, etc., to fit various visual needs.
/// - [label] : An optional text to display inside the badge, often used for numbers or status texts. **Used by `OudsBadge.count`**
/// - [icon] : An optional SVG asset name to display an icon within the badge, complementing or replacing the label.
/// - [badgeIconStatus] :  The status of the badge. The background color of the badge and the icon color are based on this status. **Used by `OudsBadge.icon`**
///   There are two types of status:
///   - Non-functional statuses: [OudsBadgeStatus.neutral] or [OudsBadgeStatus.accent]
///   Using a non-functional status, you can provide a custom icon related to the badge’s context.
///   - Functional statuses: [OudsBadgeStatus.positive], [OudsBadgeStatus.warning], [OudsBadgeStatus.negative], [OudsBadgeStatus.info].
///   Each functional status has its dedicated functional icon that matches the meaning of the badge.
///
/// - [child] : A custom widget to insert inside the badge for advanced customization.
/// - [semanticsLabel]: An optional accessibility label read by screen
///   readers, providing a clear description of the badge's meaning
///   (e.g., "5 new notifications", "Error", "Success").
///
/// Styling details :
/// - The size and margins are adjusted according to the badge [size] via [OudsBadgeSize].
///
/// The badge's appearance can be customized using parameters for status, size,
/// and content.
///
/// ### Usage examples:
///
/// ```dart
/// // Standard badge indicating a new item
/// OudsBadge.standard(
///   status: OudsBadgeStatus.negative,
///   child: Icon(Icons.email), // Replace with your child widget
///   semanticsLabel: "New email",
/// );
///
/// // Count badge showing a number of notifications
/// OudsBadge.count(
///   label: '5',
///   status: OudsBadgeStatus.negative,
///   size: OudsBadgeSize.large,
///   child: Icon(Icons.notifications), // Replace with your child widget
///   semanticsLabel: "5 new notifications",
/// );
///
/// // Icon badge providing status information
/// OudsBadge.icon(
///   badgeIconStatus: Accent(context: context, icon: 'assets/heart-empty.svg'),
///   size: OudsBadgeSize.large,
///   child: Icon(Icons.account_circle), // Replace with your child widget
///   semanticsLabel: "Information available",
/// );
/// ```
///

class OudsBadge extends StatefulWidget {
  final OudsBadgeStatus? status;
  final OudsBadgeSize? size;
  final String? label;
  //will be removed after deprecation
  final String? icon;
  final Widget? child;
  final bool enabled;
  final String? semanticsLabel;
  final OudsBadgeIconStatus? badgeIconStatus;


  /// ⚠️ **DEPRECATED:** Use [OudsBadge.standard], [OudsBadge.icon], or [OudsBadge.count] constructors instead.
  @Deprecated('Use named constructors for clarity: OudsBadge.standard() for standard type, OudsBadge.icon() for icon type, or OudsBadge.count() for count type.'
      ' This constructor will be removed in a future version.')
  const OudsBadge({super.key,
    this.status,
    this.size = OudsBadgeSize.medium,
    this.label,
    this.icon,
    this.child,
    this.enabled = true,
    this.semanticsLabel}
      ) : badgeIconStatus = null;

  const OudsBadge.icon({super.key,
    this.badgeIconStatus,
    this.size = OudsBadgeSize.medium,
    this.child,
    this.enabled = true,
    this.semanticsLabel
  }) : label = null, icon = null, status = null;

  const OudsBadge.standard({super.key,
    this.status,
    this.size = OudsBadgeSize.medium,
    this.child,
    this.enabled = true,
    this.semanticsLabel
  }) : label = null, icon = null, badgeIconStatus = null;

  const OudsBadge.count({super.key,
    this.label,
    this.status,
    this.size = OudsBadgeSize.medium,
    this.child,
    this.enabled = true,
    this.semanticsLabel
  }) : icon = null, badgeIconStatus = null;

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
        //the param icon will be removed after deprecation
        badgeLabel = _buildBadgeWithIcon(context, widget.icon);
        break;
      case Type.count:
        badgeLabel = _buildBadgeWithNumber(context);
        break;
    }
    final textScaler = MediaQuery.of(context).textScaler;
    final scaledSize = textScaler.scale(badgeSizeModifier.getSize(widget.size));

    return Container(
      width: type == Type.count || type == Type.standard ? null : scaledSize,
      height: type == Type.count || type == Type.standard ? null : scaledSize,
      constraints: BoxConstraints(
        minHeight: scaledSize,
        minWidth: scaledSize,
        maxHeight: type == Type.count || type == Type.standard ? double.infinity : scaledSize,
        maxWidth: type == Type.count || type == Type.standard ? double.infinity : scaledSize,
      ),
      child: Semantics(
        label: widget.semanticsLabel,
        enabled: widget.enabled,
        child: Type.standard == type
            ? Badge(
                smallSize: scaledSize,
                alignment: widget.size == OudsBadgeSize.large
                    ? AlignmentDirectional(5, -1.5)
                    : widget.size == OudsBadgeSize.medium
                        ? AlignmentDirectional(2, -1.3)
                        : null,
                padding: widget.size == OudsBadgeSize.large ? EdgeInsets.only(left: badge.spaceInset, right: badge.spaceInset) : null,
                backgroundColor: badgeStatusModifier.getStatusColor(widget.status, widget.badgeIconStatus ,widget.enabled),
                child: widget.child,
              )
            : Badge(
                padding: widget.icon != null || widget.badgeIconStatus?.icon != null
                    ? EdgeInsets.only(left: badge.spaceInset, right: badge.spaceInset)
                    : widget.size == OudsBadgeSize.large
                        ? EdgeInsets.only(left: badge.spacePaddingInlineLarge, right: badge.spacePaddingInlineLarge)
                        : EdgeInsets.only(left: badge.spacePaddingInlineMedium, right: badge.spacePaddingInlineMedium),
                backgroundColor: badgeStatusModifier.getStatusColor(widget.status, widget.badgeIconStatus, widget.enabled),
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
                  ? theme.typographyTokens.typeLabelDefaultMedium(context).copyWith(color: badgeStatusModifier.getStatusTextAndIconColor(widget.status,widget.badgeIconStatus, widget.enabled))
                  : theme.typographyTokens.typeLabelDefaultSmall(context).copyWith(color: badgeStatusModifier.getStatusTextAndIconColor(widget.status,widget.badgeIconStatus, widget.enabled)),
              textAlign: TextAlign.center,
            ),
          )
        : Container();
  }

  /// Static method to build icon from asset name
  // the param assetName will be removed after deprecation
  Widget _buildBadgeWithIcon(BuildContext context, String? assetName) {
    final badgeStatusModifier = OudsBadgeStatusModifier(context);

    final icon = badgeStatusModifier.getStatusIcon(widget.status,widget.badgeIconStatus);
    //get the asset name from badgeIconStatus for neutral and accent status (icon defined by user)
    final assetIconName = badgeStatusModifier.getAssetsName(widget.badgeIconStatus);
    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large || widget.size == OudsBadgeSize.medium
        ? SizedBox.expand(
            child: SvgPicture.asset(
              excludeFromSemantics: true,
              icon ?? assetName ?? assetIconName ?? "",
              fit: BoxFit.contain,
              package: icon != null ? OudsTheme.of(context).packageName : null,
              colorFilter: ColorFilter.mode(
                badgeStatusModifier.getStatusTextAndIconColor(widget.status, widget.badgeIconStatus, widget.enabled),
                BlendMode.srcIn,
              ),
            ),
          )
        : Container();
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

    if (widget.icon != null || widget.badgeIconStatus?.icon != null) {
      return Type.icon;
    } else if (widget.label != null && isMediumOrLarge) {
      return Type.count;
    } else {
      return Type.standard;
    }
  }
}
