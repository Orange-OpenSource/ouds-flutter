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
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _RadioButtonCustomization extends InheritedWidget {
  const _RadioButtonCustomization({
    required super.child,
    required this.data,
  });

  final RadioButtonCustomizationState data;

  @override
  bool updateShouldNotify(_RadioButtonCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class RadioButtonCustomization extends StatefulWidget {
  const RadioButtonCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  RadioButtonCustomizationState createState() => RadioButtonCustomizationState();

  static RadioButtonCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_RadioButtonCustomization>())?.data;
  }
}

/// Button customization state management
class RadioButtonCustomizationState extends CustomizationWidgetState<RadioButtonCustomization> {
  late final ErrorState errorState;
  late final ReadOnlyState readOnly;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState, enabledState);
    readOnly = ReadOnlyState(setState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Proxy getters and setters to expose state values directly
  @override
  bool get hasReadOnly => readOnly.value;
  @override
  set hasReadOnly(bool value) => readOnly.value = value;

  // Getter to determine if the 'Enabled' state should be disabled based on the 'Error' state.
  bool get isEnabledWhenError {
    return RadioButtonErrorCases.isEnabledWhenError(errorState.value);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenEnabled {
    return RadioButtonErrorCases.isErrorWhenEnabled(hasEnabled);
  }

  // Getter to determine if the 'Enabled' state should be disabled based on the current 'Error' state.
  bool get isReadOnlyWhenError {
    return RadioButtonErrorCases.isReadOnlyWhenError(errorState.value);
  }

  // Getter to determine if the 'ReadOnly' state should be disabled based on the current 'Enabled' state.
  bool get isReadOnlyWhenEnabled {
    return RadioButtonErrorCases.isReadOnlyWhenEnabled(hasEnabled);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenReadOnly {
    return RadioButtonErrorCases.isErrorWhenReadOnly(hasReadOnly);
  }

  @override
  Widget build(BuildContext context) {
    return _RadioButtonCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Error State Management
class ErrorState {
  ErrorState(this._setState, this.enabledState);

  final void Function(void Function()) _setState;
  final EnabledState enabledState;
  bool _hasError = false;

  bool get value => _hasError;
  set value(bool newValue) {
    _setState(() {
      _hasError = newValue;
    });
  }
}

/// Error handling for specific button behavior
class RadioButtonErrorCases {
  /// Checks if the 'Enabled' button should be enabled based on the 'error' parameter.
  ///
  /// Enabled behavior: The 'Enabled' button is disabled if the 'error' parameter is true.
  ///
  /// @param [hasError] Indicates whether the 'error' parameter is true.
  /// @return true if the 'Enabled' button should be activated, otherwise false.
  static bool isEnabledWhenError(bool hasError) {
    return hasError;
  }

  /// Checks if the 'Error' button should be disabled when the 'Enabled' button is activated.
  ///
  /// Error behavior: The 'Error' button is disabled if the 'enabled' parameter is false.
  ///
  /// @param [hasEnabled] Indicates whether the 'enabled' parameter is true.
  /// @return true if an error is present, otherwise false.
  static bool isErrorWhenEnabled(bool hasEnabled) {
    return !hasEnabled;
  }

  /// Determines if the control item should be read-only based on the 'hasError' parameter.
  ///
  /// Behavior: The control item is read-only if 'hasError' is true.
  ///
  /// @param [hasError] Indicates whether an error is present (true) or not (false).
  /// @return true if the control item should be read-only, otherwise false.
  static bool isReadOnlyWhenError(bool hasError) {
    return hasError;
  }

  /// Checks if the 'ReadOnly' control item should be disabled when the 'Enabled' control item is activated.
  ///
  /// Behavior: The 'ReadOnly' control item is disabled if 'hasEnabled' is false.
  ///
  /// @param [hasEnabled] Indicates whether the 'Enabled' control item is activated (true) or not (false).
  /// @return true if the 'ReadOnly' control item should be disabled, otherwise false.
  static bool isReadOnlyWhenEnabled(bool hasEnabled) {
    return !hasEnabled;
  }

  /// Checks if the 'Error' control item should be activated based on the 'hasReadOnly' parameter.
  ///
  /// Behavior: The 'Error' control item is activated if 'hasReadOnly' is true.
  ///
  /// @param [hasReadOnly] Indicates whether the control item is read-only (true) or not (false).
  /// @return true if the 'Error' control item should be activated, otherwise false.
  static bool isErrorWhenReadOnly(bool hasReadOnly) {
    return hasReadOnly;
  }
}
