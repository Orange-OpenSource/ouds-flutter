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
  late final LabelTextState labelTextState;
  late final HelperLabelTextState helperLabelTextState;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState, enabledState);
    iconState = IconState(setState);
    dividerState = DividerState(setState);
    readOnlyState = ReadOnlyState(setState);
    invertedState = InvertedState(setState);
    labelTextState = LabelTextState(setState);
    helperLabelTextState = HelperLabelTextState(setState);
  }

  // Proxy getters and setters to expose the 'errorState' value directly.
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Proxy getters and setters to expose the 'iconState' value directly.
  bool get hasIcon => iconState.value;
  set hasIcon(bool value) => iconState.value = value;

  // Proxy getters and setters to expose the 'dividerState' value directly.
  bool get hasDivider => dividerState.value;
  set hasDivider(bool value) => dividerState.value = value;

  // Proxy getters and setters to expose the 'invertedState' value directly.
  bool get hasInverted => invertedState.value;
  set hasInverted(bool value) => invertedState.value = value;

  // Proxy getters and setters to expose the 'readOnlyState' value directly.
  bool get hasReadOnly => readOnlyState.value;
  set hasReadOnly(bool value) => readOnlyState.value = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  // Proxy getters and setters to expose the 'helperLabelTextState' value directly.
  String get helperLabelText => helperLabelTextState.value;
  set helperLabelText(String value) => helperLabelTextState.value = value;

  // Getter to determine if the 'Enabled' state should be disabled based on the current 'Error' state.
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

  bool _hasIcon = false;
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

  bool _hasDivider = false;
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

/// LabelText State Management
class LabelTextState {
  LabelTextState(this._setState);

  final void Function(void Function()) _setState;
  String _labelTextValue = "Label";

  String get value => _labelTextValue;
  set value(String newValue) {
    _setState(() {
      _labelTextValue = newValue;
    });
  }
}

/// HelperLabelText State Management
class HelperLabelTextState {
  HelperLabelTextState(this._setState);

  final void Function(void Function()) _setState;
  String _helperLabelTextValue = "";

  String get value => _helperLabelTextValue;
  set value(String newValue) {
    _setState(() {
      _helperLabelTextValue = newValue;
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
