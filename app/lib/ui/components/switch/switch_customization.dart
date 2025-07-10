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
class _SwitchCustomization extends InheritedWidget {
  const _SwitchCustomization({
    required super.child,
    required this.data,
  });

  final SwitchCustomizationState data;

  @override
  bool updateShouldNotify(_SwitchCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class SwitchCustomization extends StatefulWidget {
  const SwitchCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  SwitchCustomizationState createState() => SwitchCustomizationState();

  static SwitchCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_SwitchCustomization>())?.data;
  }
}

/// Button customization state management
class SwitchCustomizationState extends CustomizationWidgetState<SwitchCustomization> {
  late final ErrorState errorState;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState, enabledState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Getter to determine if the 'Enabled' state should be disabled based on the 'Error' state.
  bool get isEnabledWhenError {
    return SwitchErrorCases.isEnabledWhenError(errorState.value);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenEnabled {
    return SwitchErrorCases.isErrorWhenEnabled(hasEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return _SwitchCustomization(
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
class SwitchErrorCases {
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
}
