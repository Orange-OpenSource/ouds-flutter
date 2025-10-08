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

/// @nodoc
library;

import 'package:flutter/cupertino.dart';

/// A utility class for handling common input-related operations in Flutter.
class InputUtils {
  /// Returns the maximum number of lines for a label based on the input state.
  ///
  /// Rules:
  /// - If a hint text is provided, the label is limited to 1 line.
  /// - If the input is focused, the label is limited to 1 line.
  /// - If the controller has a non-empty text, the label is limited to 1 line.
  /// - Otherwise, the label can use up to 2 lines.
  ///
  /// Parameters:
  /// [hintText] The hint text displayed inside the input or password field decoration.
  /// [isFocused] Whether the input field is currently focused.
  /// [controller] The text controller for the input field (optional).
  ///
  /// Returns:
  /// `1` if any of the above conditions are true, otherwise `2`.
  static int getLabelMaxLines({
    String? hintText,
    required bool isFocused,
    TextEditingController? controller,
  }) {
    return (hintText != null || isFocused || (controller != null && controller.text.isNotEmpty)) ? 1 : 2;
  }
}
