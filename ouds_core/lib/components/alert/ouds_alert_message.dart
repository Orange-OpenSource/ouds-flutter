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

/// {@category Alert}
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/alert/internal/ouds_alert_message_border_modifier.dart';
import 'package:ouds_core/components/alert/internal/ouds_alert_status_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Defines the position of an [OudsAlertMessageActionLink] within the alert message.
enum OudsAlertMessageActionLinkPosition {
  /// The link is displayed at the bottom of the alert message, below the main content.
  ///
  /// This is recommended for mobile or narrow layouts, or when the text spans multiple lines.
  /// This vertical structure improves clarity and ensures the action remains visible.
  bottom,

  /// The link is displayed at the top-end corner of the alert message.
  ///
  /// This is best suited for wider layouts or short, single-line alerts where
  /// horizontal alignment keeps the content compact and balanced.
  topEnd,
}

/// Represents a clickable action within an [OudsAlertMessage].
class OudsAlertMessageActionLink {
  /// The text label for the action link.
  final String text;

  /// The callback to be invoked when the action link is pressed.
  final VoidCallback? onClick;

  /// The position of the link within the alert message.
  /// Defaults to [OudsAlertMessageActionLinkPosition.bottom].
  OudsAlertMessageActionLinkPosition position;

  /// Creates a new action link for an [OudsAlertMessage].
  ///
  /// - [text]: The label for the action.
  /// - [onClick]: The callback to execute when pressed.
  /// - [position]: The position of the link, defaults to `bottom`.
  OudsAlertMessageActionLink({
    required this.text,
    required this.onClick,
    this.position = OudsAlertMessageActionLinkPosition.bottom,
  });
}

/// [OUDS Alert Message design guidelines](https://r.orange.fr/r/S-ouds-doc-alert-message)
///
/// **Reference design version : 1.1.0**
///
/// Alert message is a UI element that displays system feedback, status changes or required action; throughout detailed, prominent, persistent and actionable
/// communication. Alert message includes functional icon and semantic colour, and may include as well a close button and/or action link.
/// Alert Message does not disappear automatically and remains visible until dismissed or resolved by the user.
///
/// ## Parameters :
/// - [label]: Label displayed in the alert message. Main message that should be short, clear, and readable at a glance.
/// - [status]:  The status of the alert message. Its background color and its icon color are based on this status.
/// There are two types of statuses:
/// - Non-functional statuses [Neutral] or [Accent] used for informational or decorative alert messages. They
/// provide context or highlight content without implying a specific state, system event, or user action. These alerts are not tied to UX patterns such as
/// success, error, or warning, and may use contextual or brand-related icons to enhance recognition or storytelling.
/// - Functional statuses communicate specific system statuses, results, or user feedback: [Positive], [Warning],
/// [Negative], [Info].
/// Each variant conveys a clear semantic meaning and must always be paired with its dedicated functional icon to ensure clarity and accessibility.
/// Use functional alerts to inform user about state changes, confirmations, or issues that are directly connected to system logic or user actions. These
/// messages carry functional meaning and help guide user response or acknowledgment.
/// - [description]: Optional supplementary text in an alert message. Use only when additional detail or guidance is needed beyond the label. It should remain
/// short, clear and scannable, helping the user to understand what happened and what he can do next.
/// - [onClose]: Callback invoked when the close button is clicked. If `null`, the close button is not displayed and the alert message remains visible until
///   the context changes (e.g., the issue is resolved, the screen is refreshed). Otherwise, the alert message is dismissable and includes a close button,
///   allowing the user to dismiss it when he has acknowledged the message.
///   Some alerts must remain visible to ensure user is aware of important information; others can be closed to reduce visual clutter.
/// - [actionLink]: An optional link to be displayed in the alert message. It can be used to trigger an action.
/// - [bulletList]: An optional list of bullet points to be displayed in the alert message following the label or the optional [description].
///   Add this list when you need to highlight multiple points, such as service features, plan details, or next steps. Each bullet should be short and written
///   as a clear phrase or fragment — avoid long sentences or complex structures.
///
/// ## Usage Example:
///
/// ```dart
/// OudsAlertMessage(
///   label: 'Your profile has been updated.',
///   status: Positive(),
///   onClose: () {},
/// )
/// ```
///
class OudsAlertMessage extends StatefulWidget {
  /// Creates an OudsAlertMessage.
  const OudsAlertMessage({
    super.key,
    required this.label,
    required this.status,
    this.description,
    this.onClose,
    this.actionLink,
    this.bulletList,
  });

