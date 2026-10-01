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

    final customizationState = ProgressIndicatorCustomization.of(context);

    final params = <String>[
      progressType(context),
      if (customizationState?.hasOnColoredBox != true) status(context),
      value(context),
      track(context),
      animated(context),
      gapSize(context),
      semanticsLabel(context),
      if (widgetType == ProgressIndicatorWidgetType.linear) ...[
        stopIndicator(context),
        linearHelperText(context),
      ],
      if (widgetType == ProgressIndicatorWidgetType.circular)
        circularHelperText(context),
    ];

    return """${coloredSurfaceCodeModifier(context)}$widgetName(
  ${params.join(",\n  ")},
)${coloredSurfaceCodeModifierEnd(context)}""";
  }

  // Returns the `OudsColoredBox(` opening wrapper when the colored box is enabled.
  static String coloredSurfaceCodeModifier(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    if (customizationState?.hasOnColoredBox == true) {
      return "OudsColoredBox(\ncolor: OudsColoredBoxColor.brandPrimary,\nchild: ";
    }

    return "";
  }

  // Closes the `OudsColoredBox(` wrapper opened by [coloredSurfaceCodeModifier], if any.
  static String coloredSurfaceCodeModifierEnd(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return customizationState?.hasOnColoredBox == true ? ",\n)" : "";
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

  static String value(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    if (customizationState?.selectedType ==
        ProgressIndicatorEnumType.indeterminate) {
      return "value: null";
    } else {
      return "value: ${customizationState?.value}";
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

  static String semanticsLabel(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);

    final hasValue =
        customizationState!.value.isNotEmpty &&
        (double.tryParse(customizationState.value) ?? 0.0) > 0.0;

    return "semanticsLabel: '${hasValue ? "Uploading file" : "Connecting to server"}'";
  }

  static String stopIndicator(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    return "stopIndicator: ${customizationState!.hasStopIndicator}";
  }

  static String linearHelperText(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    final hasPercentage = customizationState!.hasPercentage;
    final hasLabel = customizationState.hasHelperText;

    if (!hasPercentage && !hasLabel) {
      return "helperText: null";
    }

    final params = <String>[
      "progress: $hasPercentage",
      if (hasLabel) "label: '${customizationState.helperText}'",
      if (hasLabel)
        "labelAlignment: ${_alignmentCode(customizationState.selectedAlignment)}",
      if (hasPercentage)
        "progressAlignment: ${_alignmentCode(customizationState.selectedProgressAlignment)}",
    ];

    return "helperText: OudsLinearProgressIndicatorHelperText(\n    ${params.join(",\n    ")},\n  )";
  }

  static String circularHelperText(BuildContext context) {
    final customizationState = ProgressIndicatorCustomization.of(context);
    final hasPercentage = customizationState!.hasPercentage;
    final hasLabel = customizationState.hasHelperText;

    if (!hasPercentage && !hasLabel) {
      return "helperText: null";
    }

    final params = <String>[
      "progress: $hasPercentage",
      if (hasLabel) "label: '${customizationState.helperText}'",
    ];

    return "helperText: OudsCircularProgressIndicatorHelperText(\n    ${params.join(",\n    ")},\n  )";
  }

  static String _alignmentCode(
    ProgressIndicatorHelperTextAlignmentEnum alignment,
  ) {
    switch (alignment) {
      case ProgressIndicatorHelperTextAlignmentEnum.left:
        return "OudsProgressIndicatorHelperTextAlignment.start";
      case ProgressIndicatorHelperTextAlignmentEnum.right:
        return "OudsProgressIndicatorHelperTextAlignment.end";
      case ProgressIndicatorHelperTextAlignmentEnum.center:
        return "OudsProgressIndicatorHelperTextAlignment.center";
    }
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
