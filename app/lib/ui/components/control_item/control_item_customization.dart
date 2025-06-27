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
  late final OutlinedState outlinedState;
  late final ReadOnlyState readOnlyState;
  late final InvertedState invertedState;
  late final LabelTextState labelTextState;
  late final AdditionalLabelTextState additionalLabelTextState;
  late final HelperLabelTextState helperLabelTextState;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState, enabledState);
    iconState = IconState(setState);
    dividerState = DividerState(setState);
    outlinedState = OutlinedState(setState);
    readOnlyState = ReadOnlyState(setState);
    invertedState = InvertedState(setState);
    labelTextState = LabelTextState(setState);
    additionalLabelTextState = AdditionalLabelTextState(setState);
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

  // Proxy getters and setters to expose the 'outlinedState' value directly.
  bool get hasOutlined => outlinedState.value;
  set hasOutlined(bool value) => outlinedState.value = value;

  // Proxy getters and setters to expose the 'invertedState' value directly.
  bool get hasReversed => invertedState.value;
  set hasReversed(bool value) => invertedState.value = value;

  // Proxy getters and setters to expose the 'readOnlyState' value directly.
  bool get hasReadOnly => readOnlyState.value;
  set hasReadOnly(bool value) => readOnlyState.value = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  // Proxy getters and setters to expose the 'additionalLabelTextState' value directly.
  String get additionalLabelText => additionalLabelTextState.value;
  set additionalLabelText(String value) => additionalLabelTextState.value = value;

  // Proxy getters and setters to expose the 'helperLabelTextState' value directly.
  String get helperLabelText => helperLabelTextState.value;
  set helperLabelText(String value) => helperLabelTextState.value = value;

  // Getter to determine if the 'Enabled' state should be disabled based on the current 'Error' state.
  bool get isEnabledWhenError {
    return CheckboxErrorCases.isEnabledWhenError(errorState.value);
  }

  // Getter to determine if the 'Enabled' state should be disabled based on the current 'ReadOnly' state.
  bool get isEnabledWhenReadOnly {
    return CheckboxErrorCases.isEnabledWhenReadOnly(hasReadOnly);
  }

  // Getter to determine if the 'Enabled' state should be disabled based on the current 'Error' state.
  bool get isReadOnlyWhenError {
    return CheckboxErrorCases.isReadOnlyWhenError(errorState.value);
  }

  // Getter to determine if the 'ReadOnly' state should be disabled based on the current 'Enabled' state.
  bool get isReadOnlyWhenEnabled {
    return CheckboxErrorCases.isReadOnlyWhenEnabled(hasEnabled);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenEnabled {
    return CheckboxErrorCases.isErrorWhenEnabled(hasEnabled);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenReadOnly {
    return CheckboxErrorCases.isErrorWhenReadOnly(hasReadOnly);
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

  bool _hasDivider = true;
  bool get value => _hasDivider;

  set value(bool newValue) {
    _setState(() {
      _hasDivider = newValue;
    });
  }
}

// Outlined State Management
class OutlinedState {
  OutlinedState(this._setState);

  final void Function(void Function()) _setState;

  bool _hasOutlined = false;
  bool get value => _hasOutlined;

  set value(bool newValue) {
    _setState(() {
      _hasOutlined = newValue;
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

  bool _hasInverted = true;
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

/// Additional State Management
class AdditionalLabelTextState {
  AdditionalLabelTextState(this._setState);

  final void Function(void Function()) _setState;
  String _additionalLabelTextValue = "";

  String get value => _additionalLabelTextValue;
  set value(String newValue) {
    _setState(() {
      _additionalLabelTextValue = newValue;
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

/// Class for handling error cases related to control item behavior.
class CheckboxErrorCases {
  /// Determines if the 'Enabled' control item should be activated based on the 'hasError' parameter.
  ///
  /// Behavior: The 'Enabled' control item is disabled if 'hasError' is true.
  ///
  /// @param [hasError] Indicates whether an error is present (true) or not (false).
  /// @return true if the 'Enabled' control item should be activated, otherwise false.
  static bool isEnabledWhenError(bool hasError) {
    return hasError;
  }

  /// Determines if the 'Enabled' control item should be activated based on the 'hasReadOnly' parameter.
  ///
  /// Behavior: The 'Enabled' control item is activated if 'hasReadOnly' is true.
  ///
  /// @param [hasReadOnly] Indicates whether a read-only state is present (true) or not (false).
  /// @return true if the 'Enabled' control item should be activated, otherwise false.
  static bool isEnabledWhenReadOnly(bool hasReadOnly) {
    return hasReadOnly;
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

  /// Checks if the 'Error' control item should be disabled when the 'Enabled' control item is activated.
  ///
  /// Behavior: The 'Error' control item is disabled if 'hasEnabled' is false.
  ///
  /// @param [hasEnabled] Indicates whether the 'Enabled' control item is activated (true) or not (false).
  /// @return true if the 'Error' control item should be disabled, otherwise false.
  static bool isErrorWhenEnabled(bool hasEnabled) {
    return !hasEnabled;
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
