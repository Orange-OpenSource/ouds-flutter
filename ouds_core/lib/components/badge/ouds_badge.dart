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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// @nodoc
/// this is an internal enum should not be exposed to the user
enum _OudsBadgeType {
  icon,
  count,
  standard,
}

/// The [OudsBadgeStatus]  enum defines the visual importance of the badge within the UI.
@Deprecated('use OudsIconStatus subclasses (Neutral, Accent, Positive, Info, Warning, Negative). This type will be removed in the next major release.')
enum OudsBadgeStatus {
  negative,
  accent,
  positive,
  info,
  warning,
  neutral,
}

/// @nodoc
// deprecation remove : this enum is added only to support the deprecated enum and will be removed after deprecation
extension OudsBadgeStatusConverter on OudsBadgeStatus {
  /// Converts this simple status enum to the corresponding [OudsIconStatus] class instance.
  ///
  /// Note: For `Neutral` and `Accent`, this conversion does not carry over any
  /// custom icon information, as the base enum does not store it.
  OudsIconStatus toIconStatus() {
    return switch (this) {
      OudsBadgeStatus.neutral => Neutral(),
      OudsBadgeStatus.accent => Accent(),
      OudsBadgeStatus.positive => Positive(),
      OudsBadgeStatus.warning => Warning(),
      OudsBadgeStatus.negative => Negative(),
      OudsBadgeStatus.info => Info(),
    };
  }
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
/// This API replaces the previous generic constructor and deprecated status model.
///
/// ---
/// ## Migration overview
///
/// ### 1) Use named constructors
/// Replace the deprecated default constructor:
/// - `OudsBadge(...)`
/// with one of:
/// - `OudsBadge.standard(...)`
/// - `OudsBadge.count(...)`
/// - `OudsBadge.icon(...)`
///
/// ### 2) Replace `OudsBadgeStatus` with `OudsIconStatus`
/// `OudsBadgeStatus` is deprecated and will be removed.
/// Use `OudsIconStatus` subclasses to define badge visual semantics.
///
/// ### 3) Remove `icon` parameter
/// The `icon` parameter is deprecated and will be removed.
/// Icon selection must now be driven by `status` (`OudsIconStatus`):
/// - Functional statuses (`Positive`, `Info`, `Warning`, `Negative`) provide fixed icons.
/// - Contextual statuses (`Neutral`, `Accent`) can carry a custom icon asset.
///
/// ---
/// ## Status model
///
/// New `status` type:
/// - [Neutral] (optional custom icon)
/// - [Accent] (optional custom icon)
/// - [Positive] (fixed functional icon)
/// - [Info] (fixed functional icon)
/// - [Warning] (fixed functional icon)
/// - [Negative] (fixed functional icon)
///
/// This unifies:
/// - background color
/// - icon choice
/// - icon/text foreground color
///
/// ---
/// ## Behavior notes
///
/// - `count` text is visible only for [OudsBadgeSize.medium] and [OudsBadgeSize.large].
/// - Numeric values `>= 100` are formatted as `+99`.
/// - `icon` is visible only for [OudsBadgeSize.medium] and [OudsBadgeSize.large].
/// - For accessibility, always provide [semanticsLabel].
///
/// ---
///
/// ## Parameters :
/// - [status] : The badge's status, influencing its color and style (e.g., negative, positive, warning). **Used by `OudsBadge.standard` and `OudsBadge.count`**.
/// - [size] : The size of the badge, such as medium, large, etc., to fit various visual needs.
/// - [label] : An optional text to display inside the badge, often used for numbers or status texts. **Used by `OudsBadge.count`**
/// - [icon] : An optional SVG asset name to display an icon within the badge, complementing or replacing the label.
/// - [status] :  The status of the badge. The background color of the badge and the icon color are based on this status. **Used by `OudsBadge.icon`**
///   There are two types of status:
///   - Non-functional statuses: [Neutral] or [Accent]
///   Using a non-functional status, you can provide a custom icon related to the badge’s context.
///   - Functional statuses: [Positive], [Warning], [Negative], [Info].
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
/// ## Usage examples:
///
/// ### Standard badge
/// ```dart
/// OudsBadge.standard(
///   status: Negative(),
///   size: OudsBadgeSize.medium,
///   semanticsLabel: 'Erreur',
///   child: const Icon(Icons.mail),
/// )
/// ```
///
/// ### Count badge
/// ```dart
/// OudsBadge.count(
///   label: '12',
///   status: Info(),
///   size: OudsBadgeSize.large,
///   semanticsLabel: '12 notifications',
///   child: const Icon(Icons.notifications),
/// )
/// ```
///
/// ### Icon badge with functional status icon
/// ```dart
/// OudsBadge.icon(
///   status: Warning(),
///   size: OudsBadgeSize.large,
///   semanticsLabel: 'Avertissement',
///   child: const Icon(Icons.settings),
/// )
/// ```
///
/// ### Icon badge with custom icon (Neutral/Accent)
/// ```dart
/// OudsBadge.icon(
///   status: Accent(icon: 'assets/heart-empty.svg'),
///   size: OudsBadgeSize.large,
///   semanticsLabel: 'Favorite',
///   child: const Icon(Icons.person),
/// )
/// ```

class OudsBadge extends StatefulWidget {
  @Deprecated('Use status of type OudsIconStatus instead. This parameter will be removed in a future version.')
  final OudsBadgeStatus? _deprecatedStatus;
  final OudsIconStatus? status;
  final OudsBadgeSize? size;
  final String? label;
  @Deprecated('icon is now defined by status (OudsIconStatus). Use Accent(icon: ...) or Neutral(icon: ...) for custom icons.')
  final String? icon;
  final Widget? child;
  final bool enabled;
  final String? semanticsLabel;
  final bool? _withIcon;

