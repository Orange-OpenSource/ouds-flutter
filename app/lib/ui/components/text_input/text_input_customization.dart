import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/text_input/text_input_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _TextInputCustomization extends InheritedWidget {
  const _TextInputCustomization({
    required super.child,
    required this.data,
  });

  final TextInputCustomizationState data;

  @override
  bool updateShouldNotify(_TextInputCustomization oldWidget) => true;
}

/// Main Widget class for TextInput customization
class TextInputCustomization extends StatefulWidget {
  const TextInputCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  TextInputCustomizationState createState() => TextInputCustomizationState();

  static TextInputCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_TextInputCustomization>())?.data;
  }
}

/// TextInput customization state management
class TextInputCustomizationState extends CustomizationWidgetState<TextInputCustomization> {
  late final ErrorState errorState;
  late final LeadingIconState leadingIconState;
  late final TrailingIconState trailingIconState;
  late final LoaderState loaderState;
  late final StyleState styleState;
  late final LabelTextState labelTextState;
  late final PrefixTextState prefixTextState;
  late final SuffixTextState suffixTextState;
  late final PlaceholderTextState placeholderTextState;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState, enabledState);
    leadingIconState = LeadingIconState(setState);
    trailingIconState = TrailingIconState(setState);
    loaderState = LoaderState(setState);
    styleState = StyleState(setState);
    labelTextState = LabelTextState(setState);
    prefixTextState = PrefixTextState(setState);
    suffixTextState = SuffixTextState(setState);
    placeholderTextState = PlaceholderTextState(setState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Getter to determine if the 'Enabled' state should be disabled based on the 'Error' state.
  bool get isEnabledWhenError {
    return TextInputErrorCases.isEnabledWhenError(errorState.value);
  }

  // Getter to determine if the 'Error' state should be disabled based on the 'Enabled' state.
  bool get isErrorWhenEnabled {
    return TextInputErrorCases.isErrorWhenEnabled(hasEnabled);
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

  TextInputEnumStyle get selectedStyle => styleState.selected;
  set selectedStyle(TextInputEnumStyle value) => styleState.selected = value;

  // Proxy getters and setters to expose the 'labelTextState' value directly.
  String get labelText => labelTextState.value;
  set labelText(String value) => labelTextState.value = value;

  // Proxy getters and setters to expose the 'prefixTextState' value directly.
  String get prefixText => prefixTextState.value;
  set prefixText(String value) => prefixTextState.value = value;

  // Proxy getters and setters to expose the 'suffixTextState' value directly.
  String get suffixText => suffixTextState.value;
  set suffixText(String value) => suffixTextState.value = value;

  // Proxy getters and setters to expose the 'suffixTextState' value directly.
  String get placeholderText => placeholderTextState.value;
  set placeholderText(String value) => placeholderTextState.value = value;

  @override
  Widget build(BuildContext context) {
    return _TextInputCustomization(
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

/// Style State Management
class StyleState {
  StyleState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<TextInputEnumStyle> _style = [
    TextInputEnumStyle.defaultStyle,
    TextInputEnumStyle.alternative,
  ];

  List<TextInputEnumStyle> get list => _style;

  TextInputEnumStyle _selected = TextInputEnumStyle.defaultStyle;
  TextInputEnumStyle get selected => _selected;
  set selected(TextInputEnumStyle newValue) {
    _setState(() {
      _selected = newValue;
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
  PlaceholderTextState(this._setState);

  final void Function(void Function()) _setState;
  String _placeholderTextValue = "";

  String get value => _placeholderTextValue;
  set value(String newValue) {
    _setState(() {
      _placeholderTextValue = newValue;
    });
  }
}

/// Error handling for specific button behavior
class TextInputErrorCases {
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
