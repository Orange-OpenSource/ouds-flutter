import 'dart:io';

import 'package:flutter/material.dart';

/// Utility class providing typography-related helper methods.
class TypographyUtil {
  /// Resolves letter spacing responsively based on the platform.
  ///
  /// On Android, the letter spacing value is normalized by dividing
  /// it by the font size to ensure consistent rendering across devices.
  /// On other platforms (e.g., iOS), the letter spacing is returned as is.
  ///
  /// This method helps maintain consistent text appearance between Android and iOS.
  ///
  /// Parameters:
  /// - [context]: The BuildContext, currently not used but can be useful for extensions.
  /// - [fontSize]: The font size of the text.
  /// - [letterSpacing]: The base letter spacing value.
  ///
  /// Returns:
  /// - A [double] representing the adjusted letter spacing for the current platform.
  static double resolveResponsiveLetterSpacing({
    required BuildContext context,
    required double fontSize,
    required double letterSpacing,
  }) {
    if (Platform.isAndroid) {
      // Normalize letter spacing for Android by dividing by font size.
      return letterSpacing / fontSize;
    } else {
      // Return the letter spacing as-is on other platforms.
      return letterSpacing;
    }
  }
}