  /// ⚠️ **DEPRECATED:** Use [OudsBadge.standard], [OudsBadge.icon], or [OudsBadge.count] constructors instead.
  @Deprecated('Use named constructors for clarity: OudsBadge.standard() for standard type, OudsBadge.icon() for icon type, or OudsBadge.count() for count type.'
      ' This constructor will be removed in a future version.')
  const OudsBadge({
    super.key,
    OudsBadgeStatus? status,
    this.size = OudsBadgeSize.medium,
    this.label,
    @Deprecated(
        'icon is now defined by status (OudsIconStatus). Use Accent(icon: ...) or Neutral(icon: ...) for custom icons.')
    this.icon,
    this.child,
    this.enabled = true,
    this.semanticsLabel,
  })  : _deprecatedStatus = status,
        status = null,
        _withIcon = null;

  const OudsBadge.icon({
    super.key,
    this.size = OudsBadgeSize.medium,
    this.child,
    this.enabled = true,
    this.semanticsLabel,
    this.status,
    bool withIcon = true,
  })  : label = null,
        icon = null,
        _deprecatedStatus = null,
        _withIcon = withIcon;

  const OudsBadge.standard({
    super.key,
    this.size = OudsBadgeSize.medium,
    this.child,
    this.enabled = true,
    this.semanticsLabel,
    this.status,
  })  : label = null,
        icon = null,
        _deprecatedStatus = null,
        _withIcon = false;

  const OudsBadge.count({
    super.key,
    this.label,
    this.size = OudsBadgeSize.medium,
    this.child,
    this.enabled = true,
    this.semanticsLabel,
    this.status,
  })  : icon = null,
        _deprecatedStatus = null,
        _withIcon = false;

  @override
  State<OudsBadge> createState() => _OudsBadgeState();
}

class _OudsBadgeState extends State<OudsBadge> {
  OudsIconStatus? get _effectiveStatus =>
      widget.status ?? widget._deprecatedStatus?.toIconStatus();

