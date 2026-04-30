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
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_core/components/alert/ouds_inline_alert.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_customization.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';

/// A utility class to generate the code for an [OudsAlertMessage] and [OudsInlineAlert] based on customization settings.
class AlertCodeGenerator {
  /// Generates the Dart code for the [OudsAlertMessage] widget.
  ///
  /// The generated code reflects the current state of the customization
  /// options provided by [AlertCustomization].
  static String updateAlertMessageCode(BuildContext context) {
    final customization = AlertCustomization.of(context)!;
    final buffer = StringBuffer();

    buffer.writeln('OudsAlertMessage(');

    // label
    buffer.writeln("  label: '${customization.label}',");

    // description
    if (customization.description.isNotEmpty) {
      buffer.writeln("  description: '${customization.description}',");
    }

    // status
    final status = _getIconStatusCode(customization);
    if (status != null) {
      buffer.writeln('  status: $status,');
    }

    // bulletList
    final bullets = [
      customization.bulletTextOne,
      customization.bulletTextTwo,
      customization.bulletTextThree,
    ].where((bullet) => bullet.isNotEmpty).toList();

    if (customization.hasBulletList && bullets.isNotEmpty) {
      buffer.writeln('  bulletList: [');
      for (final bullet in bullets) {
        buffer.writeln("    '$bullet',");
      }
      buffer.writeln('  ],');
    }

    // actionLink
    if (customization.selectedActionLayout != ActionLayoutEnum.none &&
        customization.actionLink.isNotEmpty) {
      buffer.writeln('  actionLayout: OudsAlertMessageActionLayout(');
      buffer.writeln("    text: '${customization.actionLink}',");
      buffer.writeln('    onClick: () {},');
      final layout =
          'OudsAlertMessageActionLayoutEnum.${customization.selectedActionLayout.name}';
      buffer.writeln('    layout: $layout,');
      buffer.writeln('  ),');
    }

    // onClose
    if (customization.hasCloseButton) {
      buffer.writeln('  onClose: (){},');
    }

    buffer.write(')');

    return buffer.toString();
  }

  /// Generates the Dart code for the [OudsInlineAlert] widget.
  ///
  /// The generated code reflects the current state of the customization
  /// options provided by [AlertCustomization].
  static String updateInlineAlertCode(BuildContext context) {
    final customization = AlertCustomization.of(context)!;
    final buffer = StringBuffer();

    buffer.writeln('OudsInlineAlert(');

    // label
    buffer.writeln("  label: '${customization.label}',");

    // status
    final status = _getIconStatusCode(customization);
    if (status != null) {
      buffer.writeln('  status: $status,');
    }

    buffer.write(')');

    return buffer.toString();
  }

  /// Generates the code snippet for the `status` property.
  static String? _getIconStatusCode(AlertCustomizationState customization) {
    if (!customization.hasIconStatus) {
      return null;
    }

    switch (customization.selectedStatus) {
      case StatusEnum.accent:
        return "Accent(${customization.hasIconStatus ? 'icon: "AppAssets.icons.assistanceTipsAndTricks"' : ''})";
      case StatusEnum.negative:
        return 'Negative()';
      case StatusEnum.warning:
        return 'Warning()';
      case StatusEnum.info:
        return 'Info()';
      case StatusEnum.positive:
        return 'Positive()';
      case StatusEnum.neutral:
        return "Neutral(${customization.hasIconStatus ? 'icon: "AppAssets.icons.assistanceTipsAndTricks"' : ''})";
    }
  }
}
