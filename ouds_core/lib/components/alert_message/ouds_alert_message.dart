import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/alert_message/internal/ouds_alert_message_status_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The position of an [OudsAlertMessageActionLink] in the alert message.
enum OudsAlertMessageActionLinkPosition {
  ///The link is displayed at the bottom of the alert message below the main message content.
  /// Recommended for mobile or narrow layouts, or when the text spans multiple lines.
  /// This vertical structure improves clarity and ensures the action remains
  /// visible after the message is read.
  bottom,

  /// The link is displayed at the top-end corner of the alert message.
  /// Best suited for wider layouts or short, single-line alerts where horizontal
  /// alignment keeps content compact and balanced.
  topEnd,
}

/// Represents an action that can be taken on an alert message.
class OudsAlertMessageActionLink {
  /// The text label for the action.
  final String text;

  /// The callback to be invoked when the action is pressed.
  final VoidCallback? onClick;

  /// The position of the link within the alert message.
  OudsAlertMessageActionLinkPosition position;

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
///
/// ## Usage examples:
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
  const OudsAlertMessage({
    super.key,
    required this.label,
    required this.status,
    this.description,
    this.onClose,
    this.actionLink,
    this.bulletList,
  });

  final String label;

  final String? description;

  final OudsIconStatus? status;

  final VoidCallback? onClose;

  final OudsAlertMessageActionLink? actionLink;

  final List<String>? bulletList;

  @override
  State<OudsAlertMessage> createState() => _OudsAlertMessageState();
}

class _OudsAlertMessageState extends State<OudsAlertMessage> {
  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final alertMessageStatusModifier = OudsAlertMessageStatusModifier(context);
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;

    final actionLink = widget.actionLink != null
        ? OudsLink(
            label: widget.actionLink!.text,
            onPressed: () {
              widget.actionLink!.onClick?.call();
            },
          )
        : null;

    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        if (widget.description != null) ...[
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
        if (widget.actionLink != null &&
            widget.actionLink!.position ==
                OudsAlertMessageActionLinkPosition.bottom) ...[
          SizedBox(height: alertTokens.spaceRowGap),
          ?actionLink,
        ],
      ],
    );

    final closeButton = widget.onClose != null
        ? OudsButton(
            icon: AppAssets.icons.componentButtonExpurge,
            onPressed: widget.onClose,
            appearance: OudsButtonAppearance.minimal,
            package: OudsTheme.of(context).packageName,
          )
        : null;

    final hasIcon = switch (widget.status) {
      Neutral(icon: final assets) => assets,
      Accent(icon: final assets) => assets,
      _ => null,
    };

    Widget alertContent;

    alertContent = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.status is Neutral || widget.status is Accent) ...[
          hasIcon != null && hasIcon.isNotEmpty
              ? Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: alertTokens.spacePaddingBlock,
                  ),
                  child: SvgPicture.asset(
                    excludeFromSemantics: true,
                    hasIcon,
                    width: alertTokens.sizeIcon,
                    height: alertTokens.sizeIcon,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      alertMessageStatusModifier.getStatusIconColor(
                        widget.status,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(width: alertTokens.spaceColumnGap),
        ],
        if (widget.status is! Neutral && widget.status is! Accent) ...[
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: alertTokens.spacePaddingBlock,
            ),
            child: buildStatusIcon(context, widget.status),
          ),
          SizedBox(width: alertTokens.spaceColumnGap),
        ],
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: alertTokens.spacePaddingBlock,
            bottom: alertTokens.spacePaddingBlock,
          ),
          child: Expanded(child: textContent),
        ),
        Spacer(),
        if (widget.actionLink != null &&
            widget.actionLink!.position ==
                OudsAlertMessageActionLinkPosition.topEnd) ...[
          SizedBox(width: alertTokens.spaceColumnGap),
          ?actionLink,
        ],
        if (closeButton != null) ...[
          SizedBox(width: alertTokens.spaceColumnGap),
          closeButton,
        ],
      ],
    );
    // }

    return Semantics(
      label: '${widget.label}. ${widget.description ?? ''}',
      container: true,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: alertTokens.spacePaddingInline,
          end: alertTokens.spacePaddingInline,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(alertTokens.borderRadiusDefault),
          color: alertMessageStatusModifier.getStatusColor(widget.status),
        ),
        child: alertContent,
      ),
    );
  }

  Widget buildStatusIcon(BuildContext context, OudsIconStatus? status) {
    final statusModifier = OudsAlertMessageStatusModifier(context);

    //get the asset name from status for neutral and accent status (icon defined by user)
    final nonFunctionalIcon = statusModifier.getAssetsName(status);
    final functionalIcon = statusModifier.getStatusIcon(status);
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;
    //final iconColorTokens = OudsTheme.of(context).componentsTokens(context).icon; //todo change it when PR token is merged

    if (status is Warning) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Background shape
          SvgPicture.asset(
            excludeFromSemantics: true,
            width: alertTokens.sizeIcon,
            height: alertTokens.sizeIcon,
            fit: BoxFit.contain,
            AppAssets
                .icons
                .componentAlertWarningExternalShape, // Path to your external shape SVG
            colorFilter: ColorFilter.mode(
              Color(0xFFFFD000), //todo change it when PR token is merged
              BlendMode.srcIn, // Blend mode to apply the tint
            ),
            package: OudsTheme.of(context).packageName,
          ),
          // Foreground shape
          SvgPicture.asset(
            excludeFromSemantics: true,
            width: alertTokens.sizeIcon,
            height: alertTokens.sizeIcon,
            fit: BoxFit.contain,
            AppAssets
                .icons
                .componentAlertWarningInternalShape, // Path to your internal shape SVG
            colorFilter: ColorFilter.mode(
              Color(0xFF856A00), //todo change it when PR token is merged
              BlendMode.srcIn, // Blend mode to apply the tint
            ),
            package: OudsTheme.of(context).packageName,
          ),
        ],
      );
    }
    return SvgPicture.asset(
      excludeFromSemantics: true,
      functionalIcon ?? nonFunctionalIcon ?? "",
      package: functionalIcon != null
          ? OudsTheme.of(context).packageName
          : null,
      width: alertTokens.sizeIcon,
      height: alertTokens.sizeIcon,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(status),
        BlendMode.srcIn,
      ),
    );
  }
}
