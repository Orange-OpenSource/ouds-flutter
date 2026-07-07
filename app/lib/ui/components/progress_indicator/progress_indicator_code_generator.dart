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
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_customization.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_customization_utils.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';

class ProgressIndicatorCodeGenerator {
  // Static method to generate the code based on CircularProgressIndicator customization state
  static String updateCode(BuildContext context) {
    return """OudsCircularProgressIndicator(
      ${status(context)},
      ${progress(context)},
      ${track(context)},
      ${animated(context)},
      ${gapSize(context)},
      ${semanticLabel(context)},
      )""";
  }

  // Method to generate status
  static String status(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    return "status: ${_getStatusCode(customizationState!)}";
  }

  // Method to generate progress
  static String progress(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    if (customizationState?.selectedType ==
        ProgressIndicatorEnumType.indeterminate) {
      return "progress: null";
    } else {
      return "progress: ${customizationState?.progress}";
    }
  }

  // Method to generate track
  static String track(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    return "track: ${customizationState!.hasTrack}";
  }

  // Method to generate animated
  static String animated(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    return "animated: ${customizationState!.hasAnimation}";
  }

  // Method to generate gapSize
  static String gapSize(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    return "gapSize: ${ProgressIndicatorCustomizationUtils.getGapSize(customizationState!.selectedGapSize)}";
  }

  // Method to generate semanticLabel
  static String semanticLabel(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    final hasProgress =
        customizationState!.progress.isNotEmpty &&
        (double.tryParse(customizationState.progress) ?? 0.0) > 0.0;

    return "semanticLabel: '${hasProgress ? "Uploading file" : "Connecting to server"}'";
  }

  // Helpers to print enum references as code strings
  static String enumStatusValue(dynamic status) {
    // Example output: ProgressIndicatorStatusEnum.positive
    return "ProgressIndicatorStatusEnum.${status.toString()}";
  }

  static String enumTypeValue(dynamic type) {
    // Example output: ProgressIndicatorTypeEnum.determinate
    return "ProgressIndicatorTypeEnum.${type.toString()}";
  }

  static String enumGapSizeValue(dynamic gapSize) {
    // Example output: ProgressIndicatorGapSizeEnum.medium
    return "ProgressIndicatorGapSizeEnum.${gapSize.toString()}";
  }

  /// Generates the code snippet for the `status` property.
  static String? _getStatusCode(
    ProgressIndicatorCustomizationState customization,
  ) {
    switch (customization.selectedStatus) {
      case StatusEnum.accent:
        return "Accent()";
      case StatusEnum.negative:
        return 'Negative()';
      case StatusEnum.warning:
        return 'Warning()';
      case StatusEnum.info:
        return 'Info()';
      case StatusEnum.positive:
        return 'Positive()';
      case StatusEnum.neutral:
        return "Neutral()";
    }
  }
}
