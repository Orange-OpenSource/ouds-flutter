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

/// Superclass for customization widget states
abstract class CustomizationWidgetState<T extends StatefulWidget> extends State<T> {
  late final EnabledState enabledState;
  late final OnColoredBoxState onColoredBoxState;
  late final TextState textState;
  late final SelectState selectState;

  @override
  void initState() {
    super.initState();
    enabledState = EnabledState(setState);
    onColoredBoxState = OnColoredBoxState(setState);
    textState = TextState(setState);
    selectState = SelectState(setState);
  }

  // Proxy getters and setters to expose state values directly
  bool get hasEnabled => enabledState.value;
  set hasEnabled(bool value) => enabledState.value = value;

  bool get hasOnColoredBox => onColoredBoxState.value;
  set hasOnColoredBox(bool value) => onColoredBoxState.value = value;

  String get textValue => textState.value;
  set textValue(String value) => textState.value = value;

  bool get hasSelected => selectState.value;
  set hasSelected(bool value) => selectState.value = value;
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
  String _textValue = "Button";

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