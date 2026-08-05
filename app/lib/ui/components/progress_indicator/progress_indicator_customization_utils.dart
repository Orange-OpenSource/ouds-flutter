import 'package:flutter/material.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
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

  /// Returns the OUDS progress indicator type corresponding to the selected enum.
  static OudsProgressIndicatorType? getProgressType(
    ProgressIndicatorEnumType selectedType,
  ) {
    if (selectedType == ProgressIndicatorEnumType.determinate) {
      return OudsProgressIndicatorType.determinate;
    } else if (selectedType == ProgressIndicatorEnumType.indeterminate) {
      return OudsProgressIndicatorType.indeterminate;
    } else {
      return null;
    }
  }

  /// Parses the progress value from a string.
  static double getProgressValue(String progress) {
    if (progress.isEmpty) return 0.0;
    try {
      final value = double.parse(progress);
      return value.clamp(0.0, 1.0); // Also clamp to valid range
    } catch (e) {
      debugPrint('Invalid progress value: $progress');
      return 0.0;
    }
  }

  /// Returns the gap size used by the progress indicator.
  static OudsProgressIndicatorGapSize getGapSize(
    ProgressIndicatorGapSizeEnum selectedGapSize,
  ) {
    return selectedGapSize == ProgressIndicatorGapSizeEnum.defaultSize
        ? OudsProgressIndicatorGapSize.defaultSize
        : OudsProgressIndicatorGapSize.small;
  }

  /// Returns the helper text alignment used by the progress indicator.
  static OudsProgressIndicatorHelperTextAlignment getHelperTextAlignment(
    ProgressIndicatorHelperTextAlignmentEnum selectedHelperTextAlignment,
  ) {
    return selectedHelperTextAlignment ==
            ProgressIndicatorHelperTextAlignmentEnum.left
        ? OudsProgressIndicatorHelperTextAlignment.left
        : selectedHelperTextAlignment ==
              ProgressIndicatorHelperTextAlignmentEnum.center
        ? OudsProgressIndicatorHelperTextAlignment.center
        : OudsProgressIndicatorHelperTextAlignment.right;
  }
}
