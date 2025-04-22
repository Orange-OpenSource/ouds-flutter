import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _ControlItemCustomization extends InheritedWidget {
  const _ControlItemCustomization({
    required super.child,
    required this.data,
  });

  final ControlItemCustomizationState data;

  @override
  bool updateShouldNotify(_ControlItemCustomization oldWidget) => true;
}

/// Main Widget class for button customization
class ControlItemCustomization extends StatefulWidget {
  const ControlItemCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ControlItemCustomizationState createState() => ControlItemCustomizationState();

  static ControlItemCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_ControlItemCustomization>())?.data;
  }
}

/// Button customization state management
class ControlItemCustomizationState extends CustomizationWidgetState<ControlItemCustomization> {
  late final ErrorState errorState;
  late final IconState iconState;
  late final DividerState dividerState;
  late final ReadOnlyState readOnlyState;
  late final InvertedState invertedState;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState, enabledState);
    iconState = IconState(setState);
    dividerState = DividerState(setState);
    readOnlyState = ReadOnlyState(setState);
    invertedState = InvertedState(setState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasIcon => iconState.value;
  set hasIcon(bool value) => iconState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasDivider => dividerState.value;
  set hasDivider(bool value) => dividerState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasInverted => invertedState.value;
  set hasInverted(bool value) => invertedState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasReadOnly => readOnlyState.value;
  set hasReadOnly(bool value) => readOnlyState.value = value;

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
    return _ControlItemCustomization(
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

/// Icon State Management
class IconState {
  IconState(this._setState);

  final void Function(void Function()) _setState;

  bool _hasIcon = true;
  bool get value => _hasIcon;

  set value(bool newValue) {
    _setState(() {
      _hasIcon = newValue;
    });
  }
}

/// Divider State Management
class DividerState {
  DividerState(this._setState);

  final void Function(void Function()) _setState;

  bool _hasDivider = true;
  bool get value => _hasDivider;

  set value(bool newValue) {
    _setState(() {
      _hasDivider = newValue;
    });
  }
}

/// ReadOnly State Management
class ReadOnlyState {
  ReadOnlyState(this._setState);

  final void Function(void Function()) _setState;

  bool _hasReadOnly = false;
  bool get value => _hasReadOnly;

  set value(bool newValue) {
    _setState(() {
      _hasReadOnly = newValue;
    });
  }
}

/// InvertedState State Management
class InvertedState {
  InvertedState(this._setState);

  final void Function(void Function()) _setState;

  bool _hasInverted = false;
  bool get value => _hasInverted;

  set value(bool newValue) {
    _setState(() {
      _hasInverted = newValue;
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
