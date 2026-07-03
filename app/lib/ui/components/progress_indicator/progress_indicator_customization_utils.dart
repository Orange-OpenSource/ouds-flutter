import 'package:flutter/material.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/progress_indicator/ouds_circular_progress_indicator.dart';
import 'package:ouds_flutter_demo/ui/components/progress_indicator/progress_indicator_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Utility class for `ProgressIndicatorCustomization`.
class ProgressIndicatorCustomizationUtils {
  /// Returns the background color based on the progress indicator status.
  static Color getProgressIndicatorStatusColor(
    BuildContext context,
    StatusEnum enumStatus,
  ) {
    final theme = OudsTheme.of(context).colorScheme(context);
    final status = getStatus(enumStatus);

    switch (status) {
      case Neutral():
        return theme.contentDefault;
      case Accent():
        return theme.contentStatusAccent;
      case Positive():
        return theme.contentStatusPositive;
      case Info():
        return theme.contentStatusInfo;
      case Warning():
        return theme.contentStatusWarning;
      case Negative():
        return theme.contentStatusNegative;
    }
  }

  /// Maps the hierarchy enum to `OudsIconStatus`.
  static OudsIconStatus getStatus(StatusEnum status) {
    switch (status) {
      case StatusEnum.neutral:
        return Neutral();
      case StatusEnum.accent:
        return Accent();
      case StatusEnum.negative:
        return Negative();
      case StatusEnum.info:
        return Info();
      case StatusEnum.warning:
        return Warning();
      default:
        return Positive();
    }
  }

  static double? getProgressValue(
    ProgressIndicatorEnumType selectedType,
    String progress,
  ) {
    if (selectedType == ProgressIndicatorEnumType.determinate) {
      return progress.isNotEmpty ? double.parse(progress) : 0.0;
    } else {
      return null;
    }
  }

  static OudsCircularIndicatorGapSize getGapSize(
    ProgressIndicatorGapSizeEnum selectedGapSize,
  ) {
    return selectedGapSize == ProgressIndicatorGapSizeEnum.defaultSize
        ? OudsCircularIndicatorGapSize.defaultSize
        : OudsCircularIndicatorGapSize.small;
  }
}
