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
import 'package:ouds_core/components/alert/internal/ouds_alert_status_modifier.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// [OUDS Inline Alert design guidelines](https://r.orange.fr/r/S-ouds-doc-inline-alert)
///
/// Inline alert is a lightweight UI element, placed in the content flow, that displays information, system feedback, status changes throughout short, prominent,
/// persistent and non-actionable communication. Inline alert includes functional icon and semantic colour, and does not include a close button and/or action
/// link. Inline alert does not disappear and remains visible.
///
/// **Reference design version : 1.0.0**
///
/// ## Parameters :
/// - [label]: Label displayed in the inline alert. Main message that should be short, clear, and readable at a glance.
/// - [status]:  The status of the inline alert. its icon color are based on this status.
///  There are two types of statuses:
/// - Non-functional statuses [Neutral] or [Accent] used for informational or decorative alert messages. They
/// provide context or highlight content without implying a specific state, system event, or user action. These alerts are not tied to UX patterns such as
/// success, error, or warning, and may use contextual or brand-related icons to enhance recognition or storytelling.
/// - Functional statuses communicate specific system statuses, results, or user feedback: [Positive], [Warning],
/// [Negative], [Info].
/// Each variant conveys a clear semantic meaning and must always be paired with its dedicated functional icon to ensure clarity and accessibility.
/// Use functional alerts to inform user about state changes, confirmations, or issues that are directly connected to system logic or user actions. These
/// messages carry functional meaning and help guide user response or acknowledgment.
///
class OudsInlineAlert extends StatefulWidget {
  /// Creates an OudsInlineAlert.
  const OudsInlineAlert({
    super.key,
    required this.label,
    this.status = const Neutral(),
  });

  /// The main message displayed in the alert.
  final String label;

  /// The status of the alert, which determines its background color and icon.
  final OudsIconStatus status;

  @override
  State<OudsInlineAlert> createState() => _OudsInlineAlertState();
}

class _OudsInlineAlertState extends State<OudsInlineAlert> {
  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);
    final alertTokens = theme.componentsTokens(context).alert;
    final alertStatusModifier = OudsAlertStatusModifier(context);

    return Semantics(
      label: widget.status is Warning
          ? OudsLocalizations.of(context)?.core_common_warning_a11y
          : widget.status is Negative
          ? OudsLocalizations.of(context)?.core_common_error_a11y
          : null,
      container: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: alertTokens.spaceColumnGap,
        children: [
          alertStatusModifier.buildStatusIcon(context, widget.status),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: theme
                    .sizeSemanticTokens
                    .maxWidthTypeLabelLargeMobile, // todo maxWidthTypeLabelLarge
              ),
              child: Text(
                widget.label,
                style: theme.typographyTokens
                    .typeLabelModerateLarge(context)
                    .copyWith(
                      color: alertStatusModifier.getInlineAlertTextColor(
                        widget.status,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
