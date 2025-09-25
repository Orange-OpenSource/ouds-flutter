import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/components/pin_code_input/pin_code_input_enum.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree
class _PinCodeInputCustomization extends InheritedWidget {
  const _PinCodeInputCustomization({
    required super.child,
    required this.data,
  });

  final PinCodeInputCustomizationState data;

  @override
  bool updateShouldNotify(_PinCodeInputCustomization oldWidget) => true;
}

/// Main Widget class for PinCodeInput customization
class PinCodeInputCustomization extends StatefulWidget {
  const PinCodeInputCustomization({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  PinCodeInputCustomizationState createState() => PinCodeInputCustomizationState();

  static PinCodeInputCustomizationState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_PinCodeInputCustomization>())?.data;
  }
}

/// TextInput customization state management
class PinCodeInputCustomizationState extends CustomizationWidgetState<PinCodeInputCustomization> {
  late final ErrorState errorState;
  late final HiddenPasswordState hiddenPasswordState;
  late final PinCodeHelperTextState pinCodeHelperTextState;
  late final PinCodeLengthState pinCodeLengthState;
  late final PinCodeHasHelperTextState pinCodeHasHelperTextState;
  late final PinCodeErrorTextState pinCodeErrorTextState;
  late final PinCodePlaceholderTextState pinCodePlaceholderTextState;
  late final RoundedCornerState roundedCornerState;
  late final StyleState styleState;


  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState);
    hiddenPasswordState = HiddenPasswordState(setState);
    pinCodeLengthState = PinCodeLengthState(setState);
    pinCodeHasHelperTextState = PinCodeHasHelperTextState(setState);
    pinCodeErrorTextState = PinCodeErrorTextState(setState);
    pinCodePlaceholderTextState = PinCodePlaceholderTextState(setState);
    roundedCornerState = RoundedCornerState(setState);
    styleState = StyleState(setState);

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pinCodeHelperTextState = PinCodeHelperTextState(setState,context,pinCodeLengthState.selected);
  }
  // Proxy getters and setters to expose state values directly
  bool get hasError => errorState.value;
  set hasError(bool value) => errorState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasHiddenPassword => hiddenPasswordState.value;
  set hasHiddenPassword(bool value) => hiddenPasswordState.value = value;

  PinCodeLengthEnum get selectedPinCodeLength => pinCodeLengthState.selected;
  set selectedPinCodeLength(PinCodeLengthEnum value) => pinCodeLengthState.selected = value;

  // Proxy getters and setters to expose state values directly
  bool get hasRoundedCorner => roundedCornerState.value;
  set hasRoundedCorner(bool value) => roundedCornerState.value = value;

  // Proxy getters and setters to expose the 'helperText' for pin code input value directly.
  String get pinCodeHelperText => pinCodeHelperTextState.value;
  set pinCodeHelperText(String value) => pinCodeHelperTextState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasHelperText => pinCodeHasHelperTextState.value;
  set hasHelperText(bool value) => pinCodeHasHelperTextState.value = value;

  // Proxy getters and setters to expose the 'error text' for pin code input value directly.
  String get pinCodeErrorText => pinCodeErrorTextState.value;
  set pinCodeErrorText(String value) => pinCodeErrorTextState.value = value;

  // Proxy getters and setters to expose the 'pinCodePlaceholderText' value directly.
  String get pinCodePlaceholderText => pinCodePlaceholderTextState.value;
  set pinCodePlaceholderText(String value) => pinCodePlaceholderTextState.value = value;

  PinCodeInputEnumStyle get selectedStyle => styleState.selected;
  set selectedStyle(PinCodeInputEnumStyle value) => styleState.selected = value;

  @override
  Widget build(BuildContext context) {
    return _PinCodeInputCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Error State Management
class ErrorState {
  ErrorState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasError = false;

  bool get value => _hasError;
  set value(bool newValue) {
    _setState(() {
      _hasError = newValue;
    });
  }
}

/// hidden password State Management
class HiddenPasswordState {
  HiddenPasswordState(this._setState);

  final void Function(void Function()) _setState;
  bool _hiddenPassword = true;

  bool get value => _hiddenPassword;
  set value(bool newValue) {
    _setState(() {
      _hiddenPassword = newValue;
    });
  }
}


/// Length of Pin Code Input State Management
class PinCodeLengthState {
  PinCodeLengthState(this._setState);

  final void Function(void Function()) _setState;

  final List<PinCodeLengthEnum> _length = [
    PinCodeLengthEnum.four,
    PinCodeLengthEnum.six,
    PinCodeLengthEnum.eight
  ];

  List<PinCodeLengthEnum> get list => _length;

  PinCodeLengthEnum _selected = PinCodeLengthEnum.six;
  PinCodeLengthEnum get selected => _selected;
  set selected(PinCodeLengthEnum newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}


/// HelperText State Management
class PinCodeHelperTextState {
  final void Function(void Function()) _setState;
  final BuildContext _context;
  final PinCodeLengthEnum _selectedPinCodeState;

  late final String _helperText;
  late String _helperTextValue;

  PinCodeHelperTextState(this._setState, this._context, this._selectedPinCodeState) {
    _helperText = PinCodeLengthEnum.getHelperText(_context, _selectedPinCodeState);
    _helperTextValue = _helperText;
  }

  String get value => _helperTextValue;
  set value(String newValue) {
    _setState(() {
      _helperTextValue = newValue;
    });
  }
}

class PinCodeHasHelperTextState {
  PinCodeHasHelperTextState(this._setState);
  final void Function(void Function()) _setState;

  bool _hasHelperText = false;

  bool get value => _hasHelperText;

  set value(bool newValue) {
    _setState(() {
      _hasHelperText = newValue;
    });
  }
}

/// Pincode ErrorText State Management
class PinCodeErrorTextState {
  PinCodeErrorTextState(this._setState);
  final void Function(void Function()) _setState;

  String _errorTextValue = "";

  String get value => _errorTextValue;
  set value(String newValue) {
    _setState(() {
      _errorTextValue = newValue;
    });
  }
}

/// PlaceHolderText State Management
class PinCodePlaceholderTextState {
  PinCodePlaceholderTextState(this._setState);

  final void Function(void Function()) _setState;

  String _placeholderTextValue = "-";
  String get value => _placeholderTextValue;

  set value(String newValue) {
    _setState(() {
      _placeholderTextValue = newValue;
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

// Style State Management
class StyleState {
  StyleState(this._setState);
  final void Function(VoidCallback) _setState;

  final List<PinCodeInputEnumStyle> _style = [
    PinCodeInputEnumStyle.defaultStyle,
    PinCodeInputEnumStyle.alternative,
  ];

  List<PinCodeInputEnumStyle> get list => _style;

  PinCodeInputEnumStyle _selected = PinCodeInputEnumStyle.defaultStyle;
  PinCodeInputEnumStyle get selected => _selected;
  set selected(PinCodeInputEnumStyle newValue) {
    _setState(() {
      _selected = newValue;
    });
  }
}
