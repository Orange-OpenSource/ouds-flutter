import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/form_input/form_fields_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _FormFieldsCustomization extends InheritedWidget {
  const _FormFieldsCustomization({
    required super.child,
    required this.data,
  });

  final FormFieldsCustomizationState data;

  @override
  bool updateShouldNotify(_FormFieldsCustomization oldWidget) => true;
}

/// Main Widget class for TextInput customization
class FormFieldsCustomization extends StatefulWidget {
  const FormFieldsCustomization({
    super.key,
    required this.child,
    required this.inputType,
  });

  final Widget child;
  final FormFieldsTypeEnum inputType;

  @override
  FormFieldsCustomizationState createState() => FormFieldsCustomizationState();

  static FormFieldsCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_FormFieldsCustomization>())?.data;
  }
}

/// TextInput customization state management
class FormFieldsCustomizationState extends CustomizationWidgetState<FormFieldsCustomization> {
  late final ErrorState errorState;
  late final LeadingIconState leadingIconState;
  late final TrailingIconState trailingIconState;
  late final LoaderState loaderState;
  late final OutlinedState outlinedState;
  late final LabelTextState labelTextState;
  late final PrefixTextState prefixTextState;
  late final SuffixTextState suffixTextState;
  late final PlaceholderTextState placeholderTextState;
  late final HelperTextState helperTextState;
  late final RoundedCornerState roundedCornerState;
  late final CountrySelectorState countrySelectorState;