  @override
  Widget build(BuildContext context) {
    Widget? badgeLabel;
    final badgeStatusModifier = OudsBadgeStatusModifier(context);
    final badgeSizeModifier = OudsBadgeSizeModifier(context);
    final badge = OudsTheme.of(context).componentsTokens(context).badge;
    // Check for the icon property
    final hasIcon = switch (_effectiveStatus) {
      // If it's a Neutral or Accent type, check if its icon property is not null
      Neutral(icon: final assets) => assets != null,
      Accent(icon: final assets) => assets != null,
      // For all other statuses (Positive, Info, etc.), the icon is fixed, so we consider it present.
      Positive() || Info() || Warning() || Negative() => true,
      // If iconStatus is null
      null => false,
    };

    switch (type) {
      case _OudsBadgeType.standard:
        badgeLabel = const SizedBox.shrink();
        break;
      case _OudsBadgeType.icon:
        //the param icon will be removed after deprecation
        badgeLabel = _buildBadgeWithIcon(context, widget.icon);
        break;
      case _OudsBadgeType.count:
        badgeLabel = _buildBadgeWithNumber(context);
        break;
    }
    final textScaler = MediaQuery.of(context).textScaler;
    final scaledSize = textScaler.scale(badgeSizeModifier.getSize(widget.size));

    return Container(
      width: type == _OudsBadgeType.count || type == _OudsBadgeType.standard ? null : scaledSize,
      height: type == _OudsBadgeType.count || type == _OudsBadgeType.standard ? null : scaledSize,
      constraints: BoxConstraints(
        minHeight: scaledSize,
        minWidth: scaledSize,
        maxHeight: type == _OudsBadgeType.count || type == _OudsBadgeType.standard
            ? double.infinity
            : scaledSize,
        maxWidth: type == _OudsBadgeType.count || type == _OudsBadgeType.standard
            ? double.infinity
            : scaledSize,
      ),
      child: Semantics(
        label: widget.semanticsLabel,
        enabled: widget.enabled,
        child: _OudsBadgeType.standard == type
            ? Badge(
                smallSize: scaledSize,
                alignment: widget.size == OudsBadgeSize.large
                    ? AlignmentDirectional(5, -1.5)
                    : widget.size == OudsBadgeSize.medium
                        ? AlignmentDirectional(2, -1.3)
                        : null,
                padding: widget.size == OudsBadgeSize.large
                    ? EdgeInsets.only(
                        left: badge.spaceInset, right: badge.spaceInset)
                    : null,
                backgroundColor: badgeStatusModifier.getStatusColor(
                    widget._deprecatedStatus, _effectiveStatus, widget.enabled),
                child: widget.child,
              )
            : Badge(
                padding: widget.icon != null || hasIcon
                    ? EdgeInsets.only(
                        left: badge.spaceInset, right: badge.spaceInset)
                    : widget.size == OudsBadgeSize.large
                        ? EdgeInsets.only(
                            left: badge.spacePaddingInlineLarge,
                            right: badge.spacePaddingInlineLarge)
                        : EdgeInsets.only(
                            left: badge.spacePaddingInlineMedium,
                            right: badge.spacePaddingInlineMedium),
                backgroundColor: badgeStatusModifier.getStatusColor(
                    widget._deprecatedStatus, _effectiveStatus, widget.enabled),
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
    return widget.size == OudsBadgeSize.large ||
            widget.size == OudsBadgeSize.medium
        ? ExcludeSemantics(
            child: Text(
              _formattedLabel(),
              style: widget.size == OudsBadgeSize.large
                  ? theme.typographyTokens
                      .typeLabelDefaultMedium(context)
                      .copyWith(
                          color: badgeStatusModifier.getStatusTextAndIconColor(
                              widget._deprecatedStatus,
                              _effectiveStatus,
                              widget.enabled))
                  : theme.typographyTokens
                      .typeLabelDefaultSmall(context)
                      .copyWith(
                          color: badgeStatusModifier.getStatusTextAndIconColor(
                              widget._deprecatedStatus,
                              _effectiveStatus,
                              widget.enabled)),
              textAlign: TextAlign.center,
            ),
          )
        : Container();
  }

  /// Static method to build icon from asset name
  //deprecation remove: The param assetName will be removed after deprecation
  Widget _buildBadgeWithIcon(BuildContext context, String? assetName) {
    final badgeStatusModifier = OudsBadgeStatusModifier(context);

    // This gets the fixed icon for Positive, Negative, etc.
    final fixedIcon =
        badgeStatusModifier.getIcon(widget._deprecatedStatus, _effectiveStatus);

    // This correctly gets the user-defined icon for Neutral and Accent
    final userDefinedIcon = badgeStatusModifier.getAssetsName(_effectiveStatus);

    // The logic correctly prioritizes which icon to use.
    // The deprecated `assetName` is also included for backward compatibility.
    final iconPath = fixedIcon ?? assetName ?? userDefinedIcon ?? "";

    // this condition is two eliminate the text when we are in XSmall or Small
    return widget.size == OudsBadgeSize.large ||
            widget.size == OudsBadgeSize.medium
        ? SizedBox.expand(
            child: SvgPicture.asset(
              excludeFromSemantics: true,
              iconPath,
              fit: BoxFit.contain,
              package:
                  fixedIcon != null ? OudsTheme.of(context).packageName : null,
              colorFilter: ColorFilter.mode(
                badgeStatusModifier.getStatusTextAndIconColor(
                    widget._deprecatedStatus, _effectiveStatus, widget.enabled),
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

  /// Returns the [_OudsBadgeType] of badge content to display based on the widget configuration.
  ///
  /// This getter determines what kind of badge should be shown:
  /// - [_OudsBadgeType.icon]: when an icon is provided, regardless of size.
  /// - [_OudsBadgeType.count]: when a label (e.g. a number) is provided **and**
  ///   the badge size is either `medium` or `large`.
  /// - [_OudsBadgeType.standard]: when neither icon nor label applies (fallback case).
  _OudsBadgeType get type {
    final isMediumOrLarge =
        widget.size == OudsBadgeSize.medium || widget.size == OudsBadgeSize.large;

    // Check for the icon property
    final hasIcon = switch (_effectiveStatus) {
      // If it's a Neutral or Accent type, check if its icon property is not null
      Neutral(icon: final assets) => assets != null,
      Accent(icon: final assets) => assets != null,
      // For all other statuses (Positive, Info, etc.), the icon is fixed, so we consider it present.
      Positive() || Info() || Warning() || Negative() => true,
      // If iconStatus is null
      null => false,
    };

    if (widget.icon != null ||
        (widget.icon == null && hasIcon && widget._withIcon == true)) {
      return _OudsBadgeType.icon;
    } else if (widget.label != null && isMediumOrLarge) {
      return _OudsBadgeType.count;
    } else {
      return _OudsBadgeType.standard;
    }
  }
}