  /// The main message displayed in the alert.
  final String label;

  /// Optional supplementary text providing more detail.
  final String? description;

  /// The status of the alert, which determines its background color and icon.
  final OudsIconStatus? status;

  /// A callback invoked when the close button is clicked. If `null`, the close button is not shown.
  final VoidCallback? onClose;

  /// An optional clickable link to trigger an action.
  final OudsAlertMessageActionLink? actionLink;

  /// An optional list of bullet points to display below the main content.
  final List<String>? bulletList;

  @override
  State<OudsAlertMessage> createState() => _OudsAlertMessageState();
}

class _OudsAlertMessageState extends State<OudsAlertMessage> {
  @override
  Widget build(BuildContext context) {
    // Retrieve theme and component-specific tokens and modifiers.
    final theme = OudsTheme.of(context);
    final alertMessageStatusModifier = OudsAlertStatusModifier(context);
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;

    // Build the action link widget if provided.
    final actionLink = widget.actionLink != null
        ? OudsLink(
            label: widget.actionLink!.text,
            onPressed: () {
              widget.actionLink!.onClick?.call();
            },
          )
        : null;

    // Build the main text content of the alert, including label, description,
    // bullet list, and a bottom-positioned action link.
    final textContent = Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: alertTokens.spacePaddingBlock,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main label text.
          Text(
            widget.label,
            style: theme.typographyTokens
                .typeLabelModerateLarge(context)
                .copyWith(
                  color: alertMessageStatusModifier.getStatusTextColor(
                    widget.status,
                  ),
                ),
          ),
          // Optional description text.
          if (widget.description != null && widget.description!.isNotEmpty) ...[
            SizedBox(height: alertTokens.spaceRowGap),
            Text(
              widget.description!,
              style: theme.typographyTokens
                  .typeLabelDefaultMedium(context)
                  .copyWith(
                    color: alertMessageStatusModifier.getStatusTextColor(
                      widget.status,
                    ),
                  ),
            ),
          ],
          // Optional bullet list. A gap is added only if the list is not empty.
          if (widget.bulletList != null &&
              widget.bulletList!.any((bullet) => bullet.isNotEmpty))
            SizedBox(height: alertTokens.spaceRowGap),
          // Generate bullet list items, filtering out any empty strings.
          ...?widget.bulletList
              ?.where((bullet) => bullet.isNotEmpty)
              .map((bullet) => buildBulletList(context, widget.status, bullet)),
          // Optional action link positioned at the bottom.
          if (actionLink != null &&
              widget.actionLink != null &&
              widget.actionLink!.text.isNotEmpty &&
              widget.actionLink!.position ==
                  OudsAlertMessageActionLinkPosition.bottom) ...[
            SizedBox(height: alertTokens.spaceRowGapAction),
            actionLink,
          ],
        ],
      ),
    );

    // Build the close button if a callback is provided.
    final closeButton = widget.onClose != null
        ? OudsButton(
            icon: AppAssets.icons.componentButtonExpurge,
            onPressed: widget.onClose,
            appearance: OudsButtonAppearance.minimal,
            package: OudsTheme.of(context).packageName,
          )
        : null;

    // Determine if a custom icon is provided for Neutral or Accent statuses.
    final hasIcon = switch (widget.status) {
      Neutral(icon: final assets) => assets,
      Accent(icon: final assets) => assets,
      _ => null,
    };

    // Assemble the final alert content layout.
    Widget alertContent;
    alertContent = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display custom icon for Neutral/Accent statuses if available.
        if ((widget.status is Neutral || widget.status is Accent) &&
            hasIcon != null &&
            hasIcon.isNotEmpty) ...[
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: alertTokens.spacePaddingBlock,
            ),
            child: SvgPicture.asset(
              excludeFromSemantics: true,
              hasIcon,
              width: MediaQuery.textScalerOf(
                context,
              ).scale(alertTokens.sizeIcon),
              height: MediaQuery.textScalerOf(
                context,
              ).scale(alertTokens.sizeIcon),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                alertMessageStatusModifier.getStatusIconColor(widget.status),
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: alertTokens.spaceColumnGap),
        ],
        // Display functional status icon for other statuses.
        if (widget.status is! Neutral && widget.status is! Accent) ...[
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: alertTokens.spacePaddingBlock,
            ),
            child: alertMessageStatusModifier.buildStatusIcon(
              context,
              widget.status,
            ),
          ),
          SizedBox(width: alertTokens.spaceColumnGap),
        ],
        // Main text content area.
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: alertTokens.spacePaddingBlock,
              end: alertTokens.spaceColumnGap,
            ),
            child: textContent,
          ),
        ),
        // Optional action link positioned at the top-end.
        if (widget.actionLink != null &&
            widget.actionLink!.text.isNotEmpty &&
            widget.actionLink!.position ==
                OudsAlertMessageActionLinkPosition.topEnd) ...[
          ?actionLink,
          SizedBox(
            width: closeButton != null
                ? alertTokens.spaceColumnGapAction
                : alertTokens.spacePaddingInline,
          ),
        ],
        // Optional close button.
        if (closeButton != null) ...[closeButton],
      ],
    );

    // Wrap the entire component in a Semantics widget for accessibility
    // and a decorated Container for styling.
    return Semantics(
      label: widget.status is Warning
          ? OudsLocalizations.of(context)?.core_common_warning_a11y
          : widget.status is Negative
          ? OudsLocalizations.of(context)?.core_common_error_a11y
          : null,
      container: true,
      child: Container(
        constraints: BoxConstraints(
          minWidth: alertTokens.sizeMinWidth,
          minHeight: alertTokens.sizeMinHeight,
        ),
        padding: EdgeInsetsDirectional.only(
          start: alertTokens.spacePaddingInline,
        ),
        decoration: BoxDecoration(
          border: OudsBorder().borderAll(
            width: alertTokens.borderWidth,
            color: Colors.transparent,
          ),
          borderRadius: OudsAlertMessageBorderModifier.getBorderRadius(context),
          color: alertMessageStatusModifier.getStatusColor(widget.status),
        ),
        child: alertContent,
      ),
    );
  }

  /// Builds a single bullet list item for the alert message.
  ///
  /// This widget creates a row containing a bullet icon and a text label,
  /// styled according to the alert's status and theme tokens.
  Widget buildBulletList(
    BuildContext context,
    OudsIconStatus? status,
    String label,
  ) {
    final theme = OudsTheme.of(context);
    final alertMessageStatusModifier = OudsAlertStatusModifier(context);
    final maxTextWidth = theme.sizeScheme(context).maxWidthTypeLabelMedium;
    final textScaler = MediaQuery.textScalerOf(context);
    final double iconContainerWidth = textScaler.scale(
      theme.sizeScheme(context).iconWithLabelMediumSizeMedium,
    );

    final TextStyle textStyle = theme.typographyTokens
        .typeLabelDefaultMedium(context)
        .copyWith(color: alertMessageStatusModifier.getStatusTextColor(status));
    final double textLineHeight = textScaler.scale(
      textStyle.height! * textStyle.fontSize!,
    );

    final double iconSize = textScaler.scale(
      theme.sizeScheme(context).iconWithLabelMediumSizeSmall,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: iconContainerWidth,
            height: textLineHeight,
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                AppAssets.icons.componentBulletListBulletLevelZero,
                excludeFromSemantics: true,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  alertMessageStatusModifier.getStatusTextColor(status),
                  BlendMode.srcIn,
                ),
                package: theme.packageName,
              ),
            ),
          ),
          SizedBox(
            width: theme
                .componentsTokens(context)
                .bulletList
                .spaceColumnGapBodyMedium,
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxTextWidth),
              child: Text(label, style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
