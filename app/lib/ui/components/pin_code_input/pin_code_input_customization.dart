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
  late final OutlinedState outlinedState;
  late final ConstrainedMaxWidthState constrainedMaxWidthState;

  @override
  void initState() {
    super.initState();
    errorState = ErrorState(setState);
    hiddenPasswordState = HiddenPasswordState(setState);
    pinCodeHasHelperTextState = PinCodeHasHelperTextState(setState);
    pinCodeErrorTextState = PinCodeErrorTextState(setState);
    pinCodePlaceholderTextState = PinCodePlaceholderTextState(setState);
    roundedCornerState = RoundedCornerState(setState);
    outlinedState = OutlinedState(setState);
    constrainedMaxWidthState = ConstrainedMaxWidthState(setState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // There is a circular dependency between PinCodeHelperTextState and PinCodeLengthState.
    // To resolve this, we first create PinCodeLengthState with a temporary null helper reference,
    // then create PinCodeHelperTextState, and finally link the helper back to the length state.
    // This ensures both instances are properly initialized without breaking the cycle.
    pinCodeLengthState = PinCodeLengthState(
      setState,
      context,
      null,
    );
    pinCodeHelperTextState = PinCodeHelperTextState(
      setState,
      context,
      pinCodeLengthState,
    );
    pinCodeLengthState.pinCodeHelperTextState = pinCodeHelperTextState;
  }

  // Proxy getters and setters to expose the 'constrainedMaxWidthState' value directly.
  bool get hasConstrainedMaxWidth => constrainedMaxWidthState.value;
  set hasConstrainedMaxWidth(bool value) => constrainedMaxWidthState.value = value;

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

  // Proxy getters and setters to expose state values directly
  bool get hasOutlined => outlinedState.value;
  set hasOutlined(bool value) => outlinedState.value = value;

  @override
  Widget build(BuildContext context) {
    return _PinCodeInputCustomization(
      data: this,
      child: widget.child,
    );
  }
}

/// Constrained Max Width State Management
class ConstrainedMaxWidthState {
  ConstrainedMaxWidthState(this._setState);

  final void Function(void Function()) _setState;

  bool _constrainedMaxWidth = false;
  bool get value => _constrainedMaxWidth;

  set value(bool newValue) {
    _setState(() {
      _constrainedMaxWidth = newValue;
    });
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
  PinCodeLengthState(this._setState, this._context, this.pinCodeHelperTextState);

  final void Function(void Function()) _setState;
  final BuildContext _context;
  PinCodeHelperTextState? pinCodeHelperTextState;

  final List<PinCodeLengthEnum> _length = [PinCodeLengthEnum.four, PinCodeLengthEnum.six, PinCodeLengthEnum.eight];

  List<PinCodeLengthEnum> get list => _length;

  PinCodeLengthEnum _selected = PinCodeLengthEnum.six;
  PinCodeLengthEnum get selected => _selected;
  set selected(PinCodeLengthEnum newValue) {
    _setState(() {
      _selected = newValue;
      pinCodeHelperTextState?.value = PinCodeLengthEnum.getHelperText(_context, _selected);
    });
  }
}

/// HelperText State Management
class PinCodeHelperTextState {
  final void Function(void Function()) _setState;
  final BuildContext _context;
  final PinCodeLengthState pinCodeLengthState;

  late final String _helperText;
  late String _helperTextValue;

  PinCodeHelperTextState(this._setState, this._context, this.pinCodeLengthState) {
    _helperText = PinCodeLengthEnum.getHelperText(_context, pinCodeLengthState.selected);
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
