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

enum ProgressIndicatorWidgetType { circular, linear }

class ProgressIndicatorCodeGenerator {
  static String updateCode(
    BuildContext context, {
    ProgressIndicatorWidgetType widgetType =
        ProgressIndicatorWidgetType.circular,
  }) {
    final widgetName = widgetType == ProgressIndicatorWidgetType.circular
        ? "OudsCircularProgressIndicator"
        : "OudsLinearProgressIndicator";

    final params = <String>[
      progressType(context),
      status(context),
      progress(context),
      track(context),
      animated(context),
      gapSize(context),
      semanticLabel(context),
      if (widgetType == ProgressIndicatorWidgetType.linear) ...[
        stopIndicator(context),
        helperText(context),
        helperTextAlignment(context),
        percentage(context),
        spaceBeforePercentage(context),
      ],
    ];

    return """$widgetName(
  ${params.join(",\n  ")},
)""";
  }

  static String progressType(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    if (customizationState?.selectedType ==
        ProgressIndicatorEnumType.determinate) {
      return "progressType: OudsProgressIndicatorType.determinate";
    } else {
      return "progressType: OudsProgressIndicatorType.indeterminate";
    }
  }

  static String status(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "status: ${_getStatusCode(customizationState!)}";
  }

  static String progress(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    if (customizationState?.selectedType ==
        ProgressIndicatorEnumType.indeterminate) {
      return "progress: null";
    } else {
      return "progress: ${customizationState?.progress}";
    }
  }

  static String track(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "track: ${customizationState!.hasTrack}";
  }

  static String animated(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "animated: ${customizationState!.hasAnimation}";
  }

  static String gapSize(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    return "gapSize: ${ProgressIndicatorCustomizationUtils.getGapSize(customizationState!.selectedGapSize)}";
  }

  static String semanticLabel(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    final hasProgress =
        customizationState!.progress.isNotEmpty &&
        (double.tryParse(customizationState.progress) ?? 0.0) > 0.0;

    return "semanticLabel: '${hasProgress ? "Uploading file" : "Connecting to server"}'";
  }

  static String stopIndicator(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "stopIndicator: ${customizationState!.hasStopIndicator}";
  }

  static String helperText(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    final text = customizationState!.helperText;

    if (text.isEmpty) {
      return "helperText: null";
    }

    return "helperText: '$text'";
  }

  static String helperTextAlignment(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    switch (customizationState!.alignmentState.selected) {
      case ProgressIndicatorHelperTextAlignmentEnum.left:
        return "helperTextAlignment: OudsProgressIndicatorHelperTextAlignment.left";
      case ProgressIndicatorHelperTextAlignmentEnum.center:
        return "helperTextAlignment: OudsProgressIndicatorHelperTextAlignment.center";
      case ProgressIndicatorHelperTextAlignmentEnum.right:
        return "helperTextAlignment: OudsProgressIndicatorHelperTextAlignment.right";
    }
  }

  static String percentage(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "percentage: ${customizationState!.hasPercentage}";
  }

  static String spaceBeforePercentage(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "spaceBeforePercentage: ${customizationState!.hasSpaceBefore}";
  }

  static String enumStatusValue(dynamic status) {
    return "ProgressIndicatorStatusEnum.${status.toString()}";
  }

  static String enumTypeValue(dynamic type) {
    return "ProgressIndicatorTypeEnum.${type.toString()}";
  }

  static String enumGapSizeValue(dynamic gapSize) {
    return "ProgressIndicatorGapSizeEnum.${gapSize.toString()}";
  }

  static String? _getStatusCode(
    ProgressIndicatorCustomizationState customization,
  ) {
    switch (customization.selectedStatus) {
      case StatusEnum.accent:
        return "Accent()";
      case StatusEnum.negative:
        return "Negative()";
      case StatusEnum.warning:
        return "Warning()";
      case StatusEnum.info:
        return "Info()";
      case StatusEnum.positive:
        return "Positive()";
      case StatusEnum.neutral:
        return "Neutral()";
    }
  }
}
