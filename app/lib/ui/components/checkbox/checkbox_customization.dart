import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _CheckboxCustomization extends InheritedWidget {
  const _CheckboxCustomization({
    required super.child,
    required this.data,
  });

  final CheckboxCustomizationState data;

  @override
  bool updateShouldNotify(_CheckboxCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class CheckboxCustomization extends StatefulWidget {
  const CheckboxCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  CheckboxCustomizationState createState() => CheckboxCustomizationState();

  static CheckboxCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_CheckboxCustomization>())?.data;
  }
}

/// Button customization state management
class CheckboxCustomizationState extends CustomizationWidgetState<CheckboxCustomization> {
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
    return CheckboxErrorCases.isEnabledWhenError(errorState.value);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenEnabled {
    return CheckboxErrorCases.isErrorWhenEnabled(hasEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return _CheckboxCustomization(
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
class CheckboxErrorCases {
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
