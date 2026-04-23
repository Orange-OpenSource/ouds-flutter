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
import 'package:ouds_core/components/bottom_sheet/ouds_bottom_sheet_scaffold.dart';
import 'package:ouds_flutter_demo/ui/utilities/customizable/customizable_widget_state.dart';

/// Section for InheritedWidget to pass data down the widget tree.
class _StandardBottomSheetCustomization extends InheritedWidget {
  const _StandardBottomSheetCustomization({
    required super.child,
    required this.data,
  });

  final StandardBottomSheetCustomizationState data;

  @override
  bool updateShouldNotify(_StandardBottomSheetCustomization old) => true;
}

/// Main widget for standard (scaffold) bottom sheet customization.
///
/// Mirrors `StandardBottomSheetDemoState` from the Android app.
class StandardBottomSheetCustomization extends StatefulWidget {
  const StandardBottomSheetCustomization({super.key, required this.child});

  final Widget child;

  @override
  StandardBottomSheetCustomizationState createState() =>
      StandardBottomSheetCustomizationState();

  static StandardBottomSheetCustomizationState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_StandardBottomSheetCustomization>()
        ?.data;
  }
}

/// The possible expansion states of the standard bottom sheet.
///
/// Mirrors `StandardBottomSheetDemoState.SheetValue` from the Android app.
enum BottomSheetValue { expanded, partiallyExpanded }

/// Customization state for the standard bottom sheet demo.
class StandardBottomSheetCustomizationState
    extends CustomizationWidgetState<StandardBottomSheetCustomization> {
  late final _SheetDragHandleState _sheetDragHandleState;
  late final _SheetSwipeEnabledState _sheetSwipeEnabledState;
  late final _SheetValueState _sheetValueState;
  late final _SheetPeekHeightTextState _sheetPeekHeightTextState;

  @override
  void initState() {
    super.initState();
    _sheetDragHandleState = _SheetDragHandleState(setState);
    _sheetSwipeEnabledState = _SheetSwipeEnabledState(setState);
    _sheetValueState = _SheetValueState(setState);
    _sheetPeekHeightTextState = _SheetPeekHeightTextState(setState);
  }

  /// Whether the drag-handle pill is shown.
  bool get hasSheetDragHandle => _sheetDragHandleState.value;
  set hasSheetDragHandle(bool v) => _sheetDragHandleState.value = v;

  /// Whether swipe gestures are enabled.
  bool get hasSheetSwipeEnabled => _sheetSwipeEnabledState.value;
  set hasSheetSwipeEnabled(bool v) => _sheetSwipeEnabledState.value = v;

  /// Current expansion state of the sheet.
  BottomSheetValue get sheetValue => _sheetValueState.value;
  set sheetValue(BottomSheetValue v) => _sheetValueState.value = v;

  /// The peek height as text (for CustomizableTextField).
  String get sheetPeekHeightText => _sheetPeekHeightTextState.value;
  set sheetPeekHeightText(String v) => _sheetPeekHeightTextState.value = v;

  /// Parsed peek height value. Falls back to default if text is empty/invalid.
  double get sheetPeekHeight {
    if (sheetPeekHeightText.isEmpty) return kOudsBottomSheetPeekHeight;
    final cleaned = sheetPeekHeightText.replaceAll(RegExp(r'[^0-9.]'), '');
    final parsed = double.tryParse(cleaned);
    return (parsed != null && parsed >= 0)
        ? parsed
        : kOudsBottomSheetPeekHeight;
  }

  @override
  Widget build(BuildContext context) {
    return _StandardBottomSheetCustomization(data: this, child: widget.child);
  }
}

class _SheetDragHandleState {
  _SheetDragHandleState(this._setState);
  final void Function(void Function()) _setState;
  bool _value = true;
  bool get value => _value;
  set value(bool v) => _setState(() => _value = v);
}

class _SheetSwipeEnabledState {
  _SheetSwipeEnabledState(this._setState);
  final void Function(void Function()) _setState;
  bool _value = true;
  bool get value => _value;
  set value(bool v) => _setState(() => _value = v);
}

class _SheetValueState {
  _SheetValueState(this._setState);
  final void Function(void Function()) _setState;
  BottomSheetValue _value = BottomSheetValue.partiallyExpanded;
  BottomSheetValue get value => _value;
  set value(BottomSheetValue v) => _setState(() => _value = v);
}

class _SheetPeekHeightTextState {
  _SheetPeekHeightTextState(this._setState);
  final void Function(void Function()) _setState;
  String _value = kOudsBottomSheetPeekHeight.round().toString();
  String get value => _value;
  set value(String v) => _setState(() => _value = v);
}