  @override
  void initState() {
    super.initState();
    loaderState = LoaderState(setState);
    errorState = ErrorState(setState, enabledState, loaderState, readOnlyState);
    leadingIconState = LeadingIconState(setState);
    trailingIconState = TrailingIconState(setState);
    outlinedState = OutlinedState(setState);
    labelTextState = LabelTextState(setState, widget.inputType);
    prefixTextState = PrefixTextState(setState);
    suffixTextState = SuffixTextState(setState);
    placeholderTextState = PlaceholderTextState(setState, loaderState);
    helperTextState = HelperTextState(setState, widget.inputType);
    roundedCornerState = RoundedCornerState(setState);
    countrySelectorState = CountrySelectorState(setState, leadingIconState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Getter to determine if the 'Enabled' state should be disabled based on the 'Error' state.
  bool get isEnabledWhenError {
    return FormFieldsErrorCases.isEnabledWhenError(errorState.value);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenEnabled {
    return FormFieldsErrorCases.isErrorWhenEnabled(hasEnabled);
  }

  // Getter to determine if the widget should be enabled when the placeholder text is not empty.
  bool get isEnabledWhenPlaceHolderIsNotEmpty {
    return FormFieldsErrorCases.isEnabledWhenPlaceHolderIsNotEmpty(placeholderTextState);
  }

  /// Phone Number Input
  // Proxy getters and setters to expose the 'Country Selector' value directly.
  bool get hasCountrySelector => countrySelectorState.value;
  set hasCountrySelector(bool value) => countrySelectorState.value = value;

  // Getter to determine if the 'Error' state should be disabled based on the 'Loader' state.
  bool get isErrorWhenLoader {
    return FormFieldsErrorCases.isErrorWhenLoader(hasLoader);
  }

  bool get isLoaderWhenError {
    return FormFieldsErrorCases.isLoaderWhenError(errorState.value);
  }

  bool get isLoaderWhenEnabled {
    return FormFieldsErrorCases.isLoaderWhenEnabled(hasEnabled);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Loader' state.
  bool get isReadOnlyWhenError {
    return FormFieldsErrorCases.isLoaderWhenError(errorState.value);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Loader' state.
  bool get isErrorWhenReadOnly {
    return FormFieldsErrorCases.isErrorWhenReadOnly(hasReadOnly);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasLeadingIcon => leadingIconState.value;
  set hasLeadingIcon(bool value) => leadingIconState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasTrailingIcon => trailingIconState.value;
  set hasTrailingIcon(bool value) => trailingIconState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasLoader => loaderState.value;
  set hasLoader(bool value) => loaderState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasOutlined => outlinedState.value;
  set hasOutlined(bool value) => outlinedState.value = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  // Proxy getters and setters to expose the 'prefixTextState' value directly.
  String get prefixText => prefixTextState.value;
  set prefixText(String value) => prefixTextState.value = value;

  // Proxy getters and setters to expose the 'suffixTextState' value directly.
  String get suffixText => suffixTextState.value;
  set suffixText(String value) => suffixTextState.value = value;

  // Proxy getters and setters to expose the 'placeholderText' value directly.
  String get placeholderText => placeholderTextState.value;
  set placeholderText(String value) => placeholderTextState.value = value;

  // Proxy getters and setters to expose the 'helperText' value directly.
  String get helperText => helperTextState.value;
  set helperText(String value) => helperTextState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasRoundedCorner => roundedCornerState.value;
  set hasRoundedCorner(bool value) => roundedCornerState.value = value;

  @override
  Widget build(BuildContext context) {
    return _FormFieldsCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Error State Management
class ErrorState {
  ErrorState(this._setState, this.enabledState, this.loaderState, this.readOnlyState);

  final void Function(void Function()) _setState;
  final EnabledState enabledState;
  final LoaderState loaderState;
  final ReadOnlyState readOnlyState;
  bool _hasError = false;

  bool get value => _hasError;
  set value(bool newValue) {
    _setState(() {
      _hasError = newValue;
    });
  }
}

/// LeadingIcon State Management
class LeadingIconState {
  LeadingIconState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasLeadingIcon = false;

  bool get value => _hasLeadingIcon;
  set value(bool newValue) {
    _setState(() {
      _hasLeadingIcon = newValue;
    });
  }
}

/// TrailingIcon State Management
class TrailingIconState {
  TrailingIconState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasTrailingIcon = false;

  bool get value => _hasTrailingIcon;
  set value(bool newValue) {
    _setState(() {
      _hasTrailingIcon = newValue;
    });
  }
}

/// Outlined State Management
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

/// Loader State Management
class LoaderState {
  LoaderState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasLoader = false;

  bool get value => _hasLoader;
  set value(bool newValue) {
    _setState(() {
      _hasLoader = newValue;
    });
  }
}

/// LabelText State Management
class LabelTextState {
  LabelTextState(this._setState, this.inputType) : _labelTextValue = inputType.labelValue;

  final void Function(void Function()) _setState;
  final FormFieldsTypeEnum inputType;

  String _labelTextValue;

  String get value => _labelTextValue;

  set value(String newValue) {
    _setState(() {
      _labelTextValue = newValue;
    });
  }
}

/// PrefixText State Management
class PrefixTextState {
  PrefixTextState(this._setState);

  final void Function(void Function()) _setState;
  String _prefixTextValue = "";

  String get value => _prefixTextValue;
  set value(String newValue) {
    _setState(() {
      _prefixTextValue = newValue;
    });
  }
}

/// SuffixText State Management
class SuffixTextState {
  SuffixTextState(this._setState);

  final void Function(void Function()) _setState;
  String _suffixTextValue = "";

  String get value => _suffixTextValue;
  set value(String newValue) {
    _setState(() {
      _suffixTextValue = newValue;
    });
  }
}

/// PlaceHolderText State Management
class PlaceholderTextState {
  PlaceholderTextState(this._setState, this._loaderState);

  final void Function(void Function()) _setState;
  final LoaderState _loaderState;

  String _placeholderTextValue = "";
  String get value => _placeholderTextValue;

  set value(String newValue) {
    _setState(() {
      if (newValue.isNotEmpty) {
        _loaderState.value = false;
      }
      _placeholderTextValue = newValue;
    });
  }
}

/// HelperText State Management
class HelperTextState {
  HelperTextState(this._setState, this.inputType) : _helperTextValue = inputType.helperValue;

  final void Function(void Function()) _setState;
  final FormFieldsTypeEnum inputType;

  String _helperTextValue;

  String get value => _helperTextValue;
  set value(String newValue) {
    _setState(() {
      _helperTextValue = newValue;
    });
  }
}

/// RoundedCorner State Management
class RoundedCornerState {
  RoundedCornerState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasRoundedCorner = false;

  bool get value => _hasRoundedCorner;
  set value(bool newValue) {
    _setState(() {
      _hasRoundedCorner = newValue;
    });
  }
}

/// Phone Number Input
/// RoundedCorner State Management
class CountrySelectorState {
  CountrySelectorState(this._setState, this.leadingIconState);

  final void Function(void Function()) _setState;
  bool _hasCountrySelector = true;
  final LeadingIconState leadingIconState;

  bool get value => _hasCountrySelector;
  set value(bool newValue) {
    _setState(() {
      _hasCountrySelector = newValue;
    });
  }
}

/// Error handling for specific button behavior
class FormFieldsErrorCases {
  /// Determines whether the 'Enabled' state should be disabled when an error is present.
  ///
  /// Behavior: If an error is active (`hasError` is `true`), the input should be disabled.
  ///
  /// @param hasError Whether an error is currently active.
  /// @return `true` if the input should be disabled, `false` otherwise.
  static bool isEnabledWhenError(bool hasError) {
    return hasError;
  }

  /// Determines whether the 'Error' state should be activated based on the 'Enabled' state.
  ///
  /// Behavior: If the input is disabled (`hasEnabled` is `false`), an error can be shown.
  ///
  /// @param hasEnabled Whether the input is currently enabled.
  /// @return `true` if the error should be shown, `false` otherwise.
  static bool isErrorWhenEnabled(bool hasEnabled) {
    return !hasEnabled;
  }

  /// Determines whether the 'loader' state should be active based on the 'Enabled' state.
  ///
  /// Behavior: If the input is enabled (`hasEnabled` is `true`), the loader should be active.
  ///
  /// @param hasEnabled Whether the input is currently enabled.
  /// @return `true` if the loader should be active, `false` otherwise.
  static bool isLoaderWhenEnabled(bool hasEnabled) {
    return !hasEnabled;
  }

  /// Determines whether the 'Loader' state should be disabled when an error is present.
  ///
  /// Behavior: If an error is active (`hasError` is `true`), the loader should be hidden.
  ///
  /// @param hasError Whether an error is currently active.
  /// @return `true` if the loader should be disabled, `false` otherwise.
  static bool isLoaderWhenError(bool hasError) {
    return hasError;
  }

  /// Determines whether the 'Error' state should be activated based on the 'Loader' state.
  ///
  /// Behavior: If the loader is active, the error should be displayed.
  ///
  /// @param hasLoader Whether the loader is currently active.
  /// @return `true` if the error should be shown, `false` otherwise.
  static bool isErrorWhenLoader(bool hasLoader) {
    return hasLoader;
  }

  /// Determines whether the 'ReadOnly' state should be enabled when an error is present.
  ///
  /// Behavior: If an error is active (`hasError` is `true`), the input should become read-only.
  ///
  /// @param hasError Whether an error is currently active.
  /// @return `true` if the input should be read-only, `false` otherwise.
  static bool isReadOnlyWhenError(bool hasError) {
    return hasError;
  }

  /// Determines whether the 'Error' state should be activated based on the 'ReadOnly' state.
  ///
  /// Behavior: If the input is read-only, the error state should be shown.
  ///
  /// @param hasReadOnly Whether the input is currently read-only.
  /// @return `true` if the error should be shown, `false` otherwise.
  static bool isErrorWhenReadOnly(bool hasReadOnly) {
    return hasReadOnly;
  }

  /// Determines whether the widget should be enabled based on the presence of placeholder text.
  ///
  /// Behavior: If the placeholder text is not empty, the widget should be enabled.
  /// This can be useful to activate certain features only when a placeholder is provided.
  ///
  /// @param placeholderTextState The current state of the placeholder text.
  /// @return `true` if the placeholder is not empty, indicating the widget should be enabled, `false` otherwise.
  static bool isEnabledWhenPlaceHolderIsNotEmpty(PlaceholderTextState placeholderTextState) {
    return placeholderTextState.value.isNotEmpty;
  }
}
