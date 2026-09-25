//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/tinted_enum.dart';

/// Superclass for customization widget states
abstract class CustomizationWidgetState<T extends StatefulWidget>
    extends State<T> {
  late final EnabledState enabledState;
  late final ReadOnlyState readOnlyState;
  late final OnColoredBoxState onColoredBoxState;
  late final TextState textState;
  late final SelectState selectState;
  late final CenterAlignedState centerAlignedState;
  late final EdgeState edgeToEdgeState;
  late final TintedState tintedState;

  @override
  void initState() {
    super.initState();
    enabledState = EnabledState(setState);
    readOnlyState = ReadOnlyState(setState);
    onColoredBoxState = OnColoredBoxState(setState);
    textState = TextState(setState);
    selectState = SelectState(setState);
    //needed for top bars
    centerAlignedState = CenterAlignedState(setState);
    edgeToEdgeState = EdgeState(setState, initial: true);
    tintedState = TintedState(setState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasEnabled => enabledState.value;
  set hasEnabled(bool value) => enabledState.value = value;

  // Proxy getters and setters to expose state values directly
  bool get hasReadOnly => readOnlyState.value;
  set hasReadOnly(bool value) => readOnlyState.value = value;

  bool get hasOnColoredBox => onColoredBoxState.value;
  set hasOnColoredBox(bool value) => onColoredBoxState.value = value;

  String get textValue => textState.value;
  set textValue(String value) => textState.value = value;

  bool get hasSelected => selectState.value;
  set hasSelected(bool value) => selectState.value = value;

  bool get hasCentredAligned => centerAlignedState.value;
  set hasCentredAligned(bool value) => centerAlignedState.value = value;

  bool get edgeToEdge => edgeToEdgeState.value;
  set edgeToEdge(bool value) => edgeToEdgeState.value = value;

  bool get isTinted => tintedState.selected == TintedEnum.tinted;

  TintedEnum get selectedTinted => tintedState.selected;
  set selectedTinted(TintedEnum value) => tintedState.selected = value;
}

/// Enabled State Management
class EnabledState {
  EnabledState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasEnabled = true;

  bool get value => _hasEnabled;
  set value(bool newValue) {
    _setState(() {
      _hasEnabled = newValue;
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

/// OnColoredBox State Management
class OnColoredBoxState {
  OnColoredBoxState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasOnColoredBox = false;

  bool get value => _hasOnColoredBox;
  set value(bool newValue) {
    _setState(() {
      _hasOnColoredBox = newValue;
    });
  }
}

/// Text State Management
class TextState {
  TextState(this._setState);

  final void Function(void Function()) _setState;
  String _textValue = "Label";

  String get value => _textValue;
  set value(String newValue) {
    _setState(() {
      _textValue = newValue;
    });
  }
}

/// Select State Management
class SelectState {
  SelectState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasSelected = false;

  bool get value => _hasSelected;
  set value(bool newValue) {
    _setState(() {
      _hasSelected = newValue;
    });
  }
}

/// Center aligned State Management
class CenterAlignedState {
  CenterAlignedState(this._setState);

  final void Function(void Function()) _setState;
  bool _hasCentredAligned = false;

  bool get value => _hasCentredAligned;
  set value(bool newValue) {
    _setState(() {
      _hasCentredAligned = newValue;
    });
  }
}

/// Edge to edge state management
class EdgeState {
  EdgeState(this._setState, {bool initial = false}) : _value = initial;

  final void Function(void Function()) _setState;
  bool _value;

  bool get value => _value;
  set value(bool newValue) {
    _setState(() {
      _value = newValue;
    });
  }
}

/// Controls whether the icon displayed in the component such as [OudsLink.icon], [OudsButton] should be tinted
/// with the theme color, or shown with its original colors.
class TintedState {
  TintedState(this._setState);

  final void Function(void Function()) _setState;

  final List<TintedEnum> _tintedList = [TintedEnum.tinted, TintedEnum.untinted];
  TintedEnum _selectedTinted = TintedEnum.tinted;

  List<TintedEnum> get list => _tintedList;

  TintedEnum get selected => _selectedTinted;
  set selected(TintedEnum newValue) {
    _setState(() {
      _selectedTinted = newValue;
    });
  }
}
